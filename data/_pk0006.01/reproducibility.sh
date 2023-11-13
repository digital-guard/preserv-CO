#!/bin/bash











# layer datagrid:
rm -rf /tmp/sandbox/_pk17000000601_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000601_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/d3817192260c4a6d34be44a72c5eb06c9c9b5a6f5abf3ee56af86671d7602bb7.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d3817192260c4a6d34be44a72c5eb06c9c9b5a6f5abf3ee56af86671d7602bb7.rar && sudo chmod 664 /var/www/dl.digital-guard.org/d3817192260c4a6d34be44a72c5eb06c9c9b5a6f5abf3ee56af86671d7602bb7.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000601101_p1_datagrid CASCADE"
cd /tmp/sandbox/_pk17000000601_001; 7z  x -y /var/www/dl.digital-guard.org/d3817192260c4a6d34be44a72c5eb06c9c9b5a6f5abf3ee56af86671d7602bb7.rar "*Grid1km2_VihopeCNPV2018*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk17000000601_001; shp2pgsql -D   -s 4326 "Grid1km2_VihopeCNPV2018.shp" pk17000000601101_p1_datagrid | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk17000000601101_p1_datagrid AS SELECT gid, total_pers, ST_Centroid(geom) as geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/Grid1km2_VihopeCNPV2018.shp','datagrid_full','vw1_pk17000000601101_p1_datagrid','17000000601101','d3817192260c4a6d34be44a72c5eb06c9c9b5a6f5abf3ee56af86671d7602bb7.rar',array[]::text[],5,3)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk17000000601101_p1_datagrid"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000601101_p1_datagrid CASCADE"
rm -f /tmp/sandbox/_pk17000000601_001/*Grid1km2_VihopeCNPV2018.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.01/datagrid
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.01/datagrid/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('datagrid','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.01/datagrid','3',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.01/datagrid
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.01/datagrid -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.01/datagrid -type f -exec chmod 664 {} \;





