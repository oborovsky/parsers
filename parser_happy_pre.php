<? 
// $MASTER_DB=1; $t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0); //$DEBUG=1;
define("ROOT","./");

$host = "localhost";
$user = "root";
$password = "k0les0";
$db = "test";

$lnk = mysql_connect($host, $user, $password) or die ("error in connect: ".mysql_error());
mysql_select_db($db) or die ("error in select db:".mysql_error());
mysql_query("SET NAMES utf8");

function mysql_($in) {echo $in;}
function mysql_q($in)
{
    $result = mysql_query($in) or die ("error in query: ".mysql_error());
    return $result;
}
function s($in)
{
    return mysql_real_escape_string($in) or die ("error in real escape string:".mysql_error());
}
function rec_g($in) {
    GLOBAL $trees;
    foreach($in->Группа as $b) {
        if(isset($trees[(string)$b->ИдРодителя])) $trees[(string)$b->Ид]=$trees[(string)$b->ИдРодителя].DIRECTORY_SEPARATOR.(string)$b->Наименование;
        else $trees[(string)$b->Ид]=(string)$b->Наименование;
        foreach($b->Группы as $a) rec_g($a);
    }
}

if(!$sqf=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."catalogue.xml")) die("oops");
if(!$sql=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."production.xml")) die("oops");
$brands=array();
$trees=array();
$ids=array();
$ibs=array();

echo "start:\n";

foreach($sql->Бренды->Бренд as $b1) $brands[(string)$b1->ИД] = "<brand id>".(string)($b1->Код)."<brand name>".(string)($b1->Наименование)."<brand end>";

echo "brends done\n";

rec_g($sql->Группы);

echo "groups done\n";
$KEY_HAPPY = 'H';
foreach($sqf->Товары->Товар as $t)
    $ids[(string)$t->ИД]="('".$KEY_HAPPY."','".mysql_real_escape_string((string)$t->Артикул)."','".mysql_real_escape_string($t->asXML());
echo "goods done\n";

foreach($sql->Номенклатура->Элемент as $t) {
    $x=(string)$t->ИД;
    if(isset($ids[$x])) {
        $ids[$x]=$ids[$x].mysql_real_escape_string($t->asXML());
        if(isset($t->Бренд)) {
            $y=(string)$t->Бренд;
            if(isset($brands[$y])) $ids[$x]=$ids[$x].mysql_real_escape_string($brands[$y]);
        }
        $ids[$x]=$ids[$x]."','".mysql_real_escape_string($trees[(string)$t->ИДРодителя])."')";
    }
}
$d=count($ids);
$elem = count($sql->Номенклатура->Элемент);
$goods = count($sqf->Товары->Товар);

echo "prepare done with $d items in ids, elem:$elem, goods:$goods\n";

$e=0;
echo "start insertin into db:\n";
foreach($ids as $r) {
    $e++;
    if(($e%10)==0) {
        mysql_q("INSERT INTO `tmp_goods`(`mfg`,`art`,`xml`,`cat`) VALUES ".implode(",",$ii));
        $ii=array($r);
    }
    else $ii[]=$r;
}
mysql_q("INSERT INTO `tmp_goods`(`mfg`,`art`,`xml`,`cat`) VALUES ".implode(",",$ii));
echo "all done:".$d;

//( CASE WHEN (`stock_happy_sklad`-`stock_happy_rez`) THEN (`stock_happy_sklad`-`stock_happy_rez`) ELSE 0 END)
/*
c6cd3e63b0e88c2019184b9780b9f367
b307792f6b8b690d0d08ff53be593ac0
7d2d0e4463710011dc851cbd0b31e29a
664f93f69e665f8ef6a1a6ef6b7419fa
383bc705a81f31a565c25f65d41f98a8
*/
// file_put_contents("test","INSERT INTO `tmp_goods`(`mfg`,`art`,`xml`,`cat`) VALUES ".implode(",\n",$ids));

?>