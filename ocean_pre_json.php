<?php
 // $MASTER_DB=1;
//$t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0); //$DEBUG=1;

// ini_set('display_errors', true);
// error_reporting(E_ALL);

header("Content-Type: text/plain; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0",false);
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");  
header("Last-Modified: ".gmdate("D, d M Y H:i:s")." GMT");  
header("Pragma: no-cache");

$start = microtime(true);
$host = "localhost";
$user = "root";
// $password = "4995";
$password = "k0les0";
$db = "test";
$table = "tmp_goods";

$lnk = mysql_connect($host, $user, $password) or die("error in connect: ".mysql_error());
mysql_select_db($db,$lnk) or die("error in select db: ".mysql_error());
mysql_query("set names utf8");

echo " start\n";

function mysql_q($in) 
{
    $result = mysql_query($in) or die("error in query: ".mysql_error());
    return $result;
}
function s($in)
{
    return mysql_real_escape_string($in);
}
define("ROOT","./");
$KEY_OCEAN = "C";

function mysql_($in) {echo $in;}

$json_string = file_get_contents("in/catalog.json");
if ( $json_string === false) 
{
    die("cant't read file in/catalog.json");
}

$catalog = json_decode($json_string);
// var_dump($catalog->categories);
$cats = array();

function make_cats($categories, $catString)
{
    GLOBAL $cats;

    if ($catString != "") $catString = $catString.DIRECTORY_SEPARATOR;

    foreach ($categories as $category) 
    {
        $id = $category->id;
        $name = $catString.$category->name;
        $cats[$id] = $name;

        if ( property_exists($category, "subcategories") )
        {
            make_cats($category->subcategories, $name);
        }
    }    
}

make_cats($catalog->categories, "");
//var_dump($cats);
$items = $catalog->products;
// var_dump($items[0]);
$out_array = array();

foreach ($items as $item) 
{   
    if( $item->main_id == 34084)
    {
        $xml = "<item>\n";
        $xml = $xml."<name>".$item->name."</name>\n";
        $mainSize = $item->size;
        $catsId = $item->categories[0];
        if ( $item->brand != null ) $xml = $xml."<brand>".$item->brand."</brand>\n";
        if ( $item->material != null ) $xml = $xml."<material>".$item->material."</material>\n";
        if ( $item->weight != null ) $xml = $xml."<weight>".$item->weight."</weight>\n";
        $xml = $xml."<descr>".$item->info."</descr>\n";

        $plottings = "";

        foreach ($item->plottings as $plotting)
        {
            $printings = $printings.$plotting->place." - ";
            foreach ($plotting->works as $work)
            {
                $printings = $printings.$work.",";
            }  
            $printings = rtrim($printings,",")."<br>";
        }
        $printings = rtrim($printings,">");
        $printings = rtrim($printings,"r");
        $printings = rtrim($printings,"b");
        $printings = rtrim($printings,"<");

        if ($printings != "") $xml = $xml."<print>".$printings."</print>";

        foreach ($item->colors as $color)
        {
            $xml_1 = $xml;
            $xml_1 = $xml_1."<color>".$color->color->name."</color>\n";
            $images = "";
            foreach ($color->photos as $photo)
            {
                $images = $images."<image>http://www.oceangifts.ru".$photo."</image>\n";
            }

            foreach ($color->sizes as $size)
            {
                $xml_2 = $xml_1;
                $art  = $size->article;
                 // if( $art == "41034-61")
                 // {
                    if( $size->size != null ) 
                    {
                        $xml_2 = $xml_2."<size>".$size->size."</size>\n";
                    }
                    else 
                    {
                        if ($mainSize != null) $xml_2 = $xml_2."<size>".$mainSize."</size>\n";
                    }

                    $xml_2 = $xml_2."<price>".$size->price."</price>\n<images>\n".$images."</images>\n";

                    $total_amount = 0;
                    foreach ($size->stores->remains as $store)
                    {
                        $total_amount += $store->count;
                    }
                    $xml_2 = $xml_2."<amount>".$total_amount."</amount>\n</item>";

                    $out_array[] = "('".$KEY_OCEAN."','".s($art)."','".$cats[$catsId]."','".s($xml_2)."')";
                 // }
            }
        }
    }
}
 // print_r($out_array);
$d=count($out_array);
$e=0;
$ii=array();
echo " start inserting :\n ";
foreach($out_array as $r) {
    $e++;

    if(($e%10)==0) {
        $sql = "INSERT INTO `tmp_goods` (`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$ii);
        mysql_q($sql);
        $ii=array($r);
    }
    else $ii[]=$r;
}
 mysql_q("INSERT INTO `tmp_goods`(`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$ii));
$time = microtime(true) - $start;
echo "done:".$e."\n time:".$time."\n";

// if($d) mysql_("INSERT INTO `tmp_goods`(`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$out_array));
echo "\n recods:".$d."\n";

?>