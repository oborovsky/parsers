<?
// $MASTER_DB=1;
// $t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0);//$DEBUG=100;
$time=$_SERVER['REQUEST_TIME']+15;
$comma_a=array(","," "); $comma_b=array(".","");
define("COINS",100);
define("GRAMS",1000);

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
$LOCAL_SERVER="localhost";
$LOCAL_USER="root";
$LOCAL_PASS="k0les0";
$LOCAL_DB="test";

$std_connect=mysql_connect($LOCAL_SERVER,$LOCAL_USER,$LOCAL_PASS);
mysql_select_db($LOCAL_DB,$std_connect);
mysql_query("SET NAMES utf8",$std_connect);
echo "connected to local base\n";
//==========================================

function updateURL($url,$art,$link)
{
    $lnk=mysql_real_escape_string($url,$link);
    // echo "INSERT IGNORE INTO `img_urls` (`url`,`hash`) VALUES ('".$lnk."','')\n";
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
if(($handle=fopen("configure.rgx","r"))!==FALSE) {
    while($data=fgetcsv($handle,1000,","))
    if(count($data)===6) {
        $parsers[$data[0]][]=array($data[1],$data[2],$data[3],$data[4],$data[5]);
        $cats[]=$data[0];
    };
    fclose($handle); 

    echo "read done from cofigure.rgx\n";

    if ($q=mysql_query("SELECT `id`,`mfg`,`art`,`cat`,`xml` FROM `tmp_goods` WHERE `mfg` in ('".implode("','",array_unique($cats))."') ORDER BY `mfg` LIMIT 200",$std_connect)) {
    //if ($q=mysql_query("SELECT `id`,`mfg`,`art`,`cat`,`xml` FROM `tmp_goods` WHERE `mfg` in ('J') AND xml LIKE '%images%produc%' ORDER BY `mfg` LIMIT 10")) {
    //if ($q=mysql_query("SELECT `id`,`mfg`,`art`,`cat`,`xml` FROM `tmp_goods` WHERE art='cuty3080'",$std_connect)) {
        
        echo "start parse tmp_goods\n";

        $i=0;
        while(($t=mysql_fetch_row($q))&&(time()<$time)) {
            $t[2]=mysql_real_escape_string($t[2],$std_connect); $t[3]=mysql_real_escape_string($t[3],$std_connect);

            // print_r($t);
            // print_r($parsers[$t[1]]);

            $info=apply_rules($t[4],$parsers[$t[1]]);

            // print_r($info);
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
                if(mysql_num_rows($tmp_0))
                {
                    list($art_id)=mysql_fetch_row($tmp_0);
                    //echo "U :: art_id is ".$art_id."<br>";
                    // тут будет логирование в старую базу старых записей.
                    // echo "UPDATE `goods_prices` SET ".implode(",",$tq)." WHERE `id`=".$art_id."\n";
                    mysql_query("UPDATE `goods_prices` SET ".implode(",",$tq)." WHERE `id`=".$art_id,$std_connect);
                }
                else 
                {
                    //continue;
                    // echo "INSERT INTO `goods_prices` SET `art`='".$new_art."',`mfg`='".$t[1]."',".implode(",",$tq)."\n";
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
                // echo "INSERT IGNORE INTO `images` (`art_id`,`url_id`) VALUES ".$upds."\n";
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
            	// echo "INSERT INTO `goods_props` SET `art_id`=".$art_id.",`mfg`='".$t[1]."'".$tmp_0."\n";
                mysql_query("INSERT INTO `goods_props` SET `art_id`=".$art_id.",`mfg`='".$t[1]."'".$tmp_0,$std_connect);
                // echo "<br>== ".mysql_error()." ==<br>\n";
                // echo "INSERT INTO `hashes`(`part1`,`part2`) VALUES ".implode(",",$uu)."\n";
                mysql_query("INSERT INTO `hashes`(`part1`,`part2`) VALUES ".implode(",",$uu),$std_connect);
                // echo "INSERT INTO `goods_props_current` SET `art_id`=".$art_id.",`mfg`='".$t[1]."',`descr`='".$info["descr"]."',`images`='".$info["images"]."',`params`='".$info["params"]."',`cats`='".$t[3]."' ON DUPLICATE KEY UPDATE `mfg`='".$t[1]."',`descr`='".$info["descr"]."',`images`='".$info["images"]."',`params`='".$info["params"]."',`cats`='".$t[3]."'\n";
                mysql_query("INSERT INTO `goods_props_current` SET `art_id`=".$art_id.",`mfg`='".$t[1]."',`descr`='".$info["descr"]."',`images`='".$info["images"]."',`params`='".$info["params"]."',`cats`='".$t[3]."' ON DUPLICATE KEY UPDATE `mfg`='".$t[1]."',`descr`='".$info["descr"]."',`images`='".$info["images"]."',`params`='".$info["params"]."',`cats`='".$t[3]."'",$std_connect);
            }
        if (!mysql_query("DELETE FROM `tmp_goods` WHERE `id`=".$t[0],$std_connect)) echo mysql_error($std_connect);
        $i++;
        }
    echo "Rows affected: ".$i."\n";
    }
}
//from comp
/*
Array ( 
[vars] => Array ( 
    [TXT_NO_LEGAL] => без юр.лица 
    [KEY_EBAZAAR] => E
    [KEY_OASIS] => O 
    [PRICES_E] => Array ( [price_ebazaar] => розничная цена ebazaar ) 
    [STOCKS_E] => Array ( [stock_ebazaar1] => ebazaar (на складе) [stock_ebazaar2] => ebazaar (доступно) ) 
    [STOCKS_O] => Array ( [stock_oasis_sklad] => оазис (на складе) [stock_oasis_rez] => оазис (резерв) ) 
    [PRICES_O] => Array ( [price_oasis] => розничная цена oasis ) 
    [PRICES_C] => Array ( [price_ocean] => розничная цена ocean ) 
    [STOCKS_C] => Array ( [stock_ocean_total] => оазис (на складе всего) [stock_ocean_ns] => оазис (на складе Новосибирск) [stock_ocean_msk] => оазис (на складе Москва) [stock_ocean_rst] => оазис (на складе Ростов) ) 
    [PRICES_H] => Array ( [price_happy] => розничная цена happy ) 
    [STOCKS_H] => Array ( [stock_happy_sklad] => хэппи (на складе) [stock_happy_rez] => хэппи (резерв) ) 
    [PRICES_P] => Array ( [price_project111] => розничная цена Проект 111 ) 
    [STOCKS_P] => Array ( [stock_project111_total] => Проект 111 (на складе) [stock_project111_free] => Проект 111 (доступно) ) 
    [PRICES_M] => Array ( [price_midocean] => розничная цена Mid Ocean Brands ) 
    [STOCKS_M] => Array ( [stock_midocean] => Mid Ocean Brands (на складе) ) 
    [PRICES_Q] => Array ( [price_cuty_sup] => цена поставщика для Кьюти [price_cuty_in] => входная цена для Кьюти [price_cuty_opt] => оптовая цена Кьюти [price_cuty_ret] => розничная цена Кьюти ) 
    [STOCKS_Q] => Array ( [stock_cuty] => Кьюти (на складе) ) 
    [KEY_OCEAN] => C 
    [KEY_HAPPY] => H 
    [KEY_PR111] => P 
    [KEY_MID] => M 
    [KEY_CUTY] => Q 
    [KEY_EJE] => J 
    [STOCKS_J] => Array ( [stock_eje_stock] => еже (в запасе) [stock_eje_warehouse] => еже (на складе) [stock_eje_delivery] => еже (в пути) ) 
    [PRICES_J] => Array ( [price_eje_initial] => начальная цена [price_eje_final] => конечная цена ) 
    [KEY_XIN] => X 
    [STOCKS_X] => Array ( [stock_xindao_eur] => xindao (в Европе) [stock_xindao_moscow] => xindao (в Москве) [stock_xindao_moscow_avail] => xindao (в Москве доступно) ) 
    [PRICES_X] => Array ( [price_xindao] => начальная цена ) 
    [KEY_ROSTIME] => R 
    [PRICES_R] => Array ( [price_midocean] => розничная цена Mid Ocean Brands ) 
    [STOCKS_R] => Array ( [stock_midocean] => Mid Ocean Brands (на складе) ) 
    [KEY_EKLEKTIKA] => K 
    [STOCKS_K] => Array ( [stock_eklektika_sklad] => Эклектика (на складе) [stock_eklektika_rez] => Эклектика (резерв) ) 
    [PRICES_K] => Array ( [price_eklektika_main] => основная цена [price_eklektika_adv] => рекламная цена ) 
    [KEY_STAN] => S 
    [PRICES_S] => Array ( [price_stan_main] => Цена в базе STAN ) 
    [STOCKS_S] => Array ( [stock_stan_sklad] => STAN (на складе) [stock_stan_moscow] => STAN (Москва) [stock_stan_discount] => STAN (скидка) ) 
    [KEY_RAINBOW] => W 
    [MANUFACTURERS] => Array ( [E] => Ebazaar 
                       [O] => OASIS 
                       [C] => OCEAN 
                       [H] => HAPPY gifts 
                       [P] => Project 111 
                       [M] => Mid Ocean Brands 
                       [Q] => Локальный склад 
                       [J] => ЕЖЕ 
                       [X] => XINDAO 
                       [R] => РосТайм 
                       [K] => Эклектика 
                       [S] => STAN 
                       [W] => Rainbow ) 
    [PRICES_W] => 
    [STOCKS_W] => 
    [MEASURES] => Array ( [1] => Array ( [name] => шт [delim] => 1 ) 
                          [2] => Array ( [name] => л [delim] => 1000 ) 
                          [3] => Array ( [name] => кг [delim] => 1000 ) 
                          [4] => Array ( [name] => м [delim] => 1000 ) ) 
    [ITEMFLAGS] => Array ( [1] => едет на сайт 
                           [2] => собственное произв-во 
                           [3] => всегда в наличии 
                           [4] => не резервируется 
                           [5] => цена у менеджера ) 
    [CLI_JUR_HDR] => Array ( [0] => Название 
                             [1] => ИНН 
                             [2] => синонимы 
                             [3] => дата заведения ) 
    [CLI_HDR] => Array ( [0] => Название [1] => синонимы [2] => дата заведения [3] => ответственный ) 
    [DIMENSIONS_ICON] => Array ( [0] => 90 [1] => 90 ) 
    [DIMENSIONS_PICT] => Array ( [0] => 250 [1] => 250 ) 
    [STAFF_HDR] => Array ( [0] => логин [1] => ФИО [2] => дата заведения ) 
    [ITEMFIELDS] => Array ( [mfg] => Поставщик 
                            [art] => Артикул 
                            [cats] => Категории 
                            [descr] => Описание 
                            [params] => Характеристики 
                            [images] => Картинки 
                            [prices] => Цены 
                            [amounts] => Количества ) 
    [ITEMPARAMS] => Array ( [brand] => Бренд 
                            [collection] => Коллекция 
                            [descr] => Подробное описание 
                            [manufact] => Производитель 
                            [color] => Цвет 
                            [size] => Размер 
                            [boxtype] => Вид упаковки 
                            [weight] => Вес 
                            [countperbox] => Количество в упаковке 
                            [sizebox] => Размер упаковки 
                            [print] => Нанесение 
                            [catpage] => Страница каталога 
                            [discount] => Страница скидки 
                            [material] => Материал 
                            [sizes] => Размер текстиля 
                            [measure] => Единица измерения 
                            [descr_full] => Полное описание 
                            [volumebox] => Объём коробки 
                            [weightbox] => Вес коробки 
                            [volume] => Объём 
                            [new] => Новинка 
                            [offers] => Акции 
                            [comment] => Комментарий 
                            [weights] => Вес текстиля 
                            [gender] => Половая принадлежность 
                            [papertype] => Тип бумаги 
                            [series] => Серия 
                            [viewtype] => Вид материала 
                            [blindingtype] => Тип переплёта 
                            [makeuptype] => Тип блока 
                            [section] => Тип среза 
                            [poducttype] => Тип изделия 
                            [topicalitytype] => Спецпредложение ) 
    [BITSCOUNT_0] => 4 
    [PRICEMULT_E] => price_ebazaar:1.00 
    [AMOUNTSUM_E] => `stock_ebazaar2` 
    [PRICEMULT_O] => price_oasis:1.00 
    [AMOUNTSUM_O] => `stock_oasis_sklad` 
    [FTPOUT] => "ftp://qtw:ced42Sddse@46.36.220.49/www/cat_new/in/" 
    [PRICEMULT_C] => price_ocean:1.00 
    [AMOUNTSUM_C] => `stock_ocean_total` 
    [PRICEMULT_H] => price_happy:1.00 
    [AMOUNTSUM_H] => `stock_happy_sklad`+`stock_happy_rez` 
    [PRICEMULT_P] => price_project111:1.00 
    [AMOUNTSUM_P] => `stock_project111_free` 
    [PRICEMULT_M] => price_midocean:1.00 
    [AMOUNTSUM_M] => `stock_midocean` 
    [PRICEMULT_Q] => price_cuty_opt:1.00 
    [AMOUNTSUM_Q] => `stock_cuty` 
    [PRICEMULT_J] => price_eje_final:EUR 
    [AMOUNTSUM_J] => `stock_eje_stock` 
    [PRICEVIEW_E] => CONCAT(CAST(TRUNCATE(`price_ebazaar`/100,2) AS CHAR),' р.') 
    [PRICEVIEW_O] => CONCAT(CAST(TRUNCATE(`price_oasis`/100,2) AS CHAR),' р.') 
    [PRICEVIEW_C] => CONCAT(CAST(TRUNCATE(`price_ocean`/100,2) AS CHAR),' р.') 
    [PRICEVIEW_H] => CONCAT(CAST(TRUNCATE(`price_happy`/100,2) AS CHAR),' р.') 
    [PRICEVIEW_P] => CONCAT(CAST(TRUNCATE(`price_project111`/100,2) AS CHAR),' р.') 
    [PRICEVIEW_M] => CONCAT(CAST(TRUNCATE(`price_midocean`/100,2) AS CHAR),' р.') 
    [PRICEVIEW_Q] => CONCAT(CAST(TRUNCATE(`price_cuty_opt`/100,2) AS CHAR),' р.') 
    [PRICEVIEW_J] => CONCAT(CAST(TRUNCATE(`price_eje_final`/100,2) AS CHAR),' €') 
    [ITEMPARAMSTYPES] => Array ( [main] => brand,descr,color,size,weight,print,material 
                                 [hidden] => descr_full,new,offers,topicalitype,gender,comment ) 
    [DAYLIMIT] => 14 
    [PRICEMULT_X] => price_xindao:1.00 
    [AMOUNTSUM_X] => `stock_xindao_eur` 
    [PRICEVIEW_X] => CONCAT(CAST(TRUNCATE(`price_xindao`/100,2) AS CHAR),' р.') 
    [PRICEMULT_K] => price_eklektika_main:1.00 
    [AMOUNTSUM_K] => `stock_eklektika_sklad` 
    [PRICEVIEW_K] => CONCAT(CAST(TRUNCATE(`price_eklektika_main`/100,2) AS CHAR),' р.') 
    [PRICEMULT_S] => price_stan_main:1.00 
    [AMOUNTSUM_S] => IFNULL(`stock_stan_sklad`,0) + IFNULL(`stock_stan_moscow`,0) + IFNULL(`stock_stan_discount`,0) 
    [PRICEVIEW_S] => CONCAT(CAST(TRUNCATE(`price_stan_main`/100,2) AS CHAR),' р.') 
    [PRICEMULT_W] => price_rainbow:1.00 
    [AMOUNTSUM_W] => `stock_rainbow` 
    [PRICEVIEW_W] => CONCAT(CAST(TRUNCATE(`price_rainbow`/100,2) AS CHAR),' р.') 
    [SUBSCRIBES] => E,O,C,H,P,M,Q,J,X,R,K,S,W ) 
[_username] => test 
[_userid] => 31 
[_version] => 0 ) 
*/
?>