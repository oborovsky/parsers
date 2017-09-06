rm -f *.log

/usr/bin/wget --progress=bar:force http://ra-duga.ru/offers.php?pwd=123456r -a wget.log -O catalogue.xml
/usr/bin/wget --progress=bar:force http://ra-duga.ru/categorys.php?pwd=123456r -a wget.log -O tree.xml

echo "Rainbow Done"

