#!/bin/bash
#### Alexis Gaete Olivares
#### Challenge mercado libre

working_dir='/root/challenge/meli'
date=$(date +"%Y%m%d")
echo $date

while IFS= read -r line
do
	mkdir -p $working_dir/backups/$line
	#rm -rf $working_dir/backups/$line/running-config
	scp -o StrictHostKeyChecking=no $line:/flash/running-config $working_dir/backups/$line/running-config_$date
done < "$working_dir/switches.txt"
