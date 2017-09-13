<? 
// $t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0); //$DEBUG=1;

// include common.php
set_time_limit(3600);
//ini_set("display_errors",1);
mb_internal_encoding("UTF-8");
mb_regex_encoding('UTF-8');
//error_reporting(E_ALL);

@session_start();
$ptime=microtime(TRUE);

define("DB_SERVER","localhost");
define("DB_USER","root");
define("DB_PASSWD","k0les0");
define("DB_BASE","cuty_cat");
define("COINS",100);
define("GRAMS",1000);
// define("ROOT",realpath(dirname(__FILE__)).DIRECTORY_SEPARATOR); 
mysql_connect(DB_SERVER,DB_USER,DB_PASSWD) or die("can't connect".mysql_error());
mysql_query("SET NAMES utf8");
mysql_select_db(DB_BASE) or die("wrong DB");
define("ICONSERVER","$");
// functions
function q_($in,$out=0) 
{
    $t=mysql_query($in);
    if($out==0) return($t);
    if($out==-1) return(mysql_num_rows($t));
    if($out==-2) return(mysql_affected_rows());
    if(mysql_num_rows($t)==0) return(FALSE);
    $p=mysql_fetch_row($t);
    if($out==1) return($p[0]);
    return($p); 
}

function suicide()
{
    if(func_num_args()<1) die("Oops");
    if(func_num_args()>1) foreach(func_get_args() as $i=>$fu)
    if($i>0) q_("DROP TABLE IF EXISTS `".$fu."`");
    die(func_get_arg(0)); 
}

//----------------------------------------------------------


$vars_file="../in".DIRECTORY_SEPARATOR."vars_1.csv";
$bits_file="../in".DIRECTORY_SEPARATOR."bits_0.csv";
$item_file="../in".DIRECTORY_SEPARATOR."items_0.csv";
//$olds_file="in".DIRECTORY_SEPARATOR."olditems_0.csv";
$tree_file="../in".DIRECTORY_SEPARATOR."bitmasks_0.csv";
?>
<br><? echo date(DATE_RFC2822); ?>
<br>Start...
<br><?

$match=array("."," ","/","\\","-","_","(",")","*","\"","'","`","~","#","%","+","=","[","]","\t");
file_exists($vars_file) or die("no file");
is_readable($vars_file) or die("no access");
$handle=fopen($vars_file, 'r') or die("not readable");
$p=fgetcsv($handle) or die("no file contents");
fclose($handle);
if(count($p)!=6) die("incorrect file");
if($p[5]!="end") die("incorrect CRC");
unset($p[5]);
list($amount_tree,$amount_bits,$amount_item,$p2,$bitrows)=$p;
list($p21,$p22)=explode("[paramtypes]",$p2);
file_put_contents("..".DIRECTORY_SEPARATOR."js".DIRECTORY_SEPARATOR."cat_vars.js","//Revision: 2\nvar totalAmount=".$amount_item.";\nvar updateDate='".date("d.m.Y H:i:s")."';\n");
$paramnames=unserialize(stripcslashes($p21)) or die("can't parse params");
q_("REPLACE `config` SET `nam`='params',`val`='".mysql_real_escape_string(stripcslashes($p21))."'");
q_("REPLACE `config` SET `nam`='paramtypes',`val`='".mysql_real_escape_string(stripcslashes($p22))."'");
$unique=uniqid();
$bits_t="bits_".$unique;
$item_t="items_".$unique;
//$olds_t="olds_".$unique;
$tree_t="tree_".$unique;
$arts_t="arts_".$unique;
$artz_t="artz_".$unique;
$roots_t="roots_".$unique;
$trees_t="trees_".$unique;
$mods_t="mods_".$unique;

$handle=fopen($bits_file, 'r');
if(!$handle) die("not readable");
$a="CREATE TABLE `".$bits_t."` (`id` INT UNSIGNED NOT NULL"; for($i=0;$i<=$bitrows;$i++) $a.=", `bit".$i."` BIGINT UNSIGNED NOT NULL"; $a.=", PRIMARY KEY (`id`))";
q_($a);
$a="INSERT INTO `".$bits_t."` (`id`"; for($i=0;$i<=$bitrows;$i++) $a.=", `bit".$i."`"; $a.=") VALUES ";
$g=array();$i=0;
while($p=fgetcsv($handle)) $g[$i++]="(".implode(",",$p).")";
fclose($handle);

