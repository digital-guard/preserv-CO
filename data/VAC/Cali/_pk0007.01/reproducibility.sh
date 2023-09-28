#!/bin/bash








# layer nsvia:
rm -rf /tmp/sandbox/_pk17000000701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip && sudo chmod 664 /var/www/dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000701101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk17000000701_001; 7z  x -y /var/www/dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip '*BASE_012022.shp/ARCEDITOR01_R_MANZANAS*' '*BASE_012022.shp/ARCEDITOR01_MANZANAS_U*' ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952079,'carlos',952079,'+proj=col_urban +lat_0=3.44188333333333 +lon_0=-76.5205625 +x_0=1061900.18 +y_0=872364.63 +h_0=1000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952079"
cd /tmp/sandbox/_pk17000000701_001; find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_MANZANAS*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk17000000701101_p1_nsvia'; shp2pgsql -D   -s 952079 '{}' pk17000000701101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_MANZANAS*.shp" | head -n 1)','nsvia_none','pk17000000701101_p1_nsvia','17000000701101','a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip',array['IDMANZANA', 'IDBARRIOS', 'DEPAPRED', 'MUNIPRED', 'TIPO_AVALU', 'SECTOR', 'COMUNA', 'BARRIO', 'MANZANA', 'OBS'],5,1,True)\"; chmod -R a+rx . 2> /dev/null" \;
cd /tmp/sandbox/_pk17000000701_001; find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_MANZANAS_U*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk17000000701101_p1_nsvia'; shp2pgsql -D   -s 952079 '{}' pk17000000701101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_MANZANAS*.shp" | head -n 1)','nsvia_none','pk17000000701101_p1_nsvia','17000000701101','a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip',array['IDMANZANA', 'IDBARRIOS', 'DEPAPRED', 'MUNIPRED', 'TIPO_AVALU', 'SECTOR', 'COMUNA', 'BARRIO', 'MANZANA', 'OBS'],5,1,False)\"; chmod -R a+rx . 2> /dev/null" \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign( '$$(find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_MANZANAS*.shp" | head -n 1)','nsvia_none','17000000701101' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000701101_p1_nsvia CASCADE"
@echo "Delete SRID 952079 configurado via PROJ.4 string:"
@echo "+proj=col_urban +lat_0=3.44188333333333 +lon_0=-76.5205625 +x_0=1061900.18 +y_0=872364.63 +h_0=1000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952079;"
rm -f /tmp/sandbox/_pk17000000701_001/*BASE_012022.shp/ARCEDITOR01_R_MANZANAS.* || true
rm -f /tmp/sandbox/_pk17000000701_001/*BASE_012022.shp/ARCEDITOR01_MANZANAS_U.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','CO-VAC-Cali','/var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/nsvia -type f -exec chmod 664 {} \;

# layer parcel:
rm -rf /tmp/sandbox/_pk17000000701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip && sudo chmod 664 /var/www/dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000701101_p1_parcel CASCADE"
cd /tmp/sandbox/_pk17000000701_001; 7z  x -y /var/www/dl.digital-guard.org/a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip '*BASE_012022.shp/ARCEDITOR01_R_TERRENO*' '*BASE_012022.shp/ARCEDITOR01_TERRENOS_U*' ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952079,'carlos',952079,'+proj=col_urban +lat_0=3.44188333333333 +lon_0=-76.5205625 +x_0=1061900.18 +y_0=872364.63 +h_0=1000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952079"
cd /tmp/sandbox/_pk17000000701_001; find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_TERRENO*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk17000000701101_p1_parcel'; shp2pgsql -D   -s 952079 '{}' pk17000000701101_p1_parcel | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_TERRENO*.shp" | head -n 1)','parcel_full','pk17000000701101_p1_parcel','17000000701101','a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip',array['DEPAPRED', 'MUNIPRED', 'SECTOR', 'COMUNA', 'BARRIO', 'MANZANA', 'TERRENO', 'PREDIO', 'NUMEPRED', 'NOM_EDIFIC', 'ETIQUETA', 'CONEXION', 'NPN as hnum'],5,1,True)\"; chmod -R a+rx . 2> /dev/null" \;
cd /tmp/sandbox/_pk17000000701_001; find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_TERRENOS_U*.shp" -exec sh -c "psql postgres://postgres@localhost/ingest1 -c 'DROP TABLE IF EXISTS pk17000000701101_p1_parcel'; shp2pgsql -D   -s 952079 '{}' pk17000000701101_p1_parcel | psql -q postgres://postgres@localhost/ingest1; psql postgres://postgres@localhost/ingest1 -c \"SELECT ingest.any_load('shp2sql','$$(find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_TERRENO*.shp" | head -n 1)','parcel_full','pk17000000701101_p1_parcel','17000000701101','a3070e1b3136cae6068a6ecdd1f0b665d4b1430ca83429553db29ae72658e1f0.zip',array['DEPAPRED', 'MUNIPRED', 'SECTOR', 'COMUNA', 'BARRIO', 'MANZANA', 'TERRENO', 'PREDIO', 'NUMEPRED', 'NOM_EDIFIC', 'ETIQUETA', 'CONEXION', 'NPN as hnum'],5,1,False)\"; chmod -R a+rx . 2> /dev/null" \;
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load_assign( '$$(find /tmp/sandbox/_pk17000000701_001 -path "*BASE_012022.shp/ARCEDITOR01_R_TERRENO*.shp" | head -n 1)','parcel_full','17000000701101' )"
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000701101_p1_parcel CASCADE"
@echo "Delete SRID 952079 configurado via PROJ.4 string:"
@echo "+proj=col_urban +lat_0=3.44188333333333 +lon_0=-76.5205625 +x_0=1061900.18 +y_0=872364.63 +h_0=1000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952079;"
rm -f /tmp/sandbox/_pk17000000701_001/*BASE_012022.shp/ARCEDITOR01_R_TERRENO.* || true
rm -f /tmp/sandbox/_pk17000000701_001/*BASE_012022.shp/ARCEDITOR01_TERRENOS_U.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/parcel
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/parcel/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('parcel','CO-VAC-Cali','/var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/parcel','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/parcel
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/parcel -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/parcel -type f -exec chmod 664 {} \;

# layer via:
rm -rf /tmp/sandbox/_pk17000000701_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000701_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/e42148b3fc8a262446d16e7e48aa95fcb000d0fab0ffcd35d2523b566becfcf1.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/e42148b3fc8a262446d16e7e48aa95fcb000d0fab0ffcd35d2523b566becfcf1.zip && sudo chmod 664 /var/www/dl.digital-guard.org/e42148b3fc8a262446d16e7e48aa95fcb000d0fab0ffcd35d2523b566becfcf1.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000701201_p2_via CASCADE"
cd /tmp/sandbox/_pk17000000701_001; 7z  x -y /var/www/dl.digital-guard.org/e42148b3fc8a262446d16e7e48aa95fcb000d0fab0ffcd35d2523b566becfcf1.zip "*POT_2014.gdb_arcgis_10.5/Ejesviales/bcs_nomenclatura_ejes_viales*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, proj4text, srtext) VALUES (952079,'carlos',952079,'+proj=col_urban +lat_0=3.44188333333333 +lon_0=-76.5205625 +x_0=1061900.18 +y_0=872364.63 +h_0=1000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',null);"
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=952079"
cd /tmp/sandbox/_pk17000000701_001; shp2pgsql -D   -s 952079 "POT_2014.gdb_arcgis_10.5/Ejesviales/bcs_nomenclatura_ejes_viales.shp" pk17000000701201_p2_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk17000000701_001/POT_2014.gdb_arcgis_10.5/Ejesviales/bcs_nomenclatura_ejes_viales.shp','via_full','pk17000000701201_p2_via','17000000701201','e42148b3fc8a262446d16e7e48aa95fcb000d0fab0ffcd35d2523b566becfcf1.zip',array['NOMBRE as via', 'NOM_ALTERN'],5,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000701201_p2_via CASCADE"
@echo "Delete SRID 952079 configurado via PROJ.4 string:"
@echo "+proj=col_urban +lat_0=3.44188333333333 +lon_0=-76.5205625 +x_0=1061900.18 +y_0=872364.63 +h_0=1000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs"
psql postgres://postgres@localhost/ingest1 -c "DELETE FROM spatial_ref_sys WHERE srid=952079;"
rm -f /tmp/sandbox/_pk17000000701_001/*POT_2014.gdb_arcgis_10.5/Ejesviales/bcs_nomenclatura_ejes_viales.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/via
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','CO-VAC-Cali','/var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/via
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/VAC/Cali/_pk0007.01/via -type f -exec chmod 664 {} \;




