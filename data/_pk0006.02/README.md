<aside>
<table align="right" style="padding: 1em">
<tr><td>Paquete <a target="_git" title="Enlace canónico a git para este paquete." href="http://git.digital-guard.org/preserv-CO/blob/main/data/_pk0006.02"><big><b>pk0006.02</b></big></a> de <small><a target="_osmcodes" title="Jurisdicción" href="https://osm.codes/CO">CO</a></small>
</td></tr>
<tr><td>
Donante: <a rel="external" target="_doador" href="https://www.dane.gov.co/">Departamento Administrativo Nacional de Estadística</a><br/>
<small>nit:899.999.027-8</small> • Wikidata <a rel="external" target="_doador" title="Enlace del descriptor Wikidata del donante" href="https://www.wikidata.org/wiki/Q1190181">Q1190181</a></small><br/>

Obtido via <i>site</i> em <b>2022-09-27</b> por:<br/>
 Avaliação técnica: <a rel="external" target="_gitPerson" title="Usuario de Git" href="https://github.com/luisfelipebr">luisfelipebr</a><br/>
 Representação institucional: <a rel="external" target="_gitPerson" title="Usuario de" href="https://github.com/ThierryAJean">ThierryAJean</a><br/>
</td></tr>
<tr><td>Camadas: <a title="geoaddress" href="#-geoaddress"><img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/></a> </td></tr>
<tr><td><a href="http://git.digital-guard.org/preservCutGeo-CO2021/tree/main/data/_pk0006.02">Datos publicados</a></td></tr>
</table>
</aside>

<section>

Este repositorio de metadatos describe un paquete de archivos donados al dominio público. Está siendo conservado por Digital Guard: para obtener más detalles, consulte la [documentación sobre el proceso de registro y conservación](https://git.digital-guard.org/preserv/tree/main/docs).

Nota. Este documento README fue generado por software a partir de la información contenida en el archivo [`make_conf.yaml`](make_conf.yaml) en este paquete, e información adicional de los catálogos de [donantes](https://git.digital-guard.org/preserv-BR/blob/main/data/donor.csv) y [paquetes](https://git.digital-guard.org/preserv-BR/blob/main/data/donatedPack.csv).

# Capas de datos

Los archivos contienen "capas de datos" temáticas. Los metadatos también describen cómo se evaluó cada capa y cómo se filtraron sus datos de forma estandarizada.

## <img src="https://raw.githubusercontent.com/digital-guard/preserv/main/docs/assets/layerIcon-geoaddress.png" alt="geoaddress" width="20"/> geoaddress

Nombre del archivo: `Marco_Maestro_Direcciones_Multiproposito.txt`.<br/>*Descarga* e integridad: [aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip](http://dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip)<br/>Descripción: Geoaddress<br/>Formato: txt<br/>SRID: 4326

#### Datos relevantes
* `DIRECCION_NORMALIZADA` (address)

#### Otros datos relevantes
* `DPTO_MPIO`: Divipola number.
* `CLASE`: clase.

</section>
<section>

# Reproducibilidad

```bash

geoaddress:
rm -rf /tmp/sandbox/_pk17000000602_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk17000000602_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip && sudo chmod 664 /var/www/dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip
psql $(pg_uri_db) -c "DROP  TABLE IF EXISTS pk17000000602101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk17000000602_001; 7z  x -y /var/www/dl.digital-guard.org/aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip "*Marco_Maestro_Direcciones_Multiproposito.txt*" ; chmod -R a+rwx . > /dev/null
cd $(sandbox); sed -i '17866690d' Marco_Maestro_Direcciones_Multiproposito.txt
cd $(sandbox); sed -i 's;\r$$;;'  Marco_Maestro_Direcciones_Multiproposito.txt
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=4326"
psql $(pg_uri_db) -c "SELECT ingest.copy_tabular_data( '$(sandbox)/Marco_Maestro_Direcciones_Multiproposito.txt', 'pk17000000602101_p1_geoaddress','sql-ascii','|' )"

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk17000000602101_p1_geoaddress AS SELECT row_number() OVER () AS gid, coalesce(\"DPTO_MPIO\"::int,-1) as divipola, \"CLASE\"::int as clase, TRIM(\"DIRECCION_NORMALIZADA\") AS address, ST_SetSRID(ST_MakePoint(replace(\"LONGITUD\",',','.')::float,replace(\"LATITUD\",',','.')::float),4326) AS geom FROM $(tabname)"
psql $(pg_uri_db) -c "CALL ingest.any_load_loop('txt2sql','$(sandbox)/Marco_Maestro_Direcciones_Multiproposito.txt','geoaddress_full','vw1_pk17000000602101_p1_geoaddress','17000000602101','aaa8c908e179e07841aed287de18277811fedc3bd9a078100e63fd7e63c4e90b.zip',array[]::text[],1,1,false,'geom',true,'divipola')"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk17000000602101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
rm -f "/tmp/sandbox/_pk17000000602_001/*Marco_Maestro_Direcciones_Multiproposito.txt.*" || true
psql $(pg_uri_db) -c "DROP TABLE IF EXISTS pk17000000602101_p1_geoaddress CASCADE"
mkdir -m777 -p /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress/*.geojson
psql $(pg_uri_db) -c "SELECT ingest.publicating_geojsons('geoaddress','CO','/var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress','1',9,3);"
cd /var/gits/_dg/preserv/src; sudo bash fixaPermissoes.sh /var/gits/_dg/preservCutGeo-CO2021/data/_pk0006.02/geoaddress

```
</section>

