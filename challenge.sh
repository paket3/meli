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
	elif [ $date_dotw == "domingo" ]
	then
		echo "Realizando respaldo semanal"
		scp -o StrictHostKeyChecking=no $line:/flash/running-config $working_dir/backups/$line/running-config_weekly_$date
	else
	echo "Realizando respaldo diario"
	scp -o StrictHostKeyChecking=no $line:/flash/running-config $working_dir/backups/$line/running-config_diary_$date
	fi
done < "$working_dir/switches.txt"


#### actualizacion de repositorio con configuraciones
cd $working_dir
git add -A .
git commit -m "actualizacion respaldo configuraciones $date" -a
git push
