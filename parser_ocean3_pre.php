<? $MASTER_DB=1;
$t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0); //$DEBUG=1;
function mysql_($in) {echo $in;}

if(!$sqf=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."ocean".DIRECTORY_SEPARATOR."galery_files.xml")) die("oops");
if(!$sql=simplexml_load_file(ROOT."in".DIRECTORY_SEPARATOR."ocean".DIRECTORY_SEPARATOR."galery_wares.xml")) die("oops");

$imgfiles=array();$out_array=array();
foreach($sqf->item as $item) {
    $p=$item->attributes();
    $imgfiles[(string)$p['id']]=(string)$item->asXML();
}

function r($in_string,$in_xml) {
    GLOBAL $imgfiles,$out_array,$KEY_OCEAN;
    if($in_string!="") $in_string=$in_string.DIRECTORY_SEPARATOR;
    $in_string=$in_string.(string)$in_xml->name;
    foreach($in_xml->item as $item) {
        $id=(string)$item->id;
        if(isset($imgfiles[$id])) $out_array[]="('".$KEY_OCEAN."','".mysql_real_escape_string($id)."','".$in_string."','".mysql_real_escape_string($item->asXML()).$imgfiles[$id]."')";
        else $out_array[]="('".$KEY_OCEAN."','".mysql_real_escape_string($id)."','".$in_string."','".mysql_real_escape_string($item->asXML())."')";
    }
    foreach($in_xml->group as $oq) r($in_string,$oq);
    foreach($in_xml->subgroup as $oq) r($in_string,$oq);
}

r("",$sql);
$d=count($out_array);
if($d) mysql_q("INSERT INTO `tmp_goods`(`mfg`,`art`,`cat`,`xml`) VALUES ".implode(",",$out_array));
echo "done:".$d;
?>