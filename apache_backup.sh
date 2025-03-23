#!/usr/bin/bash


backup_dir="/backups"
Date=$(date +%Y-%m-%d)
apache_config="/etc/apache2/apache2.conf"
doc_root="/var/www/html"
backup_name="apache2_backup"_$Date.tar.gz
echo $backup_name


if [ $? -eq 0 ]
then
	tar -czf $backup_name $apache_config $doc_root
else 
	echo "something went wrong"
fi
