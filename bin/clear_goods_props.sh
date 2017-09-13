#!/bin/bash

user="root"
password="kazk0der"
database="gs3"
dbargs="-s -N --database=${database} --user=${user} --password=${password}"
declare -A id_array
declare -i cur_max
start=`date +%s`

read -r pos < './pos'
echo "pos=$pos"
mysql $dbargs --execute="SELECT id FROM goods_prices limit $pos,100" | while read id ; do
    #id=110981
    echo "id=" $id
	cur_max=$(mysql $dbargs --execute="SELECT max(id) FROM goods_props where art_id=$id")
	mysql $dbargs --execute="SELECT id, art_id FROM goods_props where art_id=$id and id<>$cur_max" | while read props_id art_id; do
		#id_array[$art_id] +=" $id"
        echo "     delete props_id=$props_id art_id=$art_id"
        mysql $dbargs --execute="DELETE FROM goods_props where id=$props_id"
	done

	#echo $id_array
	echo "      stay cur_max=$cur_max"
    
done
pos=$((pos + 100))
echo "$pos" > './pos'


