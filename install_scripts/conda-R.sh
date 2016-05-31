#!/usr/bin/env bash
conda config --add channels r

conda install -c r r-essentials
conda update -c r r-essentials


conda install --yes \
    'r-base=3.2*' \
    'r-irkernel=0.4*' \
    'r-plyr=1.8*' \
    'r-devtools=1.8*' \
    'r-dplyr=0.4*' \
    'r-ggplot2=1.0*' \
    'r-tidyr=0.2*' \
    'r-shiny=0.12*' \
    'r-rmarkdown=0.7*' \
    'r-forecast=5.8*' \
    'r-stringr=0.6*' \
    'r-rsqlite=1.0*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.1*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-cluster' \
    'r-ctv' \
    'r-devtools' \
    'r-htmlwidgets' \
    'r-maps' \
    'r-maptools' \
    'r-raster' \
    'r-spatial' \
    'rpy2' \
    'r-randomforest=4.6*' && conda clean -yt