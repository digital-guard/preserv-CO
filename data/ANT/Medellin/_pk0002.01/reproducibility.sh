#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk17000000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/2630981b3e7c796f23a938d8c727ed47cf890547336ead89738b96e67fe62e7a.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2630981b3e7c796f23a938d8c727ed47cf890547336ead89738b96e67fe62e7a.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2630981b3e7c796f23a938d8c727ed47cf890547336ead89738b96e67fe62e7a.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000201201_p2_geoaddress CASCADE"
cd /tmp/sandbox/_pk17000000201_001; 7z  x -y /var/www/dl.digital-guard.org/2630981b3e7c796f23a938d8c727ed47cf890547336ead89738b96e67fe62e7a.zip "*Nomenclatura_Domiciliaria*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk17000000201_001; shp2pgsql -D   -s 4326 "Nomenclatura_Domiciliaria.shp" pk17000000201201_p2_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000201_001/Nomenclatura_Domiciliaria.shp','geoaddress_full','pk17000000201201_p2_geoaddress','17000000201201','2630981b3e7c796f23a938d8c727ed47cf890547336ead89738b96e67fe62e7a.zip',array['gid', 'TIPO_VIA', 'VIA AS via', 'PLACA AS hnum', 'TIPO_CRUCE', 'NOMBRE_BAR AS nsvia', 'NOMBRE_COM', 'ORIENTACIO', 'ORIENTAC_1', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000201201_p2_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk17000000201_001/*Nomenclatura_Domiciliaria.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','CO-ANT-Medellin','/var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/geoaddress -type f -exec chmod 664 {} \;



# layer via:
rm -rf /tmp/sandbox/_pk17000000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/410d02a87e8d2955849ba644ed8830f3d6761b31f4d0dbf044d39975ffc02be1.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/410d02a87e8d2955849ba644ed8830f3d6761b31f4d0dbf044d39975ffc02be1.zip && sudo chmod 664 /var/www/dl.digital-guard.org/410d02a87e8d2955849ba644ed8830f3d6761b31f4d0dbf044d39975ffc02be1.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000201101_p1_via CASCADE"
cd /tmp/sandbox/_pk17000000201_001; 7z  x -y /var/www/dl.digital-guard.org/410d02a87e8d2955849ba644ed8830f3d6761b31f4d0dbf044d39975ffc02be1.zip "*Malla_vial*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
cd /tmp/sandbox/_pk17000000201_001; shp2pgsql -D   -s 4326 "Malla_vial.shp" pk17000000201101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000201_001/Malla_vial.shp','via_full','pk17000000201101_p1_via','17000000201101','410d02a87e8d2955849ba644ed8830f3d6761b31f4d0dbf044d39975ffc02be1.zip',array['gid', 'TIPO_VIA', 'Coalesce(NOMBRE_COM,LABEL) AS via', 'LABEL', 'NOMBRE_COM', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000201101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk17000000201_001/*Malla_vial.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/via
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','CO-ANT-Medellin','/var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/via
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/ANT/Medellin/_pk0002.01/via -type f -exec chmod 664 {} \;




