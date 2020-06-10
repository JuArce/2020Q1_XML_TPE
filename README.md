# Readme Trabajo Especial XML

## Archivos requeridos:

Para ejecutar el programa correctamente, se debe contar con los siguientes archivos en el directorio donde se está trabajando:

### tp.sh
### query_map.xq
### convert_csv.xsl

Además se debe tener instalado Java, Xerces, y Saxon.

## Ejecutar el archivo tp.sh:

tp.sh se ejecuta pasando como parametros las coordenadas deseadas en el orden west, south, east y north, de la siguiente manera:

### ./tp.sh west= longitud  south=latitud east= longitud north= latitud

<<<<<<< Updated upstream
Al ingresar dicho comando se notificará el proceso de lectura y al finalizar será generado automáticamente un archivo “output.csv” con la información de salida en el mismo directorio. 
En caso de que el archivo “output.csv” se encuentre vacío, en  “intermediate.xml” se encontrarán los errores ocurridos durante la ejecución.

Los valores permitidos para west y east son [-180, 180], y además west < east. Los valores permitidos para south y north son [-90, 90], y south < north.

## Errores administrados

El manejo de errores se realiza en el archivo de XQuery, donde los posibles errores son:
 #### The X (parametro correspondiente) parameter is empty.
Si no se ingresó una latitud o longitud en el parámetro indicado
#### The X (parametro correspondiente) parameter is not a number
Si el parámetro ingresado no es un número.
#### The X (parametro correspondiente) is invalid
Si el parámetro ingresado no cumple con las condiciones brindadas por la consigna.


=======
Al ingresar dicho comando se notificará el proceso de lectura y al finalizar será generado automáticamente un archivo “output.csv” con la información de salida en el mismo directorio.
En caso de que el archivo “output.csv” se encuentre vacío, en  “intermediate.xml” se encontrarán los errores ocurridos durante la ejecución.

Los valores permitidos para west y east son [-180, 180], y además west < east. Los valores permitidos para south y north son [-90, 90], y south < north.

## Administración de errores

El manejo de errores se realiza en el archivo de XQuery, donde los posibles errores son:
#### The X (parametro correspondiente) parameter is empty.
Si no se ingresó una latitud o longitud en el parámetro indicado
#### The X (parametro correspondiente) parameter is not a number
Si el parámetro ingresado no es un número.
#### The X (parametro correspondiente) is invalid
Si el parámetro ingresado no cumple con las condiciones brindadas por la consigna.
>>>>>>> Stashed changes
