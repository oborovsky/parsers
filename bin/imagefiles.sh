#!/bin/bash

date_string_one=$(date +"%F %T,%3N")
echo $date_string_one
# source checkup.sh

mysqldump -t --insert-ignore --complete-insert --skip-opt -u root -pk0les0 -h 127.0.0.1 test imagefiles > /var/www/parsers/sql/out/imagefiles.sql
# curl --upload-file /var/www/imagefiles.sql ftp://qtw:ced42Sddse@46.36.220.49/www/cat_new/in/ --no-epsv