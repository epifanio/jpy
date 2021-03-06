FROM andrewosh/binder-base

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

USER root

# Add dependency
RUN echo "root:root" | chpasswd
RUN echo "main:main" | chpasswd

RUN useradd -m -s /bin/bash postgres
RUN echo "postgres:postgres" | chpasswd


ADD install_scripts/install_dep.sh /tmp/
RUN sh /tmp/install_dep.sh
RUN echo "main     ALL=(ALL:ALL) ALL" >> /etc/sudoers

# script for xvfb-run.  all docker commands will effectively run under this via the entrypoint
RUN printf "#\041/bin/sh \n rm -f /tmp/.X99-lock && xvfb-run -s '-screen 0 1600x1200x16' \$@" >> /usr/local/bin/xvfbrun.sh && \
    chmod +x /usr/local/bin/xvfbrun.sh

# Add Julia dependencies
RUN apt-get update
RUN apt-get install -y julia libnettle4 && apt-get clean
#
# Add data directory
# data generated using getdata.sh and then packaged by fpm:
# # fpm -s dir -t deb -n jpy-data -v 0.1 -C /tmp/installdir -p jpy-data_VERSION_ARCH.deb home/

RUN wget http://epinux.com/jpy-data_0.1_amd64.deb
RUN dpkg -i jpy-data_0.1_amd64.deb
RUN rm -rf jpy-data_0.1_amd64.deb
RUN chmod -R 777 /home/main/notebooks/data


USER main

ENV HOME /home/main
ENV SHELL /bin/bash

ENV USER main

WORKDIR $HOME

## install main python packages
ADD install_scripts/conda.sh /tmp/
RUN sh /tmp/conda.sh

# install IOOS packages
ADD install_scripts/conda-IOOS.sh /tmp/
RUN sh /tmp/conda-IOOS.sh

# install pip and other packages from source
ADD install_scripts/install_pip.sh /tmp/
RUN sh /tmp/install_pip.sh


# Install R kernel and basic packages
ADD install_scripts/conda-R.sh /tmp/
RUN sh /tmp/conda-R.sh
RUN /home/main/anaconda2/envs/python3/bin/conda install -c r r-rbokeh


# Install Julia kernel
RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("Gadfly")' && julia -e 'Pkg.add("RDatasets")'

USER root

RUN wget http://epinux.com/grass-gis_7.3-svn_amd64.deb
RUN dpkg -i grass-gis_7.3-svn_amd64.deb
RUN rm -rf grass-gis_7.3-svn_amd64.deb

USER main
ENV PATH /usr/local/grass-7.3.svn/bin:$PATH
ENV GRASS_PNG_AUTO_WRITE TRUE
ENV GRASS_PNG_COMPRESSION 9
ENV GRASS_TRANSPARENT TRUE
ENV GRASS_TRUECOLOR TRUE
ENV GISBASE /usr/local/grass-7.3.svn
ENV GISDBASE /home/main/notebooks/data/grass7data
ENV GISRC /home/main/.grass7/rc

RUN mkdir /home/main/.grass7
ADD install_scripts/rc /home/main/.grass7/rc

#USER postgres
#
## start db and make new user and db (osgeo) listening from all host
#RUN /etc/init.d/postgresql start &&\
#    psql --command "CREATE USER main WITH SUPERUSER PASSWORD 'main';" &&\
#    createdb -O main main
#
#
#ADD install_script/pgsetup.sh /tmp/pgsetup.sh
#RUN /tmp/pgsetup.sh
#

USER root
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf
