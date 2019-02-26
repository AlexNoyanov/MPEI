<html>
<head>
<title>Script page to setup LCD</title>

<?PHP

$lcdtext = $_POST['lcdtext'];
print ($lcdtext);

?>

</head>


<body bgcolor = "silver" >
<h1>

<?php
 $pi = shell_exec("/var/www/html/test.sh");
 echo $pi;
?>
</h1>
<?php
  echo "<br>";
  echo date('Y-m-d H:i:s');
  echo "<br>";
?>

<FORM NAME ="form1" METHOD ="POST" ACTION = "script.php">

<INPUT TYPE = "TEXT" NAME = "lcdtext" VALUE ="test" >
<INPUT TYPE = "SUBMIT" NAME = "Setup" VALUE = "Set text">

</FORM>


<?php
  echo "<br>Hello world!<br>"; // Your code here

  exec("sudo /var/www/html/PrintDataLCD $lcdtext");

  echo "lcdtext = $lcdtext";
?>


 <br><h2>Number of readers = 
<?php
  //function vk_fans_count($vkID) {
  //    $json_string = file_get_contents('http://api.vk.com/method/groups.getById?gid='.$vkID.'&fields=members_count');
  //    $json = json_decode($json_string, true);
 �//�   return $json['response'][0]['members_count'];
  //}ø

 //echo vk_fans_count(184237738);



   //function vk_shares($url) 
   //{
   //   $str = @file_get_contents("http://vk.com/share.php?act=count&index=1&url=".urlencode($url));
   //   preg_match('#VK.Share.count\(1, ([0-9]+)\);#', $str, $matches);
   //   return (count($matches) > 1) ? intval($matches[1]) : false;
   //}
 
  //echo vk_shares("https://vk.com/ynoyanov");

?>


</h2>

</body>>
</html>
