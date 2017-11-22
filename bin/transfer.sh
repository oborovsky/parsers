#!/bin/bash

date_string_one=$(date +"%F %T,%3N")
echo $date_string_one
# source checkup.sh

#prapare database connecitons
user="root"
# password="kazk0der"
password="4995"
database="test"
prefix="gs3_"
#dbargs="--defaults-extra-file=/etc/mysql/configs/local.cnf -s -N"
dbargs="-s -N --user=${user} --password=${password}"
dbroot="--database=${database}"

mysql $dbargs $dbroot --execute="SELECT \`userid\`,\`loaded\` FROM \`ftpuser\` WHERE \`id\`>1" | while read uid loaded; do
    dbuser="${prefix}${uid}"
    echo $dbuser
    DIR="/var/lib/mysql-files/${uid}"
    if [ -d "$DIR" ]; then
        timelimit=$(mysql $dbargs $dbuser --execute="SELECT \`content\` FROM \`system_config\` WHERE \`title\`='var_DAYLIMIT'")
        rm -f "/var/lib/mysql-files/${uid}/bitmasks_0.csv"
        mysql $dbargs $dbuser --execute="SELECT \`id\`, \`parent\`, \`value\`, \`order\`, \`settings\` INTO OUTFILE '/var/lib/mysql-files/${uid}/bitmasks_0.csv' CHARACTER SET utf8 FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\\\\' LINES TERMINATED BY '\\n' FROM \`bitmasks_0\` WHERE \`settings\`>0;"
        echo "bimasks_0.csv saved"
        rm -f "/var/lib/mysql-files/${uid}/items_0.csv"
        mysql $dbargs $dbuser --execute="SELECT id,arts,mfgs,cats,descr,params,images,price,overprice,prices,amount,overamount,amounts,price_view,ok,uid,upd,CAST(isnew AS UNSIGNED) as intgr INTO OUTFILE '/var/lib/mysql-files/${uid}/items_0.csv' CHARACTER SET utf8 FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\\\\' LINES TERMINATED BY '\\n' FROM \`items_0\` WHERE \`upd\` > (NOW() - INTERVAL ${timelimit} DAY) OR \`ok\`=1;"
        echo "items_0.csv saved"
        #rm -f "/var/www/${uid}/olditems_0.csv"
        #mysql $dbargs $dbuser --execute="SELECT id,arts,mfgs,cats,descr,params,images,price,overprice,prices,amount,overamount,amounts,price_view,ok,uid,upd INTO OUTFILE '/var/www/${uid}/olditems_0.csv' CHARACTER SET utf8 FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\\\\' LINES TERMINATED BY '\\n' FROM \`items_0\` WHERE \`upd\` <= (NOW() - INTERVAL ${timelimit} DAY) AND \`ok\`=0;"
        rm -f "/var/lib/mysql-files/${uid}/bits_0.csv"
        
        bits=$(mysql $dbargs $dbuser --execute="SELECT  \`content\` as f FROM \`system_config\` WHERE \`title\`='var_BITSCOUNT_0'")
        echo "bits_0.csv saved"
        cols=""
        for (( c=0; c<=$bits; c++ )) do
            cols+=",\`col_${c}\`"
        done
        mysql $dbargs $dbuser --execute="SELECT \`id\`${cols} INTO OUTFILE '/var/lib/mysql-files/${uid}/bits_0.csv' CHARACTER SET utf8 FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\\\\' LINES TERMINATED BY '\\n' FROM \`bits_0\`;"
        #rm -f "/var/www/${uid}/vars_1.csv"
        #mysql $dbargs $dbuser --execute="SELECT * INTO OUTFILE '/var/www/${uid}/vars_1.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\\\\' LINES TERMINATED BY '\\n' FROM \`system_config\` WHERE \`title\` in('arr_ITEMPARAMS','var_BITSCOUNT_0');"
        rm -f "/var/lib/mysql-files/${uid}/vars_1.csv"
        mysql $dbargs $dbuser --execute="SELECT A.f, B.f, C.f, CONCAT(D.f,'[paramtypes]',G.F), E.f, 'end'
        INTO OUTFILE '/var/lib/mysql-files/${uid}/vars_1.csv' CHARACTER SET utf8 FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\\\\' LINES TERMINATED BY '\\n'
        FROM (SELECT COUNT(\`id\`) as f FROM \`bitmasks_0\` WHERE \`settings\`>0) as A,
        (SELECT COUNT(\`id\`) as f FROM \`bits_0\`) as B,
        (SELECT COUNT(\`id\`) as f FROM \`items_0\` WHERE \`upd\` > (NOW() - INTERVAL ${timelimit} DAY) OR \`ok\`=1) as C,
        (SELECT \`content\` as f FROM \`system_config\` WHERE \`title\`='arr_ITEMPARAMS') as D,
        (SELECT \`content\` as f FROM \`system_config\` WHERE \`title\`='arr_ITEMPARAMSTYPES') as G,
        (SELECT \`content\` as f FROM \`system_config\` WHERE \`title\`='var_BITSCOUNT_0') as E;"
        
        echo "vars_1.csv saved"
        ftp=$(mysql $dbargs $dbuser --execute="SELECT \`content\` FROM \`system_config\` WHERE \`title\`='var_FTPOUT'")
        if [ -n "$ftp" ]; then
            echo $ftp
            #/var/www/rc/ftpsync.pl -p -s  -t -l -v -d $DIR $ftp
            #curl -u "myuser:mypassword" --upload-file MyFile.txt ftp://ftp.phpnet.us/htdocs/Test --no-epsv

            # curl --upload-file /var/www/${uid}/bitmasks_0.csv $ftp --no-epsv
            # curl --upload-file /var/www/${uid}/items_0.csv $ftp --no-epsv
            # #curl --upload-file /var/www/${uid}/olditems_0.csv $ftp --no-epsv
            # curl --upload-file /var/www/${uid}/bits_0.csv $ftp --no-epsv
            # curl --upload-file /var/www/${uid}/vars_1.csv $ftp --no-epsv

            #cp -r "/var/www/${uid}/bitmasks_0.csv" "/var/www/htdocs/cuty/cat_new/in/"
            #cp -r "/var/www/${uid}/items_0.csv" "/var/www/htdocs/cuty/cat_new/in/"
            #cp -r "/var/www/${uid}/bits_0.csv" "/var/www/htdocs/cuty/cat_new/in/"
            #cp -r "/var/www/${uid}/vars_1.csv" "/var/www/htdocs/cuty/cat_new/in/"
        fi
        
    else
        echo "NO directory ${DIR}"
    fi
done