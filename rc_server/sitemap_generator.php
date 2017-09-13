<?
include("common.inc");
include("library/functions.php");
$link=db_connect($db,$db_server,$db_login,$db_password);// Connect MySQL server

include "menu_struct.inc";

function URL($url,$show)
{
    echo "=========| <a href='".$url."/'>".$show."</a><br>";
}

$urls=array();

foreach($a as $key => $val)
{
    foreach($val as $k => $v)
    {
        $tbl=str_replace("/s","_",trim($v[1],'/'));
        $link=SITE.ltrim($v[1],"/");
///        echo $tbl;
///        echo "<br>";
///        echo "URL: <a href='".$link."'>LINK</a><br>";
        $urls[]=$link;
        
        if (isset($v[4]))
        {
            $data = explode(" ",$v[4]);
            if (isset($data[2])) $tbl=$data[2];
        }

        if(mysql_num_rows(mysql_query("SHOW TABLES LIKE '".$tbl."'"))==1)
        {
            if (isset($v[4]))
            {
                if ($data[0]=="list")
                {
                    $ttt = $tbl;
                    
                    $sql="SELECT * FROM ".$tbl." WHERE rate>=0 AND counter>=0";
                    if ($q=mysql_query($sql))
                    {
///                        echo "[ ".mysql_num_rows($q)." ]<br>";
                        while($row=mysql_fetch_assoc($q))
                        {
                            $id=$row['id'];
                            if (isset($data[3])) { preg_match($data[3],$row['body'],$tmp); $id=$tmp[1];}
///                            URL($link.$data[1].$id,"rec-".$data[1].$id);
                            $urls[]=$link.$data[1].$id;
                        }
                    } else echo mysql_error();
                }
                else if ($data[0]=="q")
                {
                    $sql="SELECT * FROM q_main_blocks WHERE floor(place/100)=".$data[1];
                    if ($q=mysql_query($sql))
                    {
                        while($row=mysql_fetch_assoc($q))
                        {
                            $lnk=SITE.ltrim($row["url1"],"/");
///                            URL($lnk,$lnk);
                            $urls[]=$lnk;
                        }
                    }
                }
            }
            //echo "[ ]";
        }
///        else
///            echo "[X]<br>";
///        echo "<br>";
    }
}

$urls[]="http://cuty.ru/vacancy/sresume/";

$out='<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';

foreach($urls as $v)
{
    $out.='<url><loc>'.$v.'</loc></url>';
}
$out.='</urlset>';

file_put_contents("sitemap.xml",$out);
?>