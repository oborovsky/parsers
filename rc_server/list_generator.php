<? $t0="common.php"; while(!defined("ROOT")) {include($t0); $t0="..".DIRECTORY_SEPARATOR.$t0;}; unset($t0); //$DEBUG=1;

$parkeys = array_pop(mysql_fetch_row(mysql_query("SELECT body FROM keywords WHERE id=35")));
$parkeys = explode(",,,,",$parkeys);
$title = explode(",,",$parkeys[0]);$site_title="КЬЮТИ-dизайн / ".$title[1];
$key_words = explode(",,",$parkeys[1]);$key_words=$key_words[1];
$desc = explode(",,",$parkeys[2]);$desc=$desc[1];

$file=fopen("robo/robocatlist.html","w") or die("Unable to open file!");
$str='<!DOCTYPE html>
<html>
<head>
    <title>'.$site_title.'</title>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
    <META NAME="keywords" CONTENT="'.$key_words.'">
    <META NAME="description" CONTENT="'.$desc.'">
    <meta name="reply-to" content="Лучшие бизнес-сувениры в Новосибирске" />
    <meta name="copyright" content="Лучшие бизнес-сувениры в Новосибирске" />
    <meta http-equiv="expires" content="-1" />
    <meta name="revisit-after" content="1 days">
    <meta name="audience" content="All" />
    <meta name="distribution" content="All" />
    <meta name="robots" content="ALL" />
</head>
<body><h1>'.$site_title.'</h1>';
$item_t=" `".q_("SELECT `val` FROM `config` WHERE `nam`='item'",1)."` ";
$sql = "SELECT `id`,`arts` FROM ".$item_t;
if ($q=mysql_query($sql))
{
    while($row=mysql_fetch_row($q))
    {
        $str.="<a href='http://cuty.ru/robocat/".$row[0]."'>Арт. ".$row[1]."</a> ";
    }
}

$str.='</body>
</html>';
fwrite($file,$str);
fclose($file);
//echo $str;
?>