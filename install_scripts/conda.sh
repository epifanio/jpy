#!/usr/bin/env bash

MY_CONDA_PY3ENV="python3"

conda config --set ssl_verify false

conda install -y -n $MY_CONDA_PY3ENV \
                               'pandas' \
                               'vispy' \
                               'mpld3' \
                               'proj4' \
                               'bokeh' \
                               'gdal' \
                               'pyproj' \
                               'bokeh' \
                               && conda clean -yt