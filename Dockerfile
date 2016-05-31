FROM andrewosh/binder-base

MAINTAINER Massimo Di Stefano <epiesasha@me.com>

USER root

# Add dependency
RUN apt-get update
RUN apt-get install -y graphviz grass

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        bash-completion \
        build-essential \
        git \
        python \
        python-dev \
        petsc-dev \
        libhdf5-dev \
        python-pip \
        libxml2-dev \
        xorg-dev \
        ssh \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libxft-dev \
        xvfb \
        freeglut3 \
        freeglut3-dev \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        rsync \
        vim \
        less \
        xauth \
        swig && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*  && \
    pip install \
        numpy \
        jupyter \
        plotly \
        mpi4py \
        matplotlib \
        runipy



# script for xvfb-run.  all docker commands will effectively run under this via the entrypoint
RUN printf "#\041/bin/sh \n rm -f /tmp/.X99-lock && xvfb-run -s '-screen 0 1600x1200x16' \$@" >> /usr/local/bin/xvfbrun.sh && \
    chmod +x /usr/local/bin/xvfbrun.sh



USER main


ADD conda-IOOS.sh /home/main/
RUN sh /home/main/conda-IOOS.sh

RUN /home/main/anaconda2/envs/python3/bin/conda install -c conda-forge ipyleaflet


ADD conda-R.sh /home/main/
RUN sh /home/main/conda-R.sh

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
RUN ls /home/main/anaconda2/envs/python3/bin

ADD conda.sh /home/main/
RUN sh /home/main/conda.sh

