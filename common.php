<?
set_time_limit(3600);
//ini_set("display_errors",1);
mb_internal_encoding("UTF-8");
mb_regex_encoding('UTF-8');
//error_reporting(E_ALL);

@session_start();
$ptime=microtime(TRUE);

define("DB_SERVER","localhost");
define("DB_USER","root");
define("DB_PASSWD","kazk0der");
define("DB_BASE","cuty_cat");
define("COINS",100);
define("GRAMS",1000);
define("ROOT",realpath(dirname(__FILE__)).DIRECTORY_SEPARATOR); 
mysql_connect(DB_SERVER,DB_USER,DB_PASSWD) or die("can't connect".mysql_error());
mysql_query("SET NAMES utf8");
mysql_select_db(DB_BASE) or die("wrong DB");
define("ICONSERVER","$");
// functions
function q_($in,$out=0) {
    $t=mysql_query($in);
    if($out==0) return($t);
    if($out==-1) return(mysql_num_rows($t));
    if($out==-2) return(mysql_affected_rows());
    if(mysql_num_rows($t)==0) return(FALSE);
    $p=mysql_fetch_row($t);
    if($out==1) return($p[0]);
    return($p); }

function suicide() {
    if(func_num_args()<1) die("Oops");
    if(func_num_args()>1) foreach(func_get_args() as $i=>$fu)
    if($i>0) q_("DROP TABLE IF EXISTS `".$fu."`");
    die(func_get_arg(0)); }

function stem_vovels(&$s,$re,$to) {
    $orig=$s;
    $s=mb_ereg_replace($re,$to,$s);
    return $orig!==$s; }

function stem_word($word) {
    $word=mb_convert_case($word,MB_CASE_LOWER,"UTF-8");
    $articles=array("без","безо","будто","бы","был","была","было","вглубь","вдоль","взамен","вместо","вне","внизу","внутрь","во","возле","вокруг","вообще","впереди","вроде","все","всего","где","да","даже","для","до","едва","если","еще","же","за","изнутри","или","как","какой","ко","который","кроме","кто","куда","ли","между","мимо","много","на","наверху","над","надо","наподобие","не","недалеко","нет","ниже","но","об","обо","общем","он","она","они","оно","от","откуда","перед","передо","по","поверх","под","подо","позади","поперек","посередине","после","посреди","посредине","при","ровно","рядом","само","сверху","сзади","сквозь","словно","снизу","со","собой","так","типа","то","тоже","только","через","что","чтоб","чтобы","чуть");
    if(in_array($word,$articles)) return("");
    stem_vovels($word,'ё','е');
    $stem = $word;
    do {
        if(!mb_eregi('^(.*?[аеиоуыэюя])(.+)$',$word,$p)) break;
        $RV=$p[2];
        if (!stem_vovels($RV,'((ив|ивши|ившись|ыв|ывши|ывшись)|((?<=[ая])(в|вши|вшись)))$','')) {
            stem_vovels($RV,'(с[яь])$', '');
            if (stem_vovels($RV,'(ее|ие|ые|ое|ими|ыми|ей|ий|ый|ой|ем|им|ым|ом|его|ого|ему|ому|их|ых|ую|юю|ая|яя|ою|ею)$','')) stem_vovels($RV,'((ивш|ывш|ующ)|((?<=[ая])(ем|нн|вш|ющ|щ)))$','');
            else if (!stem_vovels($RV,'((ила|ыла|ена|ейте|уйте|ите|или|ыли|ей|уй|ил|ыл|им|ым|ен|ило|ыло|ено|ят|ует|уют|ит|ыт|ены|ить|ыть|ишь|ую|ю)|((?<=[ая])(ла|на|ете|йте|ли|й|л|ем|н|ло|но|ет|ют|ны|ть|ешь|нно)))$','')) stem_vovels($RV,'(а|ев|ов|ие|ье|е|иями|ями|ами|еи|ии|и|ией|ей|ой|ий|й|иям|ям|ием|ем|ам|ом|о|у|ах|иях|ях|ы|ь|ию|ью|ю|ия|ья|я)$','');
        }
        $RV=rtrim($RV,'и');
        if(mb_ereg('[^аеиоуыэюя][аеиоуыэюя]+[^аеиоуыэюя]+[аеиоуыэюя].*(?<=о)сть?$',$RV))
        stem_vovels($RV,'ость?$','');
        if(!stem_vovels($RV,'ь$','')) {
            stem_vovels($RV,'ейше?','');
            stem_vovels($RV,'нн$','н');
        }
        stem_vovels($RV,'(еньк?$|оньк?$|ечек?$|очек?$|ачек?$|ичек?$|ечк?$|очк?$|ачк?$|ичк?$|иньк?$|ик$|ок$|ек$|)','');
        $stem=$p[1].$RV;
    } while(false);
    return($stem); }

function jO($out) {
    echo json_encode($out);
    die; }