$q=microtime(TRUE)-$ptime; echo "All bits read successfully... ".$q."
<br>"; flush();

$cnt=0; $t=0;
while($cnt<$i) {$t+=q_($a.implode(",",array_slice($g,$cnt,200)),-2);$cnt+=200;}
// echo "$t , $amount_bits , $i";
if(($t!=$amount_bits)||($t!=$i)) suicide("wrong BITS",$bits_t);

$q=microtime(TRUE)-$ptime; echo "All bits uploaded successfully... ".$q."
<br>"; flush();

$handle=fopen($item_file, 'r');
if(!$handle) suicide("not readable",$bits_t);
q_("CREATE TABLE `".$item_t."` (`id` INT UNSIGNED NOT NULL, `arts` TEXT NOT NULL, `descr` TEXT NOT NULL, `params` TEXT NOT NULL, `images` TEXT COLLATE utf8_bin NOT NULL, `price` INT NOT NULL, `amount` INT NOT NULL, `price_view` TEXT COLLATE utf8_bin NOT NULL, `isnew` BIT(1) NOT NULL DEFAULT 0, PRIMARY KEY (`id`))");
q_("CREATE TABLE `".$arts_t."` (`id`  INT UNSIGNED NOT NULL AUTO_INCREMENT, `artid` INT UNSIGNED NOT NULL, `art` TEXT COLLATE utf8_bin NOT NULL, PRIMARY KEY (`id`), UNIQUE KEY (`artid`, `art`(30)),KEY (`art`(30)) )");
$a="INSERT INTO `".$item_t."` (`id`,`arts`,`descr`,`params`,`images`,`price`,`amount`,`price_view`, `isnew`) VALUES ";
$a1="INSERT INTO `".$arts_t."` (`artid`,`art`) VALUES ";
$g=array(); $g1=array();$i=0; $i1=0;
//echo "<pre>";
while($p=fgetcsv($handle)) {
    //print_r($p);
    $p01=($p[8]==0)? $p[7] : $p[8];
    $p02=($p[11]==0)? $p[10] : $p[11];
    $p03=($p[17]==1)? "1" : "0";
    $g[$i++]="(".$p[0].",'".mysql_real_escape_string(stripcslashes($p[1]))."','".mysql_real_escape_string(stripcslashes($p[4]))."','".
    mysql_real_escape_string(stripcslashes($p[5]))."','".mysql_real_escape_string(stripcslashes($p[6]))."',".$p01.",".$p02.",'".$p[13]."',".$p03.")";
    //echo $g[$i-1]."<br>";
    //echo "[".$p[16]."]<br>";
    foreach(explode(",",$p[1]) as $pp)
    $g1[$i1++]="(".$p[0].",'".mb_convert_case(mysql_real_escape_string(str_replace($match,"",$pp)), MB_CASE_LOWER, "UTF-8")."')";
}
//echo "</pre>";
fclose($handle);
//suicide("TEST",$bits_t,$item_t,$arts_t);

$q=microtime(TRUE)-$ptime; echo "All items read successfully... ".$q."
<br>"; flush();

$cnt=0; $t=0;
while($cnt<$i) {$t+=q_($a.implode(",",array_slice($g,$cnt,100)),-2);$cnt+=100;}
if(($t!=$amount_item)||($t!=$i)) suicide(mysql_error()."wrong ITEMS [".$t." != ".$amount_item."]",$bits_t,$item_t,$arts_t);

$q=microtime(TRUE)-$ptime; echo "All items uploaded successfully... ".$q."
<br>"; flush();

$cnt=0; $t=0;
while($cnt<$i1) {$t+=q_($a1.implode(",",array_slice($g1,$cnt,500)),-2);$cnt+=500;}
if($t!=$i1) suicide("wrong ITEM DUPES",$bits_t,$item_t,$arts_t);

$q=microtime(TRUE)-$ptime; echo "All dupes uploaded successfully... ".$q."
<br>"; flush();


