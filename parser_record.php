<?php
define("ROOT","./");

$host = "localhost";
$user = "root";
$password = "k0les0";
// $password = "4995";
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

if(!$tree=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."tree.xml")) die("oops");
if(!$products=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."catalogue.xml")) die("oops");

$cat=array();$out_array=array();

// создаем дерево категорий
// пока так потом переделаю всё чтоб хранилось в массиве 
// и по мере поиска товара заполнялись и категории
function make_cat($tree)
{
    GLOBAL $cat;
    foreach($tree->category as $category ) 
    {
        $id = (int)$category->id;
        $pid = (int)$category->pid;
        $name = (string)$category->name;
        $cat[$id] = array(
            'id'=>$id,
            'name'=>$name,
            'pid'=>$pid);
    }
    echo "всего категорий : ".count($cat)."\n"; 
}
function get_cat($id)
{
    GLOBAL $cat;

    if ( !isset($cat[$id]) ) return "";

    $name = $cat[$id]['name'];
    $pid = $cat[$id]['pid'];

    if ( $pid != -1 ) 
    {
        $tmp_name = get_cat($pid);
        if ( $tmp_name != "")
        {
            return $name = $tmp_name.DIRECTORY_SEPARATOR.$name;
        }
    }
    return $name;
}
function make_products($products)
{
    GLOBAL $cat, $out_array;
    $KEY_RAINBOW = "W";

    foreach($products->offer as $offer)
    {
        $art=(string)$offer->art;
        $cat_id = (int)$offer->parent_id;
        $category = get_cat($cat_id); 
        if ( $category == "")
        {
            echo "для art:$art катероия пуста, cat_id=$cat_id \n";
        }
        $data = $offer->asXML();
        $data = preg_replace('/&gt;/', '>', $data);
        $data = preg_replace('/&lt;/', '<', $data);
        // echo $data, "\n";
        $sql = "('".$KEY_RAINBOW."','".mysql_real_escape_string($art)."','".mysql_real_escape_string($category)."','".mysql_real_escape_string($data)."')";
        // echo $sql, "\n";
        $out_array[]=$sql;
    }
}
//переделываем немного картинки, чтобы было как в XINDAO

foreach ($products->offer as $offer) 
{
	$images = (string)$offer->images;
    // echo $images, "\n";
	$arr_images = explode(';', $images);
	$new_images = "";
    $offer->images="";
	foreach ($arr_images as $image)
	{
        $offer->images->addChild('image',$image);
	}
    $art = (string)$offer->art;
    if ( $art == "97.03")
    {
        
        $regx1 = "<img\s*?.*?>([^<]*?)<\/img.*?>";
        $regx2 = "<table(?:\s.*?[^\/]?>|>)(.+?)<\/table.*?>";
        $description = (string)$offer->description;
        preg_match_all("/".$regx1."/sm",$description,$result,PREG_SET_ORDER);
        if ( isset($result[0][0]))
        {
            $image = (string)$result[0][0];
            $xml = '<?xml version="1.0" standalone="yes"?>'.$image;
            // echo "xml:",$xml,"\n";
            // print_r($result);
            $image = simplexml_load_string($xml);
            // print_r(libxml_get_errors());
            $src = (string)$image['src'];
            // echo "src ",$src,"\n";
            $src = preg_replace("/^(\.{1,2})(\/.*)$/","http://ra-duga.ru$2", $src);
            // echo "src ",$src,"\n";
            $image->img['src'] = $src;
            $stringImage = $image->img->asXML();
            echo "image:",$stringImage , "\n";
            $stringImage = preg_replace('/\"/', "'", $stringImage);    
            echo "image:",$stringImage , "\n";
            $description = preg_replace("/(.*?)(".$regx1.")(.*?)/","", $description);
            $description = $description."<br/>".$stringImage;    
        }

        preg_match_all("/".$regx2."/sm",$description,$result,PREG_SET_ORDER);
        if ( isset($result[0][0]))
        {
            $table = (string)$result[0][0];
            $xml = "<doc>".$table."</doc>";
            $doc = simplexml_load_string($xml);
            $doc->table->addAttribute('border','1');
            $doc->table->addAttribute('rules','all');

            $table = (string)$doc->table->asXML();
            echo "table:",$table,"\n";
            $table = preg_replace('/\"/', "'", $table);    
            echo "table:",$table,"\n";

            $description = preg_replace("/(.*?)(".$regx2.")(.*?)/","", $description);
            $description = $description."<br/>".$table;
        }
        $offer->description = $description;
        // $data = $offer->asXML();
        // $data = preg_replace('/&gt;/', '>', $data);
        // $data = preg_replace('/&lt;/', '<', $data);
        // echo $data,"\n";
        // echo "--------------------\n";
        // $offer->description = $description;
        // echo "offer->asXML :",$offer->asXML(),"\n";
    }
    // foreach ($offer->images->image as $image) 
    // {
    //     echo "\t",(string)$image->asXML(), "\n";
    // }
	// $offer->images = $new_images;
    }

make_cat($tree);
// print_r($cat);

make_products($products);

$d=count($out_array);
if($d) mysql_q("INSERT INTO `tmp_goods`(`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$out_array));
echo "done:".$d."\n";
?>