function bitmask2array($in,$offset=0) { // делает из HEX массив (in=строка, offset=база, rev=перевернуть строку)
    $out=array();
    $in=strtoupper(strrev($in));
    $t=strlen($in);
    for($i=0;$i<$t;$i++) {
        $t0=$offset+(4*$i); $t1=$t0+1;$t2=$t0+2;$t3=$t0+3;
        switch($in{$i}) {
           case "0": break;
           case "F": $out[$t2]=$t2;
           case "B": $out[$t3]=$t3;
           case "3": $out[$t1]=$t1;
           case "1": $out[$t0]=$t0; break;
           case "E": $out[$t3]=$t3;
           case "6": $out[$t2]=$t2;
           case "2": $out[$t1]=$t1; break;
           case "7": $out[$t1]=$t1;
           case "5": $out[$t0]=$t0;
           case "4": $out[$t2]=$t2; break;
           case "D": $out[$t2]=$t2;
           case "9": $out[$t0]=$t0;
           case "8": $out[$t3]=$t3; break;
           case "C": $out[$t2]=$t2;$out[$t3]=$t3; break;
           case "A": $out[$t1]=$t1;$out[$t3]=$t3; break;
        }
    }
    return $out;
}

function bit2string($bit,$pref='bit',$offset=0) {
    $a=(int)($offset+($bit>>6));
    $b=$bit%64;
    return("`".$pref.$a."` & POW(2,".$b.")");
}

function array_merge_recursive2() {
    $arrays=func_get_args();
    $base=array_shift($arrays);
    foreach($arrays as $array) {
        reset($base); //important
        while(list($key, $value)=@each($array))
            if (is_array($value)&&(@is_array($base[$key]))) $base[$key]=array_merge_recursive2($base[$key], $value);
            else $base[$key]=$value;
    }
    return $base;
}

function get_all_tree_stats_old($tree_t) {
    $q=mysql_query("SELECT `id`,`parent`,`value`,HEX(`settings`) FROM ".$tree_t."WHERE (`settings` & 1 AND NOT `settings` & POW(2,50) AND NOT `settings` & 8) ORDER BY `order`");
    while($x=mysql_fetch_row($q)) {
        $arr[$x[0]]['parent']=$x[1];
        $arr[$x[0]]['name']=$x[2];
        $arr[$x[0]]['bits']=bitmask2array($x[3]);
        $arr[$x[1]]['childs'][]=$x[0];
    }
    return $arr;
}

function get_tree_branch_old($ttree,$id,$troot=array(4,13,33,47),$conf=array(36=>"bold")) {
    $out=array();
    if(!is_array($troot)) $troot=explode(",",$troot);
    if(!is_array($conf)) {
        $tmp=explode(",",$conf);
        $conf=array();
        foreach($tmp as $tmp1) {
            $tmp2=explode(":",$tmp1);
            $conf[$tmp2[0]]=$tmp2[1];
        }
    }
    if((isset($ttree[$id]))&&(isset($ttree[$id]['parent']))) {
        $out[$id]['name']=$ttree[$id]['name'];
        foreach($conf as $t2=>$t3) if(isset($ttree[$id]['bits'][$t2])) $out[$id][$t3]=1;
        foreach($troot as $t1) if(isset($ttree[$id]['bits'][$t1])) $id=0;
        while($id!=0)
        {
            if(!isset($ttree[$id]['parent'])) break;
            $out2=$out;
            $id=$ttree[$id]['parent'];
            $out=array($id=>array('children'=>$out2));
            if(isset($ttree[$id]['name'])) $out[$id]['name']=$ttree[$id]['name'];
            foreach($conf as $t2=>$t3) if(isset($ttree[$id]['bits'][$t2])) $out[$id][$t3]=1;
            foreach($troot as $t1) if(isset($ttree[$id]['bits'][$t1])) $id=0;
        }
    }
    return($out);
}

function get_tree_leafs($tree_t,$tneeded=array(3),$conf=array(36=>"bold")) {
    if(!is_array($tneeded)) $tneeded=explode(",",$tneeded);
    if(!is_array($conf)) {
        $tmp=explode(",",$conf);
        $conf=array();
        foreach($tmp as $tmp1) {
            $tmp2=explode(":",$tmp1);
            $conf[$tmp2[0]]=$tmp2[1];
        }
    }
    $out="SELECT `id`,`parent`,`value`,HEX(`settings`) FROM ".$tree_t."WHERE (`settings` & 1 ";
    foreach($tneeded as $b) $out=$out." AND ( `settings` & POW(2,".$b.") ) ";
    $q=mysql_query($out.")"); // ORDER BY `order`
    while($x=mysql_fetch_row($q)) {
        $arr[$x[0]]['parent']=$x[1];
        $arr[$x[0]]['name']=$x[2];
        $tbits=bitmask2array($x[3]);
//        print_r($tbits);
        foreach($conf as $t10=>$t11) if(isset($tbits[$t10])) $arr[$x[0]]['bits'][$t10]=$t11;
        //$arr[$x[1]]['childs'][]=$x[0];
    }
    return $arr;    
}