/*$handle=fopen($olds_file, 'r');
if(!$handle) suicide("not readable",$bits_t,$item_t,$arts_t);
q_("CREATE TABLE `".$olds_t."` (`id` INT UNSIGNED NOT NULL, `arts` TEXT NOT NULL, `descr` TEXT NOT NULL, `params` TEXT NOT NULL, `images` TEXT COLLATE utf8_bin NOT NULL, `price` INT NOT NULL, `amount` INT NOT NULL, `price_view` TEXT COLLATE utf8_bin NOT NULL, PRIMARY KEY (`id`))");
q_("CREATE TABLE `".$artz_t."` (`id`  INT UNSIGNED NOT NULL AUTO_INCREMENT, `artid` INT UNSIGNED NOT NULL, `art` TEXT COLLATE utf8_bin NOT NULL, PRIMARY KEY (`id`), UNIQUE KEY (`artid`, `art`(30)),KEY (`art`(30)) )");
$a="INSERT INTO `".$olds_t."` (`id`,`arts`,`descr`,`params`,`images`,`price`,`amount`,`price_view`) VALUES ";
$a1="INSERT INTO `".$artz_t."` (`artid`,`art`) VALUES ";
$g=array(); $g1=array();$i=0; $i1=0;
while($p=fgetcsv($handle)) {
    $p01=($p[8]==0)? $p[7] : $p[8];
    $p02=($p[11]==0)? $p[10] : $p[11];
    $g[$i++]="(".$p[0].",'".mysql_real_escape_string(stripcslashes($p[1]))."','".mysql_real_escape_string(stripcslashes($p[4]))."','".
    mysql_real_escape_string(stripcslashes($p[5]))."','".mysql_real_escape_string(stripcslashes($p[6]))."',".$p01.",".$p02.",'".$p[13]."')";
    foreach(explode(",",$p[1]) as $pp)
    $g1[$i1++]="(".$p[0].",'".mb_convert_case(mysql_real_escape_string(str_replace($match,"",$pp)), MB_CASE_LOWER, "UTF-8")."')";
}
fclose($handle);

$q=microtime(TRUE)-$ptime; echo "All old items read successfully... ".$q."
<br>"; flush();

$cnt=0; $t=0;
while($cnt<$i) {$t+=q_($a.implode(",",array_slice($g,$cnt,100)),-2);$cnt+=100;}
if(($t!=$amount_olds)||($t!=$i)) suicide("wrong OLD ITEMS",$bits_t,$item_t,$arts_t,$olds_t,$artz_t);

$q=microtime(TRUE)-$ptime; echo "All old items uploaded successfully... ".$q."
<br>"; flush();

$cnt=0; $t=0;
while($cnt<$i1) {$t+=q_($a1.implode(",",array_slice($g1,$cnt,500)),-2);$cnt+=500;}
if($t!=$i1) suicide("wrong OLD ITEM DUPES",$bits_t,$item_t,$arts_t,$olds_t,$artz_t);

$q=microtime(TRUE)-$ptime; echo "All old dupes uploaded successfully... ".$q."
<br>"; flush();*/


$handle=fopen($tree_file, 'r');
if(!$handle) suicide("not readable",$bits_t,$item_t,$arts_t,$olds_t,$artz_t);
q_("CREATE TABLE `".$tree_t."` ( `id` INT UNSIGNED NOT NULL, `parent` INT UNSIGNED NOT NULL, `value` TEXT NOT NULL, `order` INT UNSIGNED NOT NULL, `settings` BIGINT UNSIGNED NOT NULL, PRIMARY KEY (`id`))");
$a="INSERT INTO `".$tree_t."` (`id`,`parent`,`value`,`order`,`settings`) VALUES ";
$g=array();$i=0;
while($p=fgetcsv($handle)) {
    $p[2]="'".mysql_real_escape_string(stripcslashes($p[2]))."'";
    $g[$i++]="(".implode(",",$p).")";
}
fclose($handle);

$q=microtime(TRUE)-$ptime; echo "All trees read successfully... ".$q."
<br>"; flush();

