# meli

El siguiente script llamado challenge.sh lee un archivo que contiene el inventario con los hostname de los switchs a respaldar, dicho hostname debe ser accesible desde donde se ejecuta el script (Para este caso se añadieron como entradas al archivo /etc/hosts).
Se verifica si es el primer dia del mes, si es domingo o si es dia de semana para saber si el respaldo es mensual, semanal o diario.
Luego se verifican que no exista mas de 1 respaldo mensual, 1 respaldo semanal y 5 respaldos diario.
Para terminar se actualiza el repositorio github para almacenar los respaldos de configuraciones.
Dicho repositorio esta ordenado en subdirectorios, en donde cada uno corresponde aun switch y esta identificado por su hostname.