function parsebits($bit_array,$id,$tree) { //,$conf=array(32=>"show",41=>"showsel",44=>"bin")) {
    $out=array();
    foreach($bit_array as $bit) $t[]=bit2string($bit)." AS `bit".$bit."`";
//echo "SELECT ".implode(",",$t)." FROM ".$tree." WHERE `id`=".$id;
    $pp=q_("SELECT ".implode(",",$t)." FROM ".$tree." WHERE `id`=".$id,2);
//    print_r($pp);
//    foreach($conf as $con1=>$con2)
    foreach($bit_array as $bit1=>$bit2) if((isset($pp[$bit1]))&&($pp[$bit1]!=0)) $out[$bit2]=1;
    return($out);
}

function item($item,$bits=array(),$key=0,$imgserver="$") {
//    echo $item[0]."->navernoe v konCe...   ";
    $t=explode(",",$item[4]);
    $p=unserialize($item[3]);
    $amount=(int)($item[6]/GRAMS);
    $price=$item[5]/COINS;
    $outt=array("id"=>$item[0],"art"=>$item[1],"name"=>$item[2],"price_view"=>$item[7],"visual"=>$key);
    $outt["bits"]=$bits;
    if($amount==0) $outt['outofstock']=1;
    else if($amount<0) $outt['anyamount']=1;
    else $outt['amount']=$amount;
    if($price==0) $outt['noprice']=1;
    else if($price<0) $outt['ondemand']=1;
    else $outt['price']=$price;
    if(isset($p['descr'])) $outt["descr"]=$p['descr'];
    $outt["addtobasket"]="0";        
    if(isset($_SESSION['basket'])) {
        $outt["addtobasket"]="1";
        if(q_("SELECT * FROM `basket` WHERE `art`='".$item[0]."' AND `user`='".mysql_real_escape_string($_SESSION['basket'])."'",-1)) $outt["inbasket"]="1";
    }    
    foreach($t as $t1) $outt["img"][]=str_replace("$",$t1,$imgserver);
    return($outt);
}

function get_all_tree_stats($tree_t) {
    $q=mysql_query("SELECT `id`,`parent`,`value`,HEX(`settings`),`order` FROM ".$tree_t."WHERE (`settings` & 1 AND NOT `settings` & POW(2,50) AND NOT `settings` & 8) ORDER BY `order`");
    while($x=mysql_fetch_row($q)) {
        $arr[$x[0]]['parent']=$x[1];
        $arr[$x[0]]['name']=$x[2];
        $arr[$x[0]]['bits']=bitmask2array($x[3]);
        $arr[$x[1]]['childs'][]=$x[0];
        $arr[$x[0]]['order']=$x[4];
    }
    return $arr;
}

function get_tree_branch($ttree,$id,$troot=array(4,13,33,47),$conf=array(36=>"bold")) {
    $out=array();
    if(!is_array($troot)) $troot=explode(",",$troot);
    if(!is_array($conf)) {
        $tmp=explode(",",$conf);
        $conf=array();
        foreach($tmp as $tmp1) {
            $tmp2=explode(":",$tmp1);
            $conf[$tmp2[0]]=$tmp2[1];
        }
    }
    $out[$id]['name']=$ttree[$id]['name'];
    $out[$id]['order']=$ttree[$id]['order'];
    $out[$id]['parent']=$ttree[$id]['parent'];
    $out[$id]['id']=$id;
    foreach($conf as $t2=>$t3) if(isset($ttree[$id]['bits'][$t2])) $out[$id][$t3]=1;
    foreach($troot as $t1) if(isset($ttree[$id]['bits'][$t1])) $id=0;
    if (array_key_exists($id,$ttree))
    while($id!=0) {
        $out2=$out;
        $id=$ttree[$id]['parent'];
        $out=array($id=>array('children'=>$out2));
        $out[$id]['name']=$ttree[$id]['name'];
        $out[$id]['order']=$ttree[$id]['order'];
        $out[$id]['parent']=$ttree[$id]['parent'];
        $out[$id]['id']=$id;
        foreach($conf as $t2=>$t3) if(isset($ttree[$id]['bits'][$t2])) $out[$id][$t3]=1;
        foreach($troot as $t1) if(isset($ttree[$id]['bits'][$t1])) $id=0;
    }
    return($out);
}

function tree_amounts($tree) { // outputs array of amounts assigned to tree IDs
    $x=array();
    $a=mysql_query("SELECT `id`,`count` FROM ".$tree." WHERE `count`>0");
    if(mysql_num_rows($a)) while($b=mysql_fetch_row($a)) $x[$b[0]]=$b[1];
    return $x;
}

function order_order($in,&$amounts) { // insert amounts into tree and sorts
    $x=array();
    foreach($in as $a=>$b) {
        $t=$b['order'];
        foreach($b as $c=>$d) if(($c!="children")&&($c!="order")) $x[$t][$c]=$d;
        if((isset($amounts[$b['id']]))&&($amounts[$b['id']]>0)) $x[$t]['amounts']=$amounts[$b['id']];
        if((isset($b['children']))&&(count($b['children'])>0)) $x[$t]['children']=order_order($b['children'],$amounts);
    }
    ksort($x);
    return(array_values($x));
}

// end functions
  

?>