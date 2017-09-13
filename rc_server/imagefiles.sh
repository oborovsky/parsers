#!/bin/bash

date_string_one=$(date +"%F %T,%3N")
echo $date_string_one

mysql -u root -pkazk0der cuty_images < /home/qtw/www/cat_new/in/imagefiles.sql