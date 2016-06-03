#!/usr/bin/env bash

MY_CONDA_PY3ENV="python3"

conda config --set ssl_verify false

conda install -y -n $MY_CONDA_PY3ENV \
                               'pandas' \
                               'proj4' \
                               'vispy' \
                               'mpld3' \
                               'bokeh' \
                               'bokeh' \
                               'graphviz' \
                               'seaborn' \
                               'gdal' \
                               'fiona' \
                               'rasterio' \
                               'pyproj' \
                               'shapely' \
                               'sphinx' \
                               'docutils' \
                               'psycopg2' \
                               'sqlalchemy' \
                               && conda clean -yt

# Install ipyleaflet
conda install -c conda-forge ipyleaflet
conda install -c conda-forge -n $MY_CONDA_PY3ENV ipyleaflet

