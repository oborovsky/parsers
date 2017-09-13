<?
ini_set("session.gc_maxlifetime","0");
if(!isset($NO_SESSION)) session_start();
if(!isset($NO_HEADER)) {
    header("Content-Type: text/html; charset=utf-8");
    header("Cache-Control: no-store, no-cache, must-revalidate");
    header("Cache-Control: post-check=0, pre-check=0",false);
    header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");  
    header("Last-Modified: ".gmdate("D, d M Y H:i:s")." GMT");  
    header("Pragma: no-cache");
}
set_time_limit(3600);
ini_set("allow_url_fopen",true);
ini_set("allow_url_include",true);
ini_set("gd.jpeg_ignore_warning",1);
ini_set("display_errors",1);
mb_internal_encoding("UTF-8");
mb_regex_encoding('UTF-8');
error_reporting(E_ALL);
define("COINS",100);
define("GRAMS",1000);
$KEY_XIN="X";
define("ROOT",realpath(dirname(__FILE__)).DIRECTORY_SEPARATOR); //.DIRECTORY_SEPARATOR.".."
define("LIB",ROOT."system".DIRECTORY_SEPARATOR."library".DIRECTORY_SEPARATOR);
define("SYSTEM",ROOT."system".DIRECTORY_SEPARATOR);
define("ICONSERVER","http://images.cuty.ru/icon/");
include(LIB."fbitmask.php"); // битовые маски
include(LIB."fmysql.php"); // работа с сиквелем
include(LIB."fhtml.php"); // аппендиксы сашинкота. убить их нахер, когда всё вычистим...
include(LIB."fforms.php"); // для выхлопов в формах
include(LIB."foutputmodifiers.php");// разные представления значений

// тут будем вычленять домен (всё маленькими буквами)
define("DOMAIN","max.cuty.ru");
define("DOMAIN2","max.6tema.com");
define("DB_ROOT_SERVER","localhost");define("DB_CLIENT_SERVER","localhost");define("DB_ROOT","gs3");define("DB_ROOT_USER","gs");define("DB_ROOT_PASSWD","kazk0der");
define("DB_PREFIX","gs3_");
$SUBDOMAIN=FALSE;
if (preg_match("/^(?:www\.)?([\w\d\-]+)\.(".DOMAIN."|".DOMAIN2.")/",$_SERVER["HTTP_HOST"],$match))
$SUBDOMAIN=$match[1];

// загрузили список всего того, что надо из глобальной БД
if(!isset($_SESSION['vars'])) {
    $tmp_link=mysql_connect(DB_ROOT_SERVER,DB_ROOT_USER,DB_ROOT_PASSWD) or die("Could not connect: ".mysql_error());
    mysql_select_db(DB_ROOT,$tmp_link);
    mysql_query("SET NAMES utf8",$tmp_link);
    if($tmp61=mysql_query("SELECT `title`,`content` FROM `system_config` WHERE `title` LIKE 'arr\_%' OR `title` LIKE 'var\_%'",$tmp_link))
    while($tmp62=mysql_fetch_row($tmp61)) {
        $tmp63=substr($tmp62[0],4);
        if($tmp62[0]{0}=="v") $_SESSION['vars'][$tmp63]=$tmp62[1];
        else $_SESSION['vars'][$tmp63]=unserialize($tmp62[1]);
    }
    mysql_close($tmp_link);
// теперь поверх загрузили то же самое из локальной
    if((!isset($MASTER_DB))&&($SUBDOMAIN)) {
        $tmp_link=mysql_connect(DB_CLIENT_SERVER,DB_PREFIX.$SUBDOMAIN) or die("Could not connect: ".mysql_error());
        mysql_select_db(DB_PREFIX.$SUBDOMAIN,$tmp_link);
        mysql_query("SET NAMES utf8",$tmp_link);
        if($tmp61=mysql_query("SELECT `title`,`content` FROM `system_config` WHERE `title` LIKE 'arr\_%' OR `title` LIKE 'var\_%'",$tmp_link))
        while($tmp62=mysql_fetch_row($tmp61)) {
            $tmp63=substr($tmp62[0],4);
            if($tmp62[0]{0}=="v") $_SESSION['vars'][$tmp63]=$tmp62[1];
            else if(isset($_SESSION['vars'][$tmp63])) $_SESSION['vars'][$tmp63]=array_merge($_SESSION['vars'][$tmp63],unserialize($tmp62[1]));
            else $_SESSION['vars'][$tmp63]=unserialize($tmp62[1]);
        }
    mysql_close($tmp_link);
    }
}
// вытащили из сессии всё, что там есть
if(isset($_SESSION['vars'])) foreach($_SESSION['vars'] as $tmp61=>$tmp62) $$tmp61=$tmp62;

