rm -f *.log

/usr/bin/wget -N --progress=bar:force http://ra-duga.ru/offers.php?pwd=123456r -a wget.log -O catalogue_rainbow.xml
/usr/bin/wget -N --progress=bar:force http://ra-duga.ru/categorys.php?pwd=123456r -a wget.log -O tree_rainbow.xml

echo "Rainbow Done"

