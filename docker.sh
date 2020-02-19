#!/bin/bash
#### Alexis Gaete Olivares
#### Challenge mercado libre

working_dir='/root/challenge/meli'
#### Variable para el timestamp
date=$(date +"%Y%m%d")
echo "Levantando contenedor docker"
docker run -d -it --name meli -v '/root:/root' -v '/etc/hosts:/etc/hosts' kroniak/ssh-client
echo "Ejecutando script desde contenedor docker"
docker exec -it meli /bin/bash /root/challenge/meli/challenge.sh
echo "Deteniendo contenedor"
docker stop meli
echo "Borrando contenedor"
docker rm meli

#### actualizacion de repositorio con configuraciones
echo "Subiendo configuraciones a repositorio GIT"
cd $working_dir
git add -A .
git commit -m "actualizacion respaldo configuraciones $date desde docker" -a
git push


echo "Respaldos y actualizacion de repositorio finalizado"
