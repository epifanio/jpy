#!/usr/bin/env bash

MY_CONDA_PY3ENV="python3"

conda config --set ssl_verify false

conda install -y --channel IOOS -n $MY_CONDA_PY3ENV \
                               'cartopy' \
                               'proj4' \
                               'gdal' \
                               'pyproj' \
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
                               'qrcode' \
                               'xray' \
                               'pygeoif' \
                               'pyepsg' \
                               'netcdf4' \
                               'iris' \
                               'geojson' \
                               'owslib' \
                               'geopandas' \
                               && conda clean -yt
