#!/bin/bash

date_string_one=$(date +"%F %T,%3N")
echo $date_string_one
# source checkup.sh

echo $(wget -q -O - "http://localhost/parsers/process_params.php")