#!/usr/bin/env bash

MY_CONDA_PY3ENV="python3"

conda config --set ssl_verify false

conda install -y -n $MY_CONDA_PY3ENV \
                               'pandas' \
                               'oceans' \
                               'nco' \
                               'gsl' \
                               'ctd' \
                               'vispy' \
                               'seawater' \
                               'pyepsg' \
                               'folium' \
                               'geopandas' \
                               'mpld3' \
                               'mplleaflet' \
                               'oct2py' \
                               'proj4' \
                               'bokeh' \
                               'gdal' \
                               'pyproj' \
                               'qrcode' \
                               && conda clean -yt