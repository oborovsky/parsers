<?
// $MASTER_DB=1;
// $t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0);//$DEBUG=100;
$time=$_SERVER['REQUEST_TIME']+15;
$comma_a=array(","," "); $comma_b=array(".","");

/*================================================================
 *-----------------------IMAGE_SERVER CONNECTION-----------------*
 ================================================================*/
$OUT_SERVER="46.36.220.49:3306";
$OUT_USER="qta";
$OUT_PASS="kazk0der";
$OUT_DB="cuty_images";

$out_connect=mysql_connect($OUT_SERVER,$OUT_USER,$OUT_PASS);
mysql_select_db($OUT_DB,$out_connect);
mysql_query("SET NAMES utf8",$out_connect);
/*================================================================
 *-----------------------IMAGE_SERVER CONNECTION-----------------*
 ================================================================*/

function updateURL($url,$art,$link)
{
    $lnk=mysql_real_escape_string($url,$link);
    mysql_query("INSERT IGNORE INTO `img_urls` (`url`,`hash`) VALUES ('".$lnk."','')",$link);  
    $qq=mysql_query("SELECT `id` FROM `img_urls` WHERE `url`='".$lnk."'",$link);
    if ($qq && mysql_num_rows($qq)>0)
        return "(".$art.",".array_pop(mysql_fetch_row($qq)).")";
    else echo mysql_error();
    return "";
}
 
function apply_rules($data,$rules) {
    /*rules:
     * 0 - категория параметра
     * 1 - параметр
     * 2 - строка поиска
     * 3 - regexp для разбора
     * 4 - строка замены (не пустой!)
     */
    $out=array();
    foreach($rules as $v)
        if(strpos($data,$v[2])!==FALSE) //В данных есть информация, к которой применимо правило
            if(preg_match_all("/".$v[3]."/sm",$data,$result,PREG_SET_ORDER)) { //применяем правило (вытаскиваем массив нужных данных)
                $tt=array();
                $len=count($result);
                if($len==1) {
                    foreach($result[0] as $i=>$k) $pat[$i]="{".$i."}";
                    $tt[0]=str_replace($pat,$result[0],$v[4]);
                }
                else if($len>0)
                    foreach($result as $j=>$val) {
                        foreach($val as $i=>$k) $pat[$i]="{".$i."}";
                        $tt[]=str_replace($pat,$val,$v[4]);
                    }

                if(isset($out[$v[0]][$v[1]])) {
                    if(is_array($out[$v[0]][$v[1]])) $out[$v[0]][$v[1]]=array_merge($out[$v[0]][$v[1]],$tt);
                    else $out[$v[0]][$v[1]]=array_merge(array($out[$v[0]][$v[1]]),$tt);
                }
                else $out[$v[0]][$v[1]]=(count($tt)>1)? $tt:$tt[0];
            }
    return $out;
}

