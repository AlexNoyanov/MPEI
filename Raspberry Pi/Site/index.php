<html>
 <head>
  <title>Alex PHP Test</title>
 </head>
 <body bgcolor = "#ff0101">

 <center>
 <h1> Welcome to the Alex site!  </h1>
 <h3>
 <button class="btn info">Info</button>
 </h3>

<form action="script.php" method="get">
  <input type="submit" value="Run me now!">
</form>

 <p>Date:
	<!--<?php echo 'hello world<p> </p>' ; ?> --> 
	<?php echo date('Y-m-d'); ?></p>
	<p>Time: <?php echo date('H:i:s');?></p>
	<?php phpinfo(); ?>

</center>
</body>
</html>
