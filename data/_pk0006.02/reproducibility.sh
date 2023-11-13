#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk17000000602_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000602_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000602101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk17000000602_001; 7z  x -y /var/www/dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip "*Marco_Maestro_Direcciones_Multiproposito.txt*" ; chmod -R a+rwx . > /dev/null
cd $(sandbox); sed -i '17866690d' Marco_Maestro_Direcciones_Multiproposito.txt
cd $(sandbox); sed -i 's;\r$$;;'  Marco_Maestro_Direcciones_Multiproposito.txt
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
psql $(pg_uri_db) -c "SELECT ingest.copy_tabular_data( '$(sandbox)/Marco_Maestro_Direcciones_Multiproposito.txt', 'pk17000000602101_p1_geoaddress','|' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk17000000602101_p1_geoaddress AS SELECT row_number() OVER () AS gid, coalesce(\"DPTO_MPIO\"::int,-1) as divipola, \"CLASE\"::int as clase, TRIM(\"DIRECCION_NORMALIZADA\") AS address, ST_SetSRID(ST_MakePoint(replace(\"LONGITUD\",',','.')::float,replace(\"LATITUD\",',','.')::float),4326) AS geom FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.any_load_loop('txt2sql','/tmp/sandbox/Marco_Maestro_Direcciones_Multiproposito.txt','geoaddress_full','vw1_pk17000000602101_p1_geoaddress','17000000602101','aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip',array[]::text[],1,1,false,'geom',true,'divipola')"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk17000000602101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk17000000602101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk17000000602_001/*Marco_Maestro_Direcciones_Multiproposito.txt.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "CALL ingest.ppublicating_geojsons('geoaddress','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress -type f -exec chmod 664 {} \;