$parsers=array(); $cats=array();
if(($handle=fopen(ROOT."system".DIRECTORY_SEPARATOR."parsers".DIRECTORY_SEPARATOR."state2".DIRECTORY_SEPARATOR."configure.rgx","r"))!==FALSE) {
    while($data=fgetcsv($handle,1000,","))
    if(count($data)===6) {
        $parsers[$data[0]][]=array($data[1],$data[2],$data[3],$data[4],$data[5]);
        $cats[]=$data[0];
    };
    fclose($handle); 
    if ($q=mysql_query("SELECT `id`,`mfg`,`art`,`cat`,`xml` FROM `tmp_goods` WHERE `mfg` in ('".implode("','",array_unique($cats))."') ORDER BY `mfg` LIMIT 200",$std_connect)) {
    //if ($q=mysql_query("SELECT `id`,`mfg`,`art`,`cat`,`xml` FROM `tmp_goods` WHERE `mfg` in ('J') AND xml LIKE '%images%produc%' ORDER BY `mfg` LIMIT 10")) {
    //if ($q=mysql_query("SELECT `id`,`mfg`,`art`,`cat`,`xml` FROM `tmp_goods` WHERE art='cuty3080'",$std_connect)) {
        $i=0;
        while(($t=mysql_fetch_row($q))&&(time()<$time)) {
            $t[2]=mysql_real_escape_string($t[2],$std_connect); $t[3]=mysql_real_escape_string($t[3],$std_connect);
            $info=apply_rules($t[4],$parsers[$t[1]]);
            //echo "<pre>".COINS."<br>";
            //print_r($info);
            
            if(isset($info["descr"])) $info["descr"]=mysql_real_escape_string($info["descr"][0],$std_connect);
            if(isset($info["params"])) $info["params"]=mysql_real_escape_string(serialize($info["params"]),$std_connect);

            // попытка нового апдейта таблички
            $tq=array();
            if((isset($info["prices"]))&&(is_array($info["prices"])))
                foreach($info["prices"] as $te=>$tr)
                    $tq[]="`price_".$te."`=".(int)((float)(str_replace($comma_a,$comma_b,(is_array($tr))?$tr[0]:$tr))*COINS).",`price_".$te."_`=NOW()";

            if((isset($info["amounts"]))&&(is_array($info["amounts"]))) foreach($info["amounts"] as $te=>$tr) $tq[]="`stock_".$te."`=".(int)(str_replace($comma_a,$comma_b,$tr)*GRAMS).",`stock_".$te."_`=NOW()";

            if (isset($info["params"]) && isset($info["params"]["new"]) && isset($info["params"]["new"])==1)
                $tq[]="isnew=1";
            else
                $tq[]="isnew=0";
            
            // апдейтим цены (или создаём новую связку артикул-поставщик)
            $new_art=str_replace(",","[comma]",$t[2]);
            $tmp_0=mysql_query("SELECT `id` FROM `goods_prices` WHERE `art`='".$new_art."' AND `mfg`='".$t[1]."' LIMIT 1",$std_connect);
            if(count($tq)>0)
                if(mysql_num_rows($tmp_0)) {
                    list($art_id)=mysql_fetch_row($tmp_0);
                    //echo "U :: art_id is ".$art_id."<br>";
                    // тут будет логирование в старую базу старых записей.
                    //echo "UPDATE `goods_prices` SET ".implode(",",$tq)." WHERE `id`=".$art_id."<br>";
                    mysql_query("UPDATE `goods_prices` SET ".implode(",",$tq)." WHERE `id`=".$art_id,$std_connect);
                }
                else {
                    //continue;
                    //echo "INSERT INTO `goods_prices` SET `art`='".$new_art."',`mfg`='".$t[1]."',".implode(",",$tq)."<br>";
                    mysql_query("INSERT INTO `goods_prices` SET `art`='".$new_art."',`mfg`='".$t[1]."',".implode(",",$tq),$std_connect);
                    //echo mysql_error();
                    $art_id=mysql_insert_id($std_connect);
                    //echo "I :: art_id is ".$art_id."<br>";
                }

            // Сливаем картинки в новую таблицу images
            if((isset($info["images"]))&&(is_array($info["images"]))) {
                unset($upds);
                $upds="";
                foreach($info["images"] as $val) {                    
                    if(is_array($val)) {
                        foreach($val as $v) {                            
                            if (strlen($upds)>0) $upds.=",";
                            $upds.=updateURL($v,$art_id,$std_connect);//$out_connect);// Здесь меняем на внтуренний коннект
                        }
                    }
                    else {
                        if (strlen($upds)>0) $upds.=",";
                        $upds.=updateURL($val,$art_id,$std_connect);//$out_connect);// Здесь меняем на внутренний коннект
                    }
                }
                
                mysql_query("INSERT IGNORE INTO `images` (`art_id`,`url_id`) VALUES ".$upds,$std_connect);
            }
            
            // теперь смотрим, повторялись ли параметры
            $tmp_0="";
            if (!isset($info["descr"])) {echo "No descr. for item: ".$art_id."\n";$info["descr"]="";}
            $info["descr"]=htmlspecialchars($info["descr"]);
            $info["images"]="";
            if (!isset($info["params"])) {echo "No params for item: ".$art_id."\n";$info["params"]="";}
            $u1=md5($art_id."d".$info["descr"]); $u1a="0x".$u1{0}.$u1{1}.$u1{2}.$u1{3}.$u1{4}.$u1{5}.$u1{6}.$u1{7}.$u1{8}.$u1{9}.$u1{10}.$u1{11}.$u1{12}.$u1{13}.$u1{14}.$u1{15}; $u1b="0x".$u1{16}.$u1{17}.$u1{18}.$u1{19}.$u1{20}.$u1{21}.$u1{22}.$u1{23}.$u1{24}.$u1{25}.$u1{26}.$u1{27}.$u1{28}.$u1{29}.$u1{30}.$u1{31};
            $u3=md5($art_id."p".$info["params"]); $u3a="0x".$u3{0}.$u3{1}.$u3{2}.$u3{3}.$u3{4}.$u3{5}.$u3{6}.$u3{7}.$u3{8}.$u3{9}.$u3{10}.$u3{11}.$u3{12}.$u3{13}.$u3{14}.$u3{15}; $u3b="0x".$u3{16}.$u3{17}.$u3{18}.$u3{19}.$u3{20}.$u3{21}.$u3{22}.$u3{23}.$u3{24}.$u3{25}.$u3{26}.$u3{27}.$u3{28}.$u3{29}.$u3{30}.$u3{31};
            $u4=md5($art_id."c".$t[3]); $u4a="0x".$u4{0}.$u4{1}.$u4{2}.$u4{3}.$u4{4}.$u4{5}.$u4{6}.$u4{7}.$u4{8}.$u4{9}.$u4{10}.$u4{11}.$u4{12}.$u4{13}.$u4{14}.$u4{15}; $u4b="0x".$u4{16}.$u4{17}.$u4{18}.$u4{19}.$u4{20}.$u4{21}.$u4{22}.$u4{23}.$u4{24}.$u4{25}.$u4{26}.$u4{27}.$u4{28}.$u4{29}.$u4{30}.$u4{31};
            $u=mysql_fetch_row(mysql_query("SELECT `A`.`t`,1 as tmp,`C`.`t`,`D`.`t` FROM
(SELECT COUNT(*) AS `t` FROM `hashes` WHERE `part1`=".$u1a." AND `part2`=".$u1b.") as `A`,
(SELECT COUNT(*) AS `t` FROM `hashes` WHERE `part1`=".$u3a." AND `part2`=".$u3b.") as `C`,
(SELECT COUNT(*) AS `t` FROM `hashes` WHERE `part1`=".$u4a." AND `part2`=".$u4b.") as `D`
",$std_connect));
            $uu=array();
            if($u[0]==0) { $tmp_0.=",`descr`='".$info["descr"]."'"; $uu[]="(".$u1a.",".$u1b.")"; }
            //if($u[1]==0) { $tmp_0.=",`images`='".$info["images"]."'"; $uu[]="(".$u2a.",".$u2b.")"; }
            if($u[2]==0) { $tmp_0.=",`params`='".$info["params"]."'"; $uu[]="(".$u3a.",".$u3b.")"; }
            if($u[3]==0) { $tmp_0.=",`cats`='".$t[3]."'"; $uu[]="(".$u4a.",".$u4b.")"; }
            
            //echo "INSERT INTO `goods_props` SET `art_id`=".$art_id.",`mfg`='".$t[1]."'".$tmp_0."<br>";
            //echo "HASH: ".$u1a."-:-".$u1b." <br><br>";
            
            if(count($uu)>0) {
                mysql_query("INSERT INTO `goods_props` SET `art_id`=".$art_id.",`mfg`='".$t[1]."'".$tmp_0,$std_connect);
                echo "<br>== ".mysql_error()." ==<br>";
                mysql_query("INSERT INTO `hashes`(`part1`,`part2`) VALUES ".implode(",",$uu),$std_connect);
                mysql_query("INSERT INTO `goods_props_current` SET `art_id`=".$art_id.",`mfg`='".$t[1]."',`descr`='".$info["descr"]."',`images`='".$info["images"]."',`params`='".$info["params"]."',`cats`='".$t[3]."' ON DUPLICATE KEY UPDATE `mfg`='".$t[1]."',`descr`='".$info["descr"]."',`images`='".$info["images"]."',`params`='".$info["params"]."',`cats`='".$t[3]."'",$std_connect);
            }
        if (!mysql_query("DELETE FROM `tmp_goods` WHERE `id`=".$t[0],$std_connect)) echo mysql_error($std_connect);
        $i++;
        }
    echo "Rows affected: ".$i."\n";
    }
}
?>