function get_column_names() {
    global $PRICENAMES, $STOCKNAMES, $PRICEGROUPNAMES, $STOCKGROUPNAMES,$SUBDOMAIN;
    if(isset($STOCKNAMES)) return(TRUE);
    if(!isset($SUBDOMAIN)) die("No subdomain selected");
    $PRICENAMES=array(); $STOCKNAMES=array();
    foreach(explode(",",$_SESSION['vars']['SUBSCRIBES']) as $temp) {
        $PRICEGROUPNAMES[$temp]=array('descr'=>$_SESSION['vars']['MANUFACTURERS'][$temp],'count'=>sizeof($_SESSION['vars']['PRICES_'.$temp]));
        $STOCKGROUPNAMES[$temp]=array('descr'=>$_SESSION['vars']['MANUFACTURERS'][$temp],'count'=>sizeof($_SESSION['vars']['STOCKS_'.$temp]));
        $PRICENAMES[$temp]=$_SESSION['vars']['PRICES_'.$temp];
        $STOCKNAMES[$temp]=$_SESSION['vars']['STOCKS_'.$temp];
    }
    $t=mysql_q("SELECT `id`,`value` FROM `stocktypes` ORDER BY `order`");
    if(mysql_num_rows($t)) while($t1=mysql_fetch_row($t)) {
        $p=mysql_q("SELECT `id`,`value` FROM `stocks` WHERE `type`=".$t1[0]." ORDER BY `order`");
        $p1=mysql_num_rows($p);
        $STOCKGROUPNAMES[$SUBDOMAIN."_".$t1[0]]=array('descr'=>$t1[1],'count'=>$p1);
        if($p1>0) while($p2=mysql_fetch_row($p)) $STOCKNAMES[$SUBDOMAIN."_".$t1[0]][]=array($p2[0]=>$p2[1]);
    }
    $t=mysql_q("SELECT `id`,`value` FROM `pricetypes` ORDER BY `order`");
    if(mysql_num_rows($t)) while($t1=mysql_fetch_row($t)) {
        $p=mysql_q("SELECT `id`,`value` FROM `prices` WHERE `type`=".$t1[0]." ORDER BY `order`");
        $p1=mysql_num_rows($p);
        $PRICEGROUPNAMES[$SUBDOMAIN."_".$t1[0]]=array('descr'=>$t1[1],'count'=>$p1);
        if($p1>0) while($p2=mysql_fetch_row($p)) $PRICENAMES[$SUBDOMAIN."_".$t1[0]][]=array($p2[0]=>$p2[1]);
    }
}

if(isset($MASTER_DB)) {
    $std_connect=mysql_connect(DB_ROOT_SERVER,DB_ROOT_USER,DB_ROOT_PASSWD) or die("Could not connect: ".mysql_error($std_connect));
    mysql_select_db(DB_ROOT,$std_connect);
}
else {
    $std_connect=mysql_connect(DB_CLIENT_SERVER,DB_PREFIX.$SUBDOMAIN) or die("Could not connect: ".mysql_error($std_connect));
    mysql_select_db(DB_PREFIX.$SUBDOMAIN,$std_connect) or die("Invalid account");
}
mysql_query("SET NAMES utf8",$std_connect);
/* список функций

fbitmask.php
bitmask2array($in,$offset=0,$rev=FALSE) { // делает из HEX массив (in=строка, offset=база, rev=перевернуть строку)
array2bitmask($in,$offset=0,$amount=64,$rev=FALSE) { // делает из куска массива HEX для сиквеля
string2array($in) { // делает из CSV строки массив, в котором ключ=значение
array2string($in,$key=false) { // делает из массива строку через запятую. также убивает лишние запятые

fmysql.php
mysql_q($in) { // mysql_query with query printout
q($table,$id,$field,$type="T",$value=NULL) { // проверяет, изменилось ли значение и меняет его, если надо
qlist($table,$case="",$order=FALSE) { // список ID-шников [соответствующих условию] [отсортированных по полю order]

foutputmodifiers.php
uzer($in) { // из юзера делает имя юзера
klient($in,$in2=0) { // из клиента (и юр.лица) делает название клиента (и название юр.лица в виде массива)
redate($in) { // преобразует дату в/из сиквеля. на входе либо YYYY-MM-DD, либо [d]d{.-/}[m]m{.-/}[yy]yy, на выходе dd.mm.yyyy или YYYY-MM-DD

fforms.php
старые функции, которые бы надо бы переделать... :)
 * ADIN(описание инпута,значение,id поля в js,тип поля,класс передаваемый в js) - добавить инпут
 * ADBT(id кнопки в js,текст на кнопке,параметр) - добавить кнопку
 * ADCK(массив для дополнения, название, описание, 1/0) - добавить чекбокс
 * ADLH(название поля, заголовок текста, строка для добавления, массив доп.заголовков, класс css) - заголовок мультисорта
 * ADLI(массив для дополнения, текст, ID-шник записи, массив доп.полей, класс css) - строка мультисорта
 * ADTR(таблица, массив id:текст:parent:0/1, название для update, id корня) - делает дерево от корня

*/
?>
