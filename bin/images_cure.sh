#!/bin/bash

date_string_one=$(date +"%F %T,%3N")
echo $date_string_one
# source checkup.sh

start=`date +%s`
CURL='/usr/bin/curl'

user="root"
password="k0les0"
database="test"
dbargs="-s -N --user=${user} --password=${password} --database=${database}"
#mysql -s -N --user="$user" --password="$password" --database="$database"

#if table hasn't at least one actual record - nothing to process.
res=$(mysql -s -N --user="$user" --password="$password" --database="$database" --execute="SELECT I.id as id, I.url as url FROM img_urls as I, (SELECT MIN(state) as min_state FROM img_urls WHERE state>0) as R WHERE I.state=R.min_state LIMIT 1")
if [ -z "$res" ]; then
    echo "No unprocessed images found..."
    exit 1
fi

#result=$(mysql -s -N --user="$user" --password="$password" --database="$database" --execute="SELECT id, url FROM tmp_images WHERE hash='' LIMIT 1")
#echo $result

mysql $dbargs --execute="SELECT I.id as id, I.url as url FROM img_urls as I, (SELECT MIN(state) as min_state FROM img_urls WHERE state>0) as R WHERE I.state=R.min_state  LIMIT 200" | while read id url; do
    #check timeout to exit
    end=`date +%s`
    runtime=$((end-start))
    #echo "Runtime: "$runtime
    if [ $runtime -gt 90 ]; then
        echo "Condition"
        break
    fi
    
    #prepare filename to download
    echo "id: $id, url: $url"
    T="$(date +%s)"
    ext="${url##*.}"
    fname="/var/tmp/mysql/all_images/${id}_${T}_hard_temp."$ext
    echo $fname
    
    #set timeout as time left
    #CURLARGS="-o "$fname" -s --connect-timeout 3 --retry 0 --max-time "$((17-runtime))
    CURLARGS="-f -o "$fname" -o "$fname" -o "$fname" -o "$fname" -s -L --connect-timeout 15 --retry 0 --max-time "$((90-runtime))
    #download file
    httpstat=$(curl $CURLARGS "${url}" -w '%{http_code}\n' | sort)
    httpstat=($httpstat)
    httpstat=${httpstat[0]}
    
    echo "HTTP status is: "$httpstat
    
    # check if file was downloaded
    if [ -e $fname ] && [ -f $fname ]; then
        testmime=$(file -b -i $fname |grep image)
        if [ -n "${testmime}" ] && [ $httpstat -eq "200" -o $httpstat -eq "226" -o $httpstat -eq "208" -o $httpstat -eq "150" -o $httpstat -eq "000" ]
        then
            md5=$(md5sum $fname | cut -d ' ' -f 1)
            mysql  $dbargs --execute="UPDATE img_urls SET hash='"$md5"', state='0' WHERE id="$id
            #nohup wget "http://gs.6tema.com/system/parsers/state1/update_items.php?uid="$id &
            res=$(mysql  $dbargs --execute="SELECT id FROM img_contents WHERE hash='${md5}'")
            if [ -z "$res" ]; then
                p1=${md5:0:2}
                p2=${md5:2:2}
                p3=${md5:4:2}
                cd "/var/tmp/images"
                if [ ! -d "$p1" ]; then
                    mkdir $p1
                    chown logist $p1
                    chgrp logist $p1
                fi
                cd $p1
                if [ ! -d "$p2" ]; then
                    mkdir $p2
                    chown logist $p2
                    chgrp logist $p2
                fi
                cd $p2
                #if [ ! -d "$p3" ]; then
                #    mkdir $p3
                #    cd $p3
                #fi
                cp $fname "/var/tmp/images/${p1}/${p2}/${md5}.${ext}"
                echo "New entry with hash ${md5} created!"
                chmod 777 -R $fname
                mysql  $dbargs --execute="INSERT INTO imagefiles(hash, filename) VALUES('"$md5"','"$md5"."$ext"')"
            fi
        else
            echo "Write status: "$httpstat" to database"
            mysql  $dbargs --execute="UPDATE img_urls SET state=-"$httpstat" WHERE id="$id
        fi
        rm $fname
    else
        mysql  $dbargs --execute="UPDATE img_urls SET state=state+1 WHERE id="$id
    fi
done

mysql $dbargs --execute="FLUSH TABLES img_urls, img_contents"