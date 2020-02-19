#!/bin/bash
#### Alexis Gaete Olivares
#### Challenge mercado libre

working_dir='/root/challenge/meli'
#### Variable para el timestamp
date=$(date +"%Y%m%d")
#### Variable para el primer dia del mes
date_day=$(date +"%d")
#### Variable para capturar el dia domingo (day of the week)
date_dotw=$(date +"%A")
echo $date
echo $date_day
echo $date_dotw

while IFS= read -r line
do
	mkdir -p $working_dir/backups/$line
#	rm -rf $working_dir/backups/$line/running-config_$date
	echo "Copiando configuraciones desde $line"
	if [ $date_day -eq 1 ]
	then
		echo "Realizando respaldo mensual"
		scp -o StrictHostKeyChecking=no $line:/flash/running-config $working_dir/backups/$line/running-config_monthly_$date
	elif [ $date_dotw == "domingo" ]  ## la distribucion de linux que estoy usando esta en español
	then
		echo "Realizando respaldo semanal"
		scp -o StrictHostKeyChecking=no $line:/flash/running-config $working_dir/backups/$line/running-config_weekly_$date
	else
	echo "Realizando respaldo diario"
	scp -o StrictHostKeyChecking=no $line:/flash/running-config $working_dir/backups/$line/running-config_diary_$date
	fi
done < "$working_dir/switches.txt"

#### busqueda de respaldos antiguos para cumplir la condicion de tener 7 copias de cada config
echo "Buscando y borrando respaldos mensuales con mas de 30 dias de antiguedad"
find $working_dir -mtime +30 -type f -name "*_montly_*" -exec ls -l {} \;
#find $working_dir -mtime +30 -type f -name "*_montly_*" -exec rm -f {} \;

echo "Buscando y borrando respaldos semanales con mas de 7 dias de antiguedad"
find $working_dir -mtime +7 -type f -name "*_weekly_*" -exec ls -l {} \;
#find $working_dir -mtime +7 -type f -name "*_weekly_*" -exec rm -f {} \;

echo "Buscando y borrando respaldos diarios con mas de 5 dias de antiguedad"
find $working_dir -mtime +5 -type f -name "*_diary_*" -exec ls -l {} \;
#find $working_dir -mtime +5 -type f -name "*_diary_*" -exec rm -f {} \;


#### actualizacion de repositorio con configuraciones
cd $working_dir
git add -A .
git commit -m "actualizacion respaldo configuraciones $date" -a
git push


echo "Respaldos y actualizacion de repositorio finalizado"
