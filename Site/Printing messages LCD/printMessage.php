
    <!-- Page for printing messages on Raspberry PI LCD -->
    <!-- October 30 2019, Moscow -->

<html>
 <head>
        <!-- Stylization-->
   <link rel="stylesheet" href="Style1-Rpbry.css">
       
       <center>
           <div class = "title2"><p class = "MainTitle">
               Printing messages on LCD screen
               <img class = "piLogo" src = "Images/rpi-logo.png" align = "middle"></img>
               </p></div>
       </center>
       
 </head>
<body bgcolor = "silver">
    <center>
   
    <br><br>
         
    <div class = "lcdPCB">
        <div class = "lcdFrame">
            <div class = "blueLCD">
               
     

<!-- === PHP CODE HERE: === -->


        <!--  <form  action = "submit.php" method = "POST" > -->

         <form  action = "printMessage.php" method = "POST" >
		<!-- LCD String 1 -->
                    <input  class = "blueLCDField" type = 'text' value = '' name = 'str1'  required
                        maxlength="16" >
                    </input>

		<input type="submit" style="display: none" >
                    <!-- LCD String 2 -->
                    <input  class = "blueLCDField2" type = 'text' value = '' name = 'str2' required
                        maxlength="16">
                    </input>
                    
                    <!--  Кнопка для отправки -->
                    <br> <br>
                     <input  type = 'submit' value = 'Print message' name = 'go' >
                 </form>
                  <!--  Button
                    <input  type = 'submit' value = 'Send text' >
                    </input> -->
      
      </div>
     </div>
    </div>
    </form>

    
    <br><br><br>
    
    <!--  Button for About page -->
    <input onclick="window.location.href = 'about.html' " type = 'submit' value = 'Learn more about this project' >
    </input><br>
    <br>
    <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
    </center>
    
</body>
