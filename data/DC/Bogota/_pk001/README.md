# Tareas
  
Los nombres de las carreteras van seguidos de nombres como: calle, carrera, diagonal y transversal junto con un número de placa. Puede tener letra o bis índice. 
La numeración del edificio tiene un complemento de letras y un complemento al número de metros que el edificio hace esquina.
# Extracción
A continuación se muestran los pasos para la extracción por tipo de datos relevantes.
## Via
SRID:  4686
1. Abrir`Malla_Vial_Integral_Bogota_D_C-shp.zip`.
2. Selecciona archivos `Malla_Vial_Integral_Bogota_D_C.*`.
3. Copie los archivos seleccionados al directorio de destino.
### Datos relevantes
columnas:
* `MVITIPO`(string):  tipo de via
* `MVINOMBRE`(string):  nome de via, si es nulo, use otro campo
* `MVINALTERN`(string): nombre alternativo
* `MVINANTIGU` (string): nombre de ruta alternativa.
* `MVIETIQUET` (string): nome de via. Necesito traducir siglas.

Ejemplo Diagonal 32B bis A (sur)
MVIETIQUET = DG 32BBISA S

## Lote
SRID: 4686
1. Abrir `dlote_shp.zip`.
2. Selecciona archivos `lote_shp/lote.*`.
3. Copie los archivos seleccionados al directorio de destino.

### Dados relevantes
Sin datos relevantes

## Bloques
SRID: 4686
1. Abrir `dmanz_shp.zip`.
2. Selecciona archivos `manz_shp/manz.*`.
3. Copie los archivos seleccionados al directorio de destino.

### Dados relevantes
Sin datos relevantes

## punto de dirección
SRID: 4686
1. Abrir `dpdom_shp.zip`.
2. Selecciona archivos `pdom_shp/pdom.*`.
3. Copie los archivos seleccionados al directorio de destino.

### Datos relevantes
columnas:
* `PDOTEXTO`(string):  número de casa
* `PDOCINTERI`(string):  complemento de número de casa
* `PDOTIPO` (string): auxilio en nombre de ruta.

# Evidências de teste
Teste no QGIS:
![](qgis.png)

# Make

Para generar todas las capas descritas aquí, `make all_layers`. Todos los datos del "original filtrado" se escribirán en las tablas `ingest.layer_file` e` ingest.feature_asis`.

Para la generación de una sola capa o la descarga de datos de otra fuente, o el uso de una base que no sea `ingest1`, use demasiados parámetros. Ejemplo: `make pg_db=ingest2 orig=/tmp/sandOrig nsvia_full`.
