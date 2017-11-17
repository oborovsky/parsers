<? $MASTER_DB=1;
//$t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0); //$DEBUG=1;
function mysql_($in) {echo $in;}
$KEY_OCEAN = "C";
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
    $xml = "";
    $xml = $xml."<name>".$item->name."</name>";
    $catsId = $item->categories[0];
    if ( $item->brand != null ) $xml = $xml."<brand>".$item->brand."</brand>";
    if ( $item->material != null ) $xml = $xml."<material>".$item->material."</material>";
    if ( $item->weight != null ) $xml = $xml."<weight>".$item->weight."</weight>";
    $xml = $xml."<descr>".$item->info."</descr>";


    foreach ($item->colors as $color)
    {
        $xml = $xml."<color>".$color->color->name."</color>";
        $images = "";
        foreach ($color->photos as $photo)
        {
            $images = $images."<image>http://www.oceangifts.ru".$photo."</image>";
        }

        foreach ($color->sizes as $size)
        {
            $art  = $size->article;
            if( $art == "2025DKR.18")
            {
                if( $size->size != null ) $xml = $xml."<size>".$size->size."</size>";
                $xml = $xml."<price>".$size->price."</price><images>".$images."</images>";

                $total_amount = 0;
                foreach ($size->stores->remains as $store)
                {
                    $total_amount += $store->count;
                }
                $xml = $xml."<amount>".$total_amount."</amount>";

                $out_array[] = "('".$KEY_OCEAN."','".$art."','".$cats[$catsId]."','".$xml."')";
            }
        }
    }
}

$d=count($out_array);
if($d) mysql_("INSERT INTO `tmp_goods`(`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$out_array));
echo "\n done:".$d;

?>