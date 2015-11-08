Este Sandbox es una prueba para generar un único archivo CSV limpio que pueda ser utilizado para importar los datos en la [versión drupal de cadáveres inmobiliarios](https://github.com/ccamara/c_inmobiliarios).

En estos momentos sólo combina dos archivos csv previamente descargados de google drive, renombra las columnas (variables) y separa la columna latitud/longitud en dos distintas, algo necesario para hacer la migración correctamente.

## Pre-requisitos

Este repositorio utiliza R y necesita tener instalados previamente los paquetes siguientes para manipulación de datos:

* Tidyr
* Dplyr