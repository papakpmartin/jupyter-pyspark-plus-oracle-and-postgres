FROM jupyter/scipy-notebook

MAINTAINER Ken Martin <ken@kpmartin.com>

# Add Oracle Instantclient
ADD instantclient-basic-linux.x64-12.1.0.2.0.zip /tmp/
ADD instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/

# run in the target user
USER $NB_USER

RUN unzip -q /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /home/jovyan/oracle/ \
&& unzip -q /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /home/jovyan/oracle/ \
&& mv /home/jovyan/oracle/instantclient_12_1 /home/jovyan/oracle/instantclient \
&& ln -s /home/jovyan/oracle/instantclient/libclntsh.so.12.1 /home/jovyan/oracle/instantclient/libclntsh.so

USER root

RUN rm /tmp/instantclient-* \
&& apt-get update \
&& apt-get install -y libaio1 \
&& touch /etc/ld.so.conf.d/oracle.conf

ENV ORACLE_HOME /home/jovyan/oracle/instantclient
ENV LD_LIBRARY_PATH /home/jovyan/oracle/instantclient

RUN pip install --upgrade pip

RUN ldconfig \
&& pip install cx_oracle

RUN apt-get install -y libpq-dev python-dev \
&& pip install psycopg2

# tools for leafletjs maps, and for working with some spatial data
RUN apt-get install -y libgdal-dev
RUN pip install folium
RUN pip install geopandas
RUN pip install geographiclib

# for exporting to Excel files
RUN pip install xlwt
RUN pip install XlsxWriter

# make sure we get back to the expected user
USER $NB_USER