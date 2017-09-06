<?php
$MASTER_DB=1; $t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0); //$DEBUG=1;

function mysql_($in) {echo $in;}

// function mysql_q($in)
// {
//     $result = mysql_query($in) or die ("error in query: ".mysql_error());
//     return $result;
// }

function s($in)
{
    return mysql_real_escape_string($in) or die ("error in real escape string:".mysql_error());
}

if(!$tree=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."rainbow".DIRECTORY_SEPARATOR."tree.xml")) die("oops");
if(!$products=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."rainbow".DIRECTORY_SEPARATOR."catalogue.xml")) die("oops");

$cat=array();$out_array=array();

// создаем дерево категорий
// пока так потом переделаю всё чтоб хранилось в массиве 
// и по мере поиска товара заполнялись и категории
//(переделал)
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
    GLOBAL $cat, $out_array,$KEY_RAINBOW;
    // $KEY_RAINBOW = "W";

    foreach($products->offer as $offer)
    {
        $art=(string)$offer->art;
        $cat_id = (int)$offer->parent_id;
        $category = get_cat($cat_id); 
        if ( $category == "")
        {
            echo "для art:$art катероия пуста, cat_id=$cat_id \n";
        }
        $out_array[]="('".$KEY_RAINBOW."','".mysql_real_escape_string($art)."','".$category."','".mysql_real_escape_string($offer->asXML())."')";
    }
}
//переделываем немного картинки, чтобы было как в XINDAO

foreach ($products->offer as $offer) 
{
	$images = (string)$offer->images;
	$arr_images = explode(';', $images);
	$new_images = "";
	foreach ($arr_images as $image)
	{
		$new_images = $new_images."<image>".$image."</image>";
	}
	$offer->images = $new_images;
}

make_cat($tree);
// print_r($cat);

make_products($products);

$d=count($out_array);
// if($d) mysql_q("INSERT INTO `tmp_goods`(`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$out_array));
file_put_contents("test", "INSERT INTO `tmp_goods`(`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$out_array));
echo "done:".$d."\n";
?>