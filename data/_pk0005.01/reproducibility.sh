#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk17000000501_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000501_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/121d26a488ae9b2dd73e72e2d9495a9b892ca3068b95fe969fc64610d7615ff8.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/121d26a488ae9b2dd73e72e2d9495a9b892ca3068b95fe969fc64610d7615ff8.zip && sudo chmod 664 /var/www/dl.digital-guard.org/121d26a488ae9b2dd73e72e2d9495a9b892ca3068b95fe969fc64610d7615ff8.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000501101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk17000000501_001; 7z  x -y /var/www/dl.digital-guard.org/121d26a488ae9b2dd73e72e2d9495a9b892ca3068b95fe969fc64610d7615ff8.zip "*Codigo_Postal/CODIGO_POSTAL_COMPLETA*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk17000000501_001; shp2pgsql -D   -s 4326 "Codigo_Postal/CODIGO_POSTAL_COMPLETA.shp" pk17000000501101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000501_001/Codigo_Postal/CODIGO_POSTAL_COMPLETA.shp','nsvia_full','pk17000000501101_p1_nsvia','17000000501101','121d26a488ae9b2dd73e72e2d9495a9b892ca3068b95fe969fc64610d7615ff8.zip',array['gid', 'codigo', 'codigo_pos', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000501101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk17000000501_001/*Codigo_Postal/CODIGO_POSTAL_COMPLETA.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0005.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0005.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0005.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0005.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0005.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0005.01/nsvia -type f -exec chmod 664 {} \;






