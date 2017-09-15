#!/bin/bash
ready_file='/var/www/rc/recycle/ready'
pos_file='/var/www/rc/recycle/pos'

read -r ready < $ready_file
#echo "ready=$ready"
if [ "$ready" = "start" ]
then
    #echo "exit"
    exit 0
else
    echo "start" > $ready_file
fi

date_string_one=$(date +"%F %T,%3N")
echo "start: $date_string_one"

user="root"
password="kazk0der"
database="gs3"
dbargs="-s -N --database=${database} --user=${user} --password=${password}"
declare -A id_array
declare -i cur_max
start=`date +%s`

read -r pos < $pos_file
len=100
pos_end=$((pos + len))
echo "$pos_end" > $pos_file
echo "pos=$pos"
i=0
mysql $dbargs --execute="SELECT id FROM goods_prices limit $pos,$len" | while read id ; do
    #id=110981
    echo "id=" $id
	cur_max=$(mysql $dbargs --execute="SELECT max(id) FROM goods_props where art_id=$id")
	mysql $dbargs --execute="SELECT id, art_id FROM goods_props where art_id=$id and id<>$cur_max" | while read props_id art_id; do
		#id_array[$art_id] +=" $id"
        echo "     delete props_id=$props_id art_id=$art_id"
        mysql $dbargs --execute="DELETE FROM goods_props where id=$props_id"
        i=$((i+1))
	done

	#echo $id_array
	echo "      stay cur_max=$cur_max"
    
done

end=`date +%s`
runtime=$((end-start))
echo "Runtime: "$runtime "deleted: "$i

date_string_one=$(date +"%F %T,%3N")
echo "end: $date_string_one"

echo "end" > $ready_file

