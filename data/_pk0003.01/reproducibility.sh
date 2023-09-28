#!/bin/bash


# layer block:
rm -rf /tmp/sandbox/_pk17000000301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/d49ab53b06be4934f160bee3a92d671346d9ad2137fbd901e99875ab2fad7621.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/d49ab53b06be4934f160bee3a92d671346d9ad2137fbd901e99875ab2fad7621.zip && sudo chmod 664 /var/www/dl.digital-guard.org/d49ab53b06be4934f160bee3a92d671346d9ad2137fbd901e99875ab2fad7621.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301401_p4_block CASCADE"
cd /tmp/sandbox/_pk17000000301_001; 7z  x -y /var/www/dl.digital-guard.org/d49ab53b06be4934f160bee3a92d671346d9ad2137fbd901e99875ab2fad7621.zip "*shp/U_MANZANA*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000301_001; shp2pgsql -D   -s 4686 "shp/U_MANZANA.shp" pk17000000301401_p4_block | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000301_001/shp/U_MANZANA.shp','block_none','pk17000000301401_p4_block','17000000301401','d49ab53b06be4934f160bee3a92d671346d9ad2137fbd901e99875ab2fad7621.zip',array['gid', 'codigo', 'barrio_cod', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301401_p4_block CASCADE"
rm -f /tmp/sandbox/_pk17000000301_001/*shp/U_MANZANA.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/block
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/block/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('block','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/block','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/block
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/block -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/block -type f -exec chmod 664 {} \;





# layer geoaddress:
rm -rf /tmp/sandbox/_pk17000000301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/2db40c6a0a4ddc0bb0f765a9195c34b258de49b179f90cd54244406e0c62df83.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/2db40c6a0a4ddc0bb0f765a9195c34b258de49b179f90cd54244406e0c62df83.zip && sudo chmod 664 /var/www/dl.digital-guard.org/2db40c6a0a4ddc0bb0f765a9195c34b258de49b179f90cd54244406e0c62df83.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk17000000301_001; 7z  x -y /var/www/dl.digital-guard.org/2db40c6a0a4ddc0bb0f765a9195c34b258de49b179f90cd54244406e0c62df83.zip "*NOMENCLATURA_DOMICILIARIA*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000301_001; 7z x -y "*NOMENCLATURA_DOMICILIARIA*" ; chmod -R a+rx . > /dev/null

cd /tmp/sandbox/_pk17000000301_001; find /tmp/sandbox/_pk17000000301_001 -path "*NOMENCLATURA_DOMICILIARIA*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk17000000301101_p1_geoaddress'; shp2pgsql -D   -s 4686 '{}' pk17000000301101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 ; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk17000000301_001 -path "*NOMENCLATURA_DOMICILIARIA*.shp" | head -n 1)','geoaddress_full','pk17000000301101_p1_geoaddress','17000000301101','2db40c6a0a4ddc0bb0f765a9195c34b258de49b179f90cd54244406e0c62df83.zip',array['gid', 'texto AS hnum', 'geom'],1,1,false)\" " \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign('$$(find /tmp/sandbox/_pk17000000301_001 -path "*NOMENCLATURA_DOMICILIARIA*.shp" | head -n 1)','geoaddress_full','17000000301101' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk17000000301_001/*NOMENCLATURA_DOMICILIARIA.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk17000000301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/08bc4f124ca0a65d9eae97663eca0894d3bb4d37ead1168b767a540b68db324f.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/08bc4f124ca0a65d9eae97663eca0894d3bb4d37ead1168b767a540b68db324f.zip && sudo chmod 664 /var/www/dl.digital-guard.org/08bc4f124ca0a65d9eae97663eca0894d3bb4d37ead1168b767a540b68db324f.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301501_p5_nsvia CASCADE"
cd /tmp/sandbox/_pk17000000301_001; 7z  x -y /var/www/dl.digital-guard.org/08bc4f124ca0a65d9eae97663eca0894d3bb4d37ead1168b767a540b68db324f.zip "*shp/R_VEREDA*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000301_001; shp2pgsql -D   -s 4686 "shp/R_VEREDA.shp" pk17000000301501_p5_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000301_001/shp/R_VEREDA.shp','nsvia_full','pk17000000301501_p5_nsvia','17000000301501','08bc4f124ca0a65d9eae97663eca0894d3bb4d37ead1168b767a540b68db324f.zip',array['gid', 'codigo', 'nombre AS nsvia', 'geom'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301501_p5_nsvia CASCADE"
rm -f /tmp/sandbox/_pk17000000301_001/*shp/R_VEREDA.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk17000000301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/137dc416e70776ac57c37a4fb0cb9bedb1468e91ed73eaa656ddee91011daed7.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/137dc416e70776ac57c37a4fb0cb9bedb1468e91ed73eaa656ddee91011daed7.zip && sudo chmod 664 /var/www/dl.digital-guard.org/137dc416e70776ac57c37a4fb0cb9bedb1468e91ed73eaa656ddee91011daed7.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301301_p3_parcel CASCADE"
cd /tmp/sandbox/_pk17000000301_001; 7z  x -y /var/www/dl.digital-guard.org/137dc416e70776ac57c37a4fb0cb9bedb1468e91ed73eaa656ddee91011daed7.zip "*TERRENO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000301_001; 7z x -y "*TERRENO*" ; chmod -R a+rx . > /dev/null

cd /tmp/sandbox/_pk17000000301_001; find /tmp/sandbox/_pk17000000301_001 -path "*TERRENO*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk17000000301301_p3_parcel'; shp2pgsql -D   -s 4686 '{}' pk17000000301301_p3_parcel | psql -q postgres://postgres@localhost/ingest1 ; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk17000000301_001 -path "*TERRENO*.shp" | head -n 1)','parcel_none','pk17000000301301_p3_parcel','17000000301301','137dc416e70776ac57c37a4fb0cb9bedb1468e91ed73eaa656ddee91011daed7.zip',array['gid', 'codigo', 'geom'],5,1,false)\" " \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign('$$(find /tmp/sandbox/_pk17000000301_001 -path "*TERRENO*.shp" | head -n 1)','parcel_none','17000000301301' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301301_p3_parcel CASCADE"
rm -f /tmp/sandbox/_pk17000000301_001/*TERRENO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/parcel
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk17000000301_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000301_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/6f35dbfe7ad230f1f6f2209f5d50901c05965d7b97a9c3dafada4a9af012c335.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/6f35dbfe7ad230f1f6f2209f5d50901c05965d7b97a9c3dafada4a9af012c335.zip && sudo chmod 664 /var/www/dl.digital-guard.org/6f35dbfe7ad230f1f6f2209f5d50901c05965d7b97a9c3dafada4a9af012c335.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301201_p2_via CASCADE"
cd /tmp/sandbox/_pk17000000301_001; 7z  x -y /var/www/dl.digital-guard.org/6f35dbfe7ad230f1f6f2209f5d50901c05965d7b97a9c3dafada4a9af012c335.zip "*NOMENCLATURA_VIAL*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4686"
cd /tmp/sandbox/_pk17000000301_001; 7z x -y "*NOMENCLATURA_VIAL*" ; chmod -R a+rx . > /dev/null

cd /tmp/sandbox/_pk17000000301_001; find /tmp/sandbox/_pk17000000301_001 -path "*NOMENCLATURA_VIAL*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk17000000301201_p2_via'; shp2pgsql -D   -s 4686 '{}' pk17000000301201_p2_via | psql -q postgres://postgres@localhost/ingest1 ; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk17000000301_001 -path "*NOMENCLATURA_VIAL*.shp" | head -n 1)','via_full','pk17000000301201_p2_via','17000000301201','6f35dbfe7ad230f1f6f2209f5d50901c05965d7b97a9c3dafada4a9af012c335.zip',array['gid', 'texto AS via', 'geom'],5,1,false)\" " \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign('$$(find /tmp/sandbox/_pk17000000301_001 -path "*NOMENCLATURA_VIAL*.shp" | head -n 1)','via_full','17000000301201' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000301201_p2_via CASCADE"
rm -f /tmp/sandbox/_pk17000000301_001/*NOMENCLATURA_VIAL.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/via
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/via
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0003.01/via -type f -exec chmod 664 {} \;




