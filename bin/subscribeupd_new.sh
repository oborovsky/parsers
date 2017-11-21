#!/bin/bash

date_string_one=$(date +"%F %T,%3N")
echo $date_string_one
# source checkup.sh

#construct URL TO CBR.RU to grab courses
DATE=`date +%d/%m/%Y`
url="http://www.cbr.ru/scripts/XML_daily.asp?date_req=${DATE}"
content=$(w3m -dump $url)
user_id=0
echo "usd->rub"
#predefinfe courses constants
eur=$(echo $content | perl -pe 's/.*?CharCode.EUR..CharCode.*?Value.([0123456789,\.]+).*$/$1/')
eur=${eur/,/.}
usd=$(echo $content | perl -pe 's/.*?CharCode.USD..CharCode.*?Value.([0123456789,\.]+).*$/$1/')
usd=${usd/,/.}

#prepare array of subscribes columns
infile=/var/www/html/parsers/configure.rgx
declare -A cols
declare -A create
while read line
do
    #line=${line//,/ };
    array=(${line//[\",]/ })
    mfg=${array[0]}
    name=${array[1]}
    sub=${array[2]}
    if [[ ${name} == "prices" ]]; then
        cols[$mfg]+=", \`price_"$sub"\`, \`price_"$sub"_\`"
        create[$mfg]+=", \`price_"$sub"\` int( 11 ) NOT NULL , \`price_"$sub"_\` timestamp NULL DEFAULT NULL"
    fi
    if [[ ${name} == "amounts" ]]; then
        cols[$mfg]+=", \`stock_"$sub"\`, \`stock_"$sub"_\`"
        create[$mfg]+=", \`stock_"$sub"\` int( 11 ) NOT NULL , \`stock_"$sub"_\` timestamp NULL DEFAULT NULL"
    fi
done < $infile

echo "start"
#prapare database connecitons
user="root"
password="kazk0der"
# password="4995"
database="test"
prefix="gs3_"
dbargs="-s -N --user=${user} --password=${password}"
#dbargs="--defaults-extra-file=/etc/mysql/configs/local.cnf -s -N"
dbroot="--database=${database}"

echo "select from ftpuser"
#walk on each user instante
mysql $dbargs $dbroot --execute="SELECT \`userid\`,\`loaded\` FROM \`ftpuser\` WHERE \`id\`>1" | while read uid loaded; do
    echo "ok"
    dbuser="${prefix}${uid}"
    if [ -n "$1" ]
    then
        loaded=$1
    fi
    #get subscribes of user
    echo "dbuser:${dbuser}"
    tmp=$(mysql $dbargs --database=$dbuser --execute="SELECT content FROM system_config WHERE title LIKE '%SUBSCRIBES%' OR title LIKE 'var_DAYLIMIT'")
    read -r days subscribes <<< $tmp
    echo "subscribes:${subscribes}, days:${days}"
    if [ ! -z "$subscribes" ]; then
        subset=(${subscribes//,/ })
        subscribes="'"${subscribes//,/\',\'}"'"
        #build list of fields to create
        fields="\`id\` int(10) unsigned NOT NULL,\`mfg\` char(1) COLLATE utf8_bin NOT NULL,\`art\` tinytext COLLATE utf8_bin NOT NULL, upd TIMESTAMP NOT NULL, isnew BIT(1) NOT NULL DEFAULT 0, images varchar(4000) DEFAULT NULL"
        columns="id, mfg, art, upd, isnew, images"
        for i in "${subset[@]}"
        do
           fields+=${create[$i]}
           columns+=${cols[$i]}
        done
        
        mysql $dbargs --database=$dbuser --execute="DROP TABLE IF EXISTS \`goods_prices_tmp\`"
        echo "-----------------------------------------PREPARE"
        #create temporal table
        sql="CREATE TABLE \`goods_prices_tmp\` ("$fields",PRIMARY KEY (\`id\`)) ENGINE = MyISAM DEFAULT CHARSET = utf8 COLLATE = utf8_bin;"
        #echo $sql;
        echo "-----------------------------------------0"
        mysql $dbargs --database=$dbuser --execute="${sql}"
        if [ $? -eq 0 ]; then
            #copy with prices and ammouns
            echo "-----------------------------------------1"
            #sql="INSERT INTO \`${dbuser}\`.\`goods_prices_tmp\`(${columns}) SELECT ${columns} FROM \`${database}\`.\`goods_prices\` WHERE \`mfg\` IN (${subscribes}) AND \`upd\` > (NOW() - INTERVAL ${timelimit} DAY)"
            sql="INSERT INTO \`${dbuser}\`.\`goods_prices_tmp\`(${columns}) SELECT ${columns} FROM \`${database}\`.\`goods_prices\` WHERE \`mfg\` IN (${subscribes})"
            echo $sql;
            mysql $dbargs --execute="${sql}"
            if [ $? -eq 0 ]; then
                #replace table                
                echo "-----------------------------------------3"
                mysql $dbargs --database=$dbuser --execute="DROP TABLE IF EXISTS \`goods_prices_0\`"
                mysql $dbargs --database=$dbuser --execute="RENAME TABLE \`goods_prices_tmp\` to \`goods_prices_0\`"
                echo "-----------------------------------------4"
                #copy updates to subscriber
                #sql="INSERT INTO \`${prefix}${uid}\`.\`goods_upload\` SELECT * FROM \`${database}\`.\`goods_props_current\` as \`P\` WHERE \`mfg\` IN (${subscribes}) AND \`upd\`>'${loaded}' ON DUPLICATE KEY UPDATE \`${prefix}${uid}\`.\`goods_upload\`.\`id\`=\`${prefix}${uid}\`.\`goods_upload\`.\`id\`"              

                #sql="";
                sql="SELECT P.id, REPLACE(P.art,' ','_') , P.mfg, B.art_id as ss FROM \`test\`.\`goods_prices\` as P LEFT JOIN \`gs3_blank\`.\`goods_bindings_0\` as B ON P.\`id\`=B.art_id HAVING ss is NULL;"
                mysql $dbargs $dbroot --execute="${sql}" | while read priceid part pmfg bid; do
                    sq="INSERT INTO items_0 SET arts='${part}', mfgs='${pmfg}',uid=${user_id};SELECT LAST_INSERT_ID();"
                    last_id=$(mysql $dbargs --database=$dbuser --execute="${sq}")
                    if [ $? -eq 0 ]; then
                        sq="INSERT INTO \`gs3_blank\`.\`goods_bindings_0\`(\`int\`,\`art_id\`,\`uid\`) VALUES(${last_id},${priceid},${user_id});"
                        echo "[BND] : "$sq"\n\n"
                        mysql $dbargs $dbuser --execute="${sq};"
                    else
                        echo "==>[ERR] : "$sq"\n"
                    fi
                done

                #exit 1;
                sql="UPDATE \`${prefix}${uid}\`.\`items_0\` I, \`${database}\`.\`goods_props_current\` U, \`${prefix}${uid}\`.\`goods_bindings_0\` B SET I.\`cats\`=U.\`cats\`, I.\`params\`=U.\`params\`, I.\`descr\`=U.\`descr\` WHERE I.\`id\`= B.\`int\` AND U.\`art_id\`=B.\`art_id\` AND I.\`ok\`=0 AND \`mfg\` IN (${subscribes})"
                echo "NESQL :: ${sql}"
                mysql $dbargs --execute="${sql}"
                if [ $? -eq 0 ]; then
                    mysql $dbargs $dbroot --execute="UPDATE \`ftpuser\` SET \`loaded\`=NOW() WHERE \`userid\`='${uid}'"
                    echo "-----------------------------------------5-FINAL"
                    for i in "${subset[@]}"
                    do
                        echo $i
                        tmp=$(mysql $dbargs --database=$dbuser --execute="SELECT content FROM system_config WHERE title LIKE '%PRICEMULT_${i}%' LIMIT 1")
                        tmp=${tmp/EUR/$eur}
                        tmp=${tmp/USD/$usd}
                        echo "REPLACED WITH "$tmp
                        IFS=":" read -r col val <<< "${tmp}"
                        amounts=$(mysql $dbargs --database=$dbuser --execute="SELECT content FROM system_config WHERE title LIKE '%AMOUNTSUM_${i}%' LIMIT 1")
                        pricesv=$(mysql $dbargs --database=$dbuser --execute="SELECT content FROM system_config WHERE title LIKE '%PRICEVIEW_${i}%' LIMIT 1")
                       
                        #mysql $dbargs --database=$dbuser --execute="CREATE TEMPORARY TABLE IF NOT EXISTS temp_table ( INDEX(id) ) ENGINE=MEMORY AS (  SELECT items_0.id as id, ${val}*${col}, ${amounts} FROM goods_prices_0 INNER JOIN goods_bindings_0 ON goods_prices_0.id=goods_bindings_0.art_id INNER JOIN items_0 ON goods_bindings_0.int=items_0.id WHERE items_0.mfgs LIKE '%${i}%')"
                        #sql="UPDATE items_0 I1, (SELECT I.id as id, P.${col} as new_price FROM goods_prices_0 as P, goods_bindings_0 as B, items_0 as I WHERE I.id=B.int AND B.art_id=P.id AND I.mfgs LIKE '%${i}%') I2  SET I1.price=${val}*I2.new_price WHERE I1.id=I2.id AND I1.mfgs LIKE '%${i}%'"
                        sql="UPDATE items_0 I1, (SELECT I.id as id, ${pricesv} as new_price_view, ${amounts} as new_amount, P.${col} as new_price, P.upd as new_upd, P.images as new_images, P.isnew as isnew FROM goods_prices_0 as P, goods_bindings_0 as B, items_0 as I WHERE I.id=B.int AND B.art_id=P.id AND I.mfgs LIKE '%${i}%') I2  SET I1.price=${val}*I2.new_price, I1.amount=I2.new_amount, I1.price_view=I2.new_price_view, I1.upd=I2.new_upd, I1.images_new=I2.new_images, I1.isnew=I2.isnew WHERE I1.id=I2.id AND I1.mfgs LIKE '%${i}%'"
                        
                        # вариант, сохраняющий порядок картинок, выставленный в карточки товара 21.11.17
                        #sql="UPDATE items_0 I1, (SELECT I.id as id, ${pricesv} as new_price_view, ${amounts} as new_amount, P.${col} as new_price, P.upd as new_upd, P.images as new_images, P.isnew as isnew FROM goods_prices_0 as P, goods_bindings_0 as B, items_0 as I WHERE I.id=B.int AND B.art_id=P.id AND I.mfgs LIKE '%${i}%') I2  SET I1.price=${val}*I2.new_price, I1.amount=I2.new_amount, I1.price_view=I2.new_price_view, I1.upd=I2.new_upd, I1.isnew=I2.isnew WHERE I1.id=I2.id AND I1.mfgs LIKE '%${i}%'"
                        echo $sql
                        mysql $dbargs --database=$dbuser --execute="${sql}"
                        
                        #UPDATE
                        sql="UPDATE \`items_0\` SET \`images\`=\`images_new\` WHERE \`images_new\` IS NOT NULL AND \`ok\`=0;"
                        # вариант, сохраняющий порядок картинок, выставленный в карточки товара 21.11.17
                        # sql = "UPDATE items_0 I, goods_bindings_0 B, goods_prices P SET I.images = P.images, I.images_new = P.images WHERE I.id = B.int AND B.art_id = P.id AND I.images_new <> P.images AND I.mfgs LIKE '%${i}%'"
                        mysql $dbargs --database=$dbuser --execute="${sql}"
                        
                        #TEMOIRARY UNUSED. IMPROVED JUST ABOVE
                        #sql="UPDATE items_0 I1, (SELECT I.id as id, ${amounts} as new_amount FROM goods_prices_0 as P, goods_bindings_0 as B, items_0 as I WHERE I.id=B.int AND B.art_id=P.id AND I.mfgs LIKE '%${i}%') I2  SET I1.amount=I2.new_amount WHERE I1.id=I2.id AND I1.mfgs LIKE '%${i}%'"
                        #mysql $dbargs --database=$dbuser --execute="${sql}"
                        
                        
                        #echo $col" --::-- "$val;
                        #sql="SELECT content FROM system_config"
                    done
                else
                    echo "MYSQL ERROR!!!"
                fi
            fi
        fi
    fi
done