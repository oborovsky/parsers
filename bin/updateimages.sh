#!/bin/bash

date_string_one=$(date +"%F %T,%3N")
echo $date_string_one
# source checkup.sh

start=`date +%s`

#rdatabase="cuty_images"
#rdbargs="--defaults-extra-file=/etc/mysql/configs/vps2.cnf -s -N --database=${rdatabase}"

user="root"
# password="k0les0"
password="4995"
database="test"
dbargs="-s -N --user=${user} --password=${password} --database=${database}"

prev_id=0

mysql $dbargs --execute="SELECT \`art_id\`, \`url_id\` FROM \`images\` WHERE \`state\`>0 ORDER BY \`state\` ASC, \`art_id\` ASC LIMIT 1000" | while read id url; do
    #check timeout to exit
    end=`date +%s`
    sucess=0
    runtime=$((end-start))
    #echo "Runtime: "$runtime
    if [ $runtime -gt 50 ] ; then
        echo "Time out!..."
        break
    fi
    
    echo "---------------------------------------------"
    echo ""
    echo "ART [ ${id}/${prev_id} ] with URL [ ${url} ]"
    
    if [ "$prev_id" -ne "$id" ]
    then
        tmp=$(mysql $dbargs --execute="SELECT IFNULL(\`images\`,'') FROM \`goods_prices\` WHERE \`id\`=${id}");
        unset images
        if [ -n "$tmp" ]; then
            images=${tmp//,/$' '}
        else
            images=()
        fi
        prev_id=$id
        echo "----------------"${#images[@]}"----------------"
        echo ${images[@]}
        echo "=>>NEW ID DETECTED :: "$id
    fi
    
    hash=$(mysql $dbargs --execute="SELECT \`hash\` FROM \`img_urls\` WHERE \`id\`=${url} AND \`hash\`<>''")
    if [ -n "$hash" ] ; then
        #HASH found - ADD it to image
        echo "=>>IMAGE [ ${hash} ] ALREADY DOWNLOADED... checking for duplicates"
        sucess=1
        case "${images[@]}" in
        *"${hash}"*)
            echo "ITEM ALREADY HAS THIS HASH! Abort."
        ;;
        *)
            updates="CONCAT(\`images\`,',','${hash}')"
            echo "----------------"${#images[@]}"----------------"
            if [ ${#images[@]} -eq 0 ]; then
                updates="'${hash}'"
            fi
            images=("${images[@]}" "${hash}")
            echo "=>>SUCCESSS ! New images for this entry is:"
            echo ${images[@]}
            echo "UPDATE \`goods_prices\` SET \`images\`=${updates} WHERE \`id\`=${id}"
            mysql $dbargs --execute="UPDATE \`goods_prices\` SET \`images\`=${updates} WHERE \`id\`=${id}"
            ;;
        esac
    #else
        #echo "=>>IMAGE WASN'T DOWNLOADED YET..."
    fi
    
    #If record changed succefully - mark image as 
    if [ "$sucess" -eq 0 ] ; then
        echo "UPDATE \`images\` SET \`state\`=\`state\`+1 WHERE \`art_id\`=${id} AND \`url_id\`=${url}"
        mysql $dbargs --execute="UPDATE \`images\` SET \`state\`=\`state\`+1 WHERE \`art_id\`=${id} AND \`url_id\`=${url}"
    else
        echo "UPDATE \`images\` SET \`state\`=0 WHERE \`art_id\`=${id} AND \`url_id\`=${url}"
        mysql $dbargs --execute="UPDATE \`images\` SET \`state\`=0 WHERE \`art_id\`=${id} AND \`url_id\`=${url}"
    fi
    
done