# Readme Trabajo Especial XML

## Archivos requeridos:

Para ejecutar el programa, se debe contar con los siguientes archivos en el directorio donde se está trabajando:

### tp.sh
###query_map.xq
###convert_csv.xsl

Además se debe tener instalado Java, Xerces, y Saxon.

## Ejecutar el archivo tp.sh:

tp.sh se ejecuta pasando como parametros las coordenadas deseadas en el orden west, south, east y north, de la siguiente manera:

### ./tp.sh west=-74.00 south=40.711 east=-73.99 north=40.73

Al ingresar dicho comando se notificará el proceso de lectura y al finalizar será generado automáticamente un archivo “output.csv” con la información de salida en el mismo directorio. 
En caso de que el archivo “output.csv” se encuentre vacío, en  “intermediate.xml” se encontrarán los errores ocurridos durante la ejecución.
