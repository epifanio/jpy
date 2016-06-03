#!/usr/bin/env bash

# Add dependency
apt-get update
apt-get install -y graphviz grass

apt-get update -qq && \
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
        graphviz \
        grass-core \
        ossim-core \
        rubygems-integration \
        ruby-dev \
        rubygems \
        netcdf-bin \
        mlocate \
        postgresql-9.4 \
        postgresql-client-9.4 \
        postgresql-contrib-9.4 \
        postgis \
        postgresql-9.4-postgis-2.1 \
        postgresql-9.4-postgis-scripts \
        postgresql-contrib \
        sudo \
        nano \
        cgi-mapserver \
        mapserver-bin \
        python-mapscript \
        swig && \
    apt-get clean && \
    gem install gist && \
    rm -rf /var/lib/apt/lists/*  && \
    pip install \
        numpy \
        jupyter \
        plotly \
        mpi4py \
        matplotlib \
        runipy