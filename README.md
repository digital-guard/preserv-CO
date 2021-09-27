# Digital-preservation-CO
[Preservación digital](https://en.wikipedia.org/wiki/Digital_preservation) de las principales fuentes de la **base de datos AddressForAll-Colombia**, mantenida por el [Instituto AddressForAll](http://addressforall.org/).

A Colombia se le asignó: en el contexto ISO&nbsp;3166&#8209;2 el geocódigo **CO** y el número **170**; en Wikidata el identificador [Q739](http://wikidata.org/entity/Q739); en OpenStreetMap el identificador de [*relación* 120027](http://osm.org/relation/120027).


## Organización territorial
El territorio nacional y sus subdivisiones representam **jurisdiciones**:

* El país está dividido en **32 departamentos**, administrados por un gobernador electo, y el Distrito Capital (distrito de la ciudad de Bogotá).

* Los departamentos se subdividen en **1120 municipios**, incluida Bogotá, que son gobernados por un alcalde y un concejo elegido. Los datos que nos interesan están a este nivel.

* Bogotá es tanto la ciudad del distrito capital como la capital del departamento de Cundinamarca.

Los catastros urbanos se encuentran en los municipios.

La jurisdicción que asigna nombres a las calles y el sistema de numeración urbana es el municipio.

## Organización de este repositorio

En este *git*, solo se guardan los metadatos, es decir, descriptores de entidad, como nombres y códigos geográficos &mdash; mapas y otros datos, almacenados externamente porque son muy grandes. Los metadatos se organizaron de la siguiente manera, en la carpeta [`/data`](./data):

* [`/data/in`](./data/in): datos originales de **entrada**, es decir, metadatos proporcionados para el sistema.
   * `jurisdictionLevel*.csv`:  jurisdicciones (en todos los niveles) y sus geocódigos. La primera subdivisión es [jurisdictionLevel4.csv](./data/in/jurisdictionLevel4.csv).
   * [`cl-donor.csv`](./data/in/cl-donor.csv): donantes de paquetes de datos. Metadatos de las instituciones que brindan datos oficiales. (pendente)
   * [`cl-donatedPack.csv`](./data/in/cl-donatedPack.csv): descriptores de los archivos donados. (pendente)
   * *paquetes* (carpetas `_packXX`): *hash*  y otros descriptores de archivos almacenados externamente, así como `makefile` y otros descriptores de proceso para descomprimir estos archivos y llevarlos a la base de datos (PostregSQL)... 

* [`/data/out`](./data/out): resultados generados por el sistema (**salida**), es decir, metadatos creados a partir de los algoritmos y estadísticas aplicados a los datos de `_pack`.

## Licencia
[Licencia CC0](https://creativecommons.org/publicdomain/zero/1.0/deed.es).
