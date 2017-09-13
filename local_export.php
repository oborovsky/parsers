<?
include("new".DIRECTORY_SEPARATOR."sclap".DIRECTORY_SEPARATOR."common.php");
$a=mysql_query("SELECT `id`,`title`,`intro`,`body`,`pict`,`date`,`rate`,`counter`,`gallery`,`params` FROM `glosys`.`catalogue`"); // WHERE `params` NOT LIKE '%storepos,,0%'");
echo "INSERT INTO `tmp_goods`(`mfg`,`art`,`xml`,`cat`) VALUES ";
$x=array();
while($b=mysql_fetch_row($a)) {
    $p=0;
    preg_match("/codeCUTY,,(.+?),,/",$b[9],$ar);
    $bpp="";
    if(preg_match_all("/\](.+?)~/",$b[8],$bp,PREG_SET_ORDER))
        if(count($bp))
            foreach($bp as $b11)
                $bpp.=";img=".$b[0]."_p".$b11[1].";endimg;";
                
    $q1=mysql_query("SELECT `rate`,`params` FROM `glosys`.`remains` WHERE `counter`=".$b[0]);
    if(mysql_num_rows($q1)) {
        $q2=mysql_fetch_row($q1);
        $ttt=$q2[0];
        if (substr($b[1], 0, 1)=="#") $ttt=-1;

        $bpp.=";amount=".$ttt.";endamount;amounts=".$q2[1].";endamounts;";
        if($q2[0]>=0) $p=1;
    };
    
    if (!preg_match("/comment,,show/",$b[2])) $p=0;
    
    $q1=mysql_query("SELECT `params` FROM `glosys`.`prices` WHERE `counter`=".$b[0]);
    if(mysql_num_rows($q1)) {
        $q2=mysql_fetch_row($q1);
        $bpp.=";prices=".$q2[0].";endprices;";
    }
    
    $ra="id=".$b[0].";endid;title=".$b[1].";endtitle;intro=".$b[2].";endintro;body=".$b[3].";endbody;pict1=".$b[4].";endpict1;".$bpp.";date=".$b[5].";enddate;rate=".$b[6].";endrate;count=".$b[7].";endcount;paramcsv=".$b[9]."";
    if($p) $x[]="('Q','".$ar[1]."','".mysql_real_escape_string($ra)."','Кьюти')";
}
echo implode(",",$x);
?>