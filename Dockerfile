FROM andrewosh/binder-base

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

USER root

ADD install_scripts/install_deb.sh /tmp/install_deb.sh
RUN sh /tmp/install_deb.sh

# Add dependency
RUN apt-get update
RUN apt-get install -y graphviz grass


# script for xvfb-run.  all docker commands will effectively run under this via the entrypoint
RUN printf "#\041/bin/sh \n rm -f /tmp/.X99-lock && xvfb-run -s '-screen 0 1600x1200x16' \$@" >> /usr/local/bin/xvfbrun.sh && \
    chmod +x /usr/local/bin/xvfbrun.sh



USER main

ADD install_scripts/conda.sh /home/main/
RUN sh /home/main/conda.sh

ADD install_scripts/conda-IOOS.sh /home/main/
RUN sh /home/main/conda-IOOS.sh

RUN /home/main/anaconda2/envs/python3/bin/conda install -c conda-forge ipyleaflet
RUN /home/main/anaconda2/envs/python3/bin/conda install -c conda-forge -n python3 ipyleaflet


ADD install_scripts/conda-R.sh /home/main/
RUN sh /home/main/conda-R.sh
RUN /home/main/anaconda2/envs/python3/bin/conda install -c r r-rbokeh

# Install requirements for Python
#ADD requirements.txt requirements.txt
#RUN /home/main/anaconda2/envs/python3/bin/pip install -r requirements.txt


USER root

# Add Julia dependencies
RUN apt-get update
RUN apt-get install -y julia libnettle4 && apt-get clean

USER main

# Install Julia kernel
RUN julia -e 'Pkg.add("IJulia")'
RUN julia -e 'Pkg.add("Gadfly")' && julia -e 'Pkg.add("RDatasets")'
