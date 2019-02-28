
<!-- This page is for printing messages on LCD screen  -->

<head>

<title>Print messages on LCD </title>

<center>

<h1> Print message on the Raspberry PI LCD! </h1>

<h3> Your message: </h3>

<!-- Here is the PHP script to execute C++ code on the server -->
<h3  style="color:blue;" >
<?PHP

$textfield = $_POST['textfield'];
print ($textfield);

exec("sudo /var/www/html/PrintDataLCD {$textfield}",$out);
?>

</h3>
</center>

</head>

<body bgcolor = "silver">

<center>

<!-- Input form to read the message and the button to reload this page to execute the script -->

<form Name =  "MessageForm" METHOD = "POST" ACTION = "LCDPrint.php" Value = "Test" >

<INPUT TYPE = "Text"  NAME = "textfield" SIZE = "32" >

<p> </p>
<INPUT TYPE = "Submit" Name = "Submit1" VALUE = "Send Message!">

</form>

<h4>
LCD can print 16 symbols on each of two strings
<p> </p>
To print the space symbol use '\'
<p> </p>
Without this special symbol the word after space
<p></p> will be printed on the new line on the screen!
 </h4>
</center>
</body>