$cnt=0; $t=0;
while($cnt<$i) {$t+=q_($a.implode(",",array_slice($g,$cnt,500)),-2);$cnt+=500;}
if(($t!=$amount_tree)||($t!=$i)) suicide("wrong TREE",$bits_t,$item_t,$arts_t,$olds_t,$artz_t,$tree_t);

$q=microtime(TRUE)-$ptime; echo "All trees uploaded successfully... ".$q."
<br>"; flush();

q_("CREATE TABLE `".$roots_t."` (`id` INT UNSIGNED NOT NULL, `value` TEXT NOT NULL, `settings` BIGINT UNSIGNED NOT NULL, `count` INT UNSIGNED NOT NULL)");
q_("CREATE TABLE `".$trees_t."` (`id` INT UNSIGNED NOT NULL, `value` TEXT NOT NULL, `settings` BIGINT UNSIGNED NOT NULL, `count` INT UNSIGNED NOT NULL, `parent` INT UNSIGNED NOT NULL)");
q_("CREATE TABLE `".$mods_t."` (`id` INT UNSIGNED NOT NULL, `id2` INT UNSIGNED NOT NULL, `amount` INT UNSIGNED NOT NULL");

q_("INSERT INTO `".$roots_t."` (`id`,`value`,`settings`,`count`) SELECT `id`,`value`,`settings`,0 FROM `".$tree_t."` WHERE (`settings` & POW(2,47) AND `settings` & POW(2,41)) ORDER BY `order`");
if($tmp_a=q_("SELECT `id` FROM `".$roots_t."`"))
    while($tmp_b=mysql_fetch_row($tmp_a)) {
        $tmpo=$tmp_b[0]>>6; $tmpp=$tmp_b[0]%64;
        $t=q_("SELECT COUNT(*) FROM `".$bits_t."` WHERE (`bit".$tmpo."` & POW(2,".$tmpp."))",1);
        q_("UPDATE `".$roots_t."` SET `count`=".$t." WHERE `id`=".$tmp_b[0]);
        q_("INSERT INTO `".$trees_t."` (`id`,`value`,`settings`,`parent`,`count`) SELECT `id`,`value`,`settings`,".$tmp_b[0].",0 FROM `".$tree_t."` WHERE (`parent`=".$tmp_b[0]." AND `settings` & POW(2,41) AND `settings` & POW(2,42) AND ~`settings` & POW(2,43)) ORDER BY `order`");
        q_("INSERT INTO `".$trees_t."` (`id`,`value`,`settings`,`parent`,`count`) SELECT `id`,`value`,`settings`,".$tmp_b[0].",0 FROM `".$tree_t."` WHERE (`parent`=".$tmp_b[0]." AND `settings` & POW(2,41) AND `settings` & POW(2,42) AND `settings` & POW(2,43)) ORDER BY `order`");
        q_("INSERT INTO `".$trees_t."` (`id`,`value`,`settings`,`parent`,`count`) SELECT `id`,`value`,`settings`,".$tmp_b[0].",0 FROM `".$tree_t."` WHERE (`parent`=".$tmp_b[0]." AND `settings` & POW(2,41) AND ~`settings` & POW(2,42) AND ~`settings` & POW(2,43)) ORDER BY `order`");
        q_("INSERT INTO `".$trees_t."` (`id`,`value`,`settings`,`parent`,`count`) SELECT `id`,`value`,`settings`,".$tmp_b[0].",0 FROM `".$tree_t."` WHERE (`parent`=".$tmp_b[0]." AND `settings` & POW(2,41) AND ~`settings` & POW(2,42) AND `settings` & POW(2,43)) ORDER BY `order`");
        $tmp_e=q_("SELECT `id` FROM `".$tree_t."` WHERE `parent`=".$tmp_b[0]);
            while($tmp_f=mysql_fetch_row($tmp_e)) {
                $tmpo=$tmp_f[0]>>6; $tmpp=$tmp_f[0]%64;
                $t=q_("SELECT COUNT(*) FROM `".$bits_t."` WHERE (`bit".$tmpo."` & POW(2,".$tmpp."))",1);
                q_("UPDATE `".$trees_t."` SET `count`=".$t." WHERE `id`=".$tmp_f[0]);
            }
    }
    
