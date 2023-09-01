#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk17000000101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/ed072b0391d6c4a9bd76237b4ebb55de4f00ff0b73325d715d35baf29f41278e.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/ed072b0391d6c4a9bd76237b4ebb55de4f00ff0b73325d715d35baf29f41278e.zip && sudo chmod 664 /var/www/dl.digital-guard.org/ed072b0391d6c4a9bd76237b4ebb55de4f00ff0b73325d715d35baf29f41278e.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101301_p3_block CASCADE"
cd /tmp/sandbox/_pk17000000101_001; 7z  x -y /var/www/dl.digital-guard.org/ed072b0391d6c4a9bd76237b4ebb55de4f00ff0b73325d715d35baf29f41278e.zip "*manz_shp/manz*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000101_001; shp2pgsql -D   -s 4686 "manz_shp/manz.shp" pk17000000101301_p3_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000101_001/manz_shp/manz.shp','block_none','pk17000000101301_p3_block','17000000101301','ed072b0391d6c4a9bd76237b4ebb55de4f00ff0b73325d715d35baf29f41278e.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101301_p3_block CASCADE"
rm -f /tmp/sandbox/_pk17000000101_001/*manz_shp/manz.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/block
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','CO-DC-Bogota','/var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/block
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/block -type f -exec chmod 664 {} \;





# layer geoaddress:
rm -rf /tmp/sandbox/_pk17000000101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/8585490fefe89ff086a9234b27232cda9e29df9ad0b63d19acbd43f3760d04b5.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/8585490fefe89ff086a9234b27232cda9e29df9ad0b63d19acbd43f3760d04b5.zip && sudo chmod 664 /var/www/dl.digital-guard.org/8585490fefe89ff086a9234b27232cda9e29df9ad0b63d19acbd43f3760d04b5.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101401_p4_geoaddress CASCADE"
cd /tmp/sandbox/_pk17000000101_001; 7z  x -y /var/www/dl.digital-guard.org/8585490fefe89ff086a9234b27232cda9e29df9ad0b63d19acbd43f3760d04b5.zip "*pdom_shp/pdom*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000101_001; shp2pgsql -D   -s 4686 "pdom_shp/pdom.shp" pk17000000101401_p4_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000101_001/pdom_shp/pdom.shp','geoaddress_full','pk17000000101401_p4_geoaddress','17000000101401','8585490fefe89ff086a9234b27232cda9e29df9ad0b63d19acbd43f3760d04b5.zip',array['gid', 'PDOTEXTO AS hnum', 'PDOCINTERI', 'PDONVIAL AS via', 'PDOTIPO', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101401_p4_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk17000000101_001/*pdom_shp/pdom.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','CO-DC-Bogota','/var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/geoaddress -type f -exec chmod 664 {} \;


# layer parcel:
rm -rf /tmp/sandbox/_pk17000000101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/fff3ae00d851d47c02d3b510d856526693a47250b4739b57cc6eaa88e0f57acd.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/fff3ae00d851d47c02d3b510d856526693a47250b4739b57cc6eaa88e0f57acd.zip && sudo chmod 664 /var/www/dl.digital-guard.org/fff3ae00d851d47c02d3b510d856526693a47250b4739b57cc6eaa88e0f57acd.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101201_p2_parcel CASCADE"
cd /tmp/sandbox/_pk17000000101_001; 7z  x -y /var/www/dl.digital-guard.org/fff3ae00d851d47c02d3b510d856526693a47250b4739b57cc6eaa88e0f57acd.zip "*lote_shp/lote*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000101_001; shp2pgsql -D   -s 4686 "lote_shp/lote.shp" pk17000000101201_p2_parcel | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000101_001/lote_shp/lote.shp','parcel_none','pk17000000101201_p2_parcel','17000000101201','fff3ae00d851d47c02d3b510d856526693a47250b4739b57cc6eaa88e0f57acd.zip',array['gid', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101201_p2_parcel CASCADE"
rm -f /tmp/sandbox/_pk17000000101_001/*lote_shp/lote.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','CO-DC-Bogota','/var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/parcel
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk17000000101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/befe4d8cbbd51162e70f4f3dc4065acc430e20f2161073fabd007c575cd72098.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/befe4d8cbbd51162e70f4f3dc4065acc430e20f2161073fabd007c575cd72098.zip && sudo chmod 664 /var/www/dl.digital-guard.org/befe4d8cbbd51162e70f4f3dc4065acc430e20f2161073fabd007c575cd72098.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101101_p1_via CASCADE"
cd /tmp/sandbox/_pk17000000101_001; 7z  x -y /var/www/dl.digital-guard.org/befe4d8cbbd51162e70f4f3dc4065acc430e20f2161073fabd007c575cd72098.zip "*Malla_Vial_Integral_Bogota_D_C*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000101_001; shp2pgsql -D   -s 4686 "Malla_Vial_Integral_Bogota_D_C.shp" pk17000000101101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000101_001/Malla_Vial_Integral_Bogota_D_C.shp','via_full','pk17000000101101_p1_via','17000000101101','befe4d8cbbd51162e70f4f3dc4065acc430e20f2161073fabd007c575cd72098.zip',array['gid', 'Coalesce(MVINALTERN,MVINOMBRE) AS via', 'MVINOMBRE', 'MVINALTERN', 'MVINANTIGU', 'MVIETIQUET', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000101101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk17000000101_001/*Malla_Vial_Integral_Bogota_D_C.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/via
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','CO-DC-Bogota','/var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/via
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/DC/Bogota/_pk0001.01/via -type f -exec chmod 664 {} \;




