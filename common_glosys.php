<?
//phpinfo();
header("Content-Type: text/html; charset=utf-8");
header("Cache-Control: no-store, no-cache, must-revalidate");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");  
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");  
header("Pragma: no-cache");
define('XML',"/home/glosys/htdocs/inp/");
define('ROOT',"/home/glosys/htdocs/new/sclap/");
define('THUMBS',ROOT."thumbs/");
define('WROOT',"/new/sclap/");
define('WTHUMBS',WROOT."thumbs/");
define('DBF',"d3c_work");
define('CURRENT_DL',177);
define('ADEQUATE_DL',176);
define('LOCALXML',"/home/glosys/htdocs/out/");
define('LOCALHOME',"/home/glosys/htdocs/");
set_time_limit(3600);
ini_set("allow_url_fopen", true);
ini_set("allow_url_include", true);
ini_set("gd.jpeg_ignore_warning", 1);
//ini_set('display_errors',1);
//error_reporting(E_ALL);
//$ocean=array("ocean_wares.xml","galery_wares.xml","expresstime_wares.xml","new2012_wares.xml"); 
//$ocean_files=array("ocean_files.xml","galery_files.xml","expresstime_files.xml","new2012_files.xml");
//$ocean_names=array("Океан","Галерея","Express Time","Новинки 2012");
$ocean=array("ocean_wares.xml","galery_wares.xml","expresstime_wares.xml"); //,"new2012_wares.xml"); 
$ocean_files=array("ocean_files.xml","galery_files.xml","expresstime_files.xml"); //,"new2012_files.xml");
$ocean_names=array("Океан","Галерея","Express Time"); //,"Новинки 2012");
//$oasis=array("oasis2013.xml","penoteka2012.xml","textil2012.xml","oasisexclusive2013.xml","thecatalog2012.xml");
//$oasis_names=array("Каталог OASIS","OASIS: пенотека","OASIS: текстиль","OASIS: эксклюзив","the Catalogue");
$oasis=array("oasis2014.xml","penoteka2013.xml","textil2013.xml","oasisexclusive2014.xml","thecatalog2013.xml");
$oasis_names=array("Каталог OASIS","OASIS: пенотека","OASIS: текстиль","OASIS: эксклюзив","the Catalogue");
$mid_files=array("prodinfo_RU.xml","prodinfo_TEXTILE_RU.xml");
$mid_amounts=array("stock.xml","stock_textile.xml");
$all_mfg=array("H","G","O","S","Q","M","E");
$all_mfg_txt=array("Каталог Happy","Каталог 111","Каталог OCEAN","Каталог OASIS","Локальный склад","MIDOCEANBRANDS","Каталог E-Bazaar");
$all_xml_folders=array(XML."happy/",XML."project111/",XML."ocean/",XML."oasis/",LOCALXML,XML."mid/",XML."ebazar/");
    $debugparser=array(
                  "set_param_0"=>0,
                  "set_param_1"=>0,
                  "get_items_0"=>0,
                  "get_items_1"=>0,
                  "get_items_2_0"=>0,
                  "get_items_2_1"=>0,
                  "get_param_0"=>0,
                  "get_param_1"=>0,
                  "get_param_2"=>0,
                  "empty_param_0"=>0,
                  "empty_param_1"=>0,
                  "similar_set_prarm_0"=>0,
                  "similar_set_prarm_1"=>0,
                  "catalogue_set_param_0"=>0,
                  "catalogue_set_param_1"=>0,
                  "catalogue_set_param_2"=>0,
                  "set_cat_0"=>1,
                  "set_cat_1"=>1,
                  "make_new_param_0"=>0,
                  "make_new_param_1"=>0,
                  "create_cat_0"=>1,
                  "create_cat_1"=>1,
                  "create_cat_2"=>1,
                  "recursive_cat_0"=>1,
                  "recursive_param_0"=>0,
                  "insert_art_0"=>0,
                  "insert_art_1"=>1,
                  "insert_art_2"=>1,
                  "insert_art_3"=>1,
                  "insert_art_4"=>0,
                  "in_catalogue_0"=>1,
                  "cat_name_0"=>1,
                  "param_name_0"=>0,
                  "home_cats_0"=>1,
                  "home_cats_1"=>1,
                  "kill_cats_0"=>1,
                  "kill_cats_1"=>1,
                  "kill_cats_2"=>1,
                  "tree_params_chk_0"=>0,
                  "tree_params_chk_1"=>0,
                  "root_params_0"=>1,
                  "params_load_0"=>0,
                  "params_load_1"=>0
                  );
mysql_connect("localhost","glosys","design");
mysql_select_db(DBF);
mysql_query("SET NAMES utf8");
mysql_query("SET group_concat_max_len = 10000000");
$db_table="catalog_temp";
$db_cats="temp_cats";
$db_params="catalog_params";
$db_logs="zzz_temp_logs_";
$db_logslist="temp_logslist";
$db_params_names="temp_paramlist";
$db_params_vals="temp_paramvalues";
$db_params_parser="temp_parsers";
$temp_db="zzz_catalog_out";
$cat_onpage=18;
$param_colors=array("#F00","#F80","#880","#008","#080","#808","#0F8");
if(isset($_REQUEST['onpage'])) $cat_onpage=$_REQUEST['onpage'];
include(ROOT."bitmask_funcs.php");
include(ROOT."parse_catalogs.php");
$hidden_stars="**";
$hidden_params=hide_params();
$root_bits=root_params();
function mysql_q($func,$string) {
    GLOBAL $debugparser;
    //echo $string;
    if($func=="") file_put_contents("/home/glosys/htdocs/new/sclap/debug.txt", "(other): ".$string."\n",FILE_APPEND);
    else
    if($debugparser[$func]==1) file_put_contents("/home/glosys/htdocs/new/sclap/debug.txt", $func.": ".$string."\n",FILE_APPEND);
    $ret=mysql_query($string); $err=mysql_error();
    if($err!="")  file_put_contents("/home/glosys/htdocs/new/sclap/debug.txt", "ERROR ".$err.": ".$string."\n",FILE_APPEND);
    return $ret;
}
?>