$q=microtime(TRUE)-$ptime; echo "All trees built successfully... ".$q."
<br>"; flush();
    
q_("INSERT INTO `".$trees_t."` (`id`,`value`,`settings`,`parent`,`count`) SELECT `id`,`value`,`settings`,0,0 FROM `".$tree_t."` WHERE (`settings` & POW(2,41) AND `settings` & POW(2,44)) ORDER BY `order`");
$tmp_e=q_("SELECT `id` FROM `".$trees_t."` WHERE `parent`=0");
    while($tmp_f=mysql_fetch_row($tmp_e)) {
        $tmpo=$tmp_f[0]>>6; $tmpp=$tmp_f[0]%64;
        $t=q_("SELECT COUNT(*) FROM `".$bits_t."` WHERE (`bit".$tmpo."` & POW(2,".$tmpp."))",1);
        q_("UPDATE `".$trees_t."` SET `count`=".$t." WHERE `id`=".$tmp_f[0]);
    }
    
$q=microtime(TRUE)-$ptime; echo "All trees counted successfully... ".$q."
<br>"; flush();
    
$bits_o=q_("SELECT `val` FROM `config` WHERE `nam`='bits'",1);
$item_o=q_("SELECT `val` FROM `config` WHERE `nam`='item'",1);
//$olds_o=q_("SELECT `val` FROM `config` WHERE `nam`='olds'",1);
$tree_o=q_("SELECT `val` FROM `config` WHERE `nam`='tree'",1);
$arts_o=q_("SELECT `val` FROM `config` WHERE `nam`='arts'",1);
$artz_o=q_("SELECT `val` FROM `config` WHERE `nam`='artz'",1);
$roots_o=q_("SELECT `val` FROM `config` WHERE `nam`='roots'",1);
$trees_o=q_("SELECT `val` FROM `config` WHERE `nam`='trees'",1);
$mods_o=q_("SELECT `val` FROM `config` WHERE `nam`='mods'",1);

q_("REPLACE `config` SET `nam`='bits',`val`='".$bits_t."'");
q_("REPLACE `config` SET `nam`='item',`val`='".$item_t."'");
//q_("REPLACE `config` SET `nam`='olds',`val`='".$olds_t."'");
q_("REPLACE `config` SET `nam`='tree',`val`='".$tree_t."'");
q_("REPLACE `config` SET `nam`='arts',`val`='".$arts_t."'");
q_("REPLACE `config` SET `nam`='artz',`val`='".$artz_t."'");
q_("REPLACE `config` SET `nam`='roots',`val`='".$roots_t."'");
q_("REPLACE `config` SET `nam`='trees',`val`='".$trees_t."'");
q_("REPLACE `config` SET `nam`='mods',`val`='".$mods_t."'");

q_("REPLACE `config` SET `nam`='bitcount',`val`='".$bitrows."'");
if($bits_o) q_("DROP TABLE IF EXISTS `".$bits_o."`");
if($item_o) q_("DROP TABLE IF EXISTS `".$item_o."`");
//if($olds_o) q_("DROP TABLE IF EXISTS `".$olds_o."`");
if($tree_o) q_("DROP TABLE IF EXISTS `".$tree_o."`");
if($arts_o) q_("DROP TABLE IF EXISTS `".$arts_o."`");
if($artz_o) q_("DROP TABLE IF EXISTS `".$artz_o."`");
if($roots_o) q_("DROP TABLE IF EXISTS `".$roots_o."`");
if($trees_o) q_("DROP TABLE IF EXISTS `".$trees_o."`");
if($mods_o) q_("DROP TABLE IF EXISTS `".$mods_o."`");

$q=microtime(TRUE)-$ptime; echo "All tables created... ".$q."
<br>"; flush();


q_("ALTER TABLE `".$item_t."` ADD FULLTEXT `descr` (`descr`)");
q_("ALTER TABLE `".$tree_t."` ADD FULLTEXT `value` (`value`)");

$q=microtime(TRUE)-$ptime; echo "All tables optimized... ".$q."
<br>"; flush();
//111
?>
Everything done.