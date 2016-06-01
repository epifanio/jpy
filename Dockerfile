FROM andrewosh/binder-base

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

USER root

# Add dependency
RUN echo "root:root" | chpasswd
RUN echo "main:main" | chpasswd

RUN apt-get update && apt-get upgrade -y

ADD install_scripts/install_dep.sh /tmp/
RUN sh /tmp/install_dep.sh

# script for xvfb-run.  all docker commands will effectively run under this via the entrypoint
RUN printf "#\041/bin/sh \n rm -f /tmp/.X99-lock && xvfb-run -s '-screen 0 1600x1200x16' \$@" >> /usr/local/bin/xvfbrun.sh && \
    chmod +x /usr/local/bin/xvfbrun.sh

## Add Julia dependencies
#RUN apt-get update
#RUN apt-get install -y julia libnettle4 && apt-get clean
#
#USER main
#
## install main python packages
ADD install_scripts/conda.sh /tmp/
RUN sh /tmp/conda.sh
#
## install IOOS packages
ADD install_scripts/conda-IOOS.sh /tmp/
RUN sh /tmp/conda-IOOS.sh
#
## install pip and other packages from source
#ADD install_scripts/install_pip.sh /tmp/
#RUN sh /tmp/install_pip.sh
#
#
## Install R kernel and basic packages
#ADD install_scripts/conda-R.sh /tmp/
#RUN sh /tmp/conda-R.sh
#RUN /home/main/anaconda2/envs/python3/bin/conda install -c r r-rbokeh


## Install Julia kernel
#RUN julia -e 'Pkg.add("IJulia")'
#RUN julia -e 'Pkg.add("Gadfly")' && julia -e 'Pkg.add("RDatasets")'
