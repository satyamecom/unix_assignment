#!/usr/bin/bash


backup_dir="/backups"
Date=$(date +%Y-%m-%d)
nginx_config="/etc/nginx/apache2.conf"
doc_root="/usr/share/nginx/html/"
backup_name="nginx_backup"_$Date.tar.gz
echo $backup_name


if [ $? -eq 0 ]
then
        tar -czf $backup_name $nginx_config $doc_root
else
        echo "something went wrong"
fi
