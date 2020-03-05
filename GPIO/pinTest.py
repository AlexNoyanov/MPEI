import time
import  RPi.GPIO as GPIO

GPIO.setmode(GPIO.BOARD)
GPIO.setup(11,GPIO.OUT)

while True :
         GPIO.output(26,0)
         time.sleep(1)
        GPIO.output(26,1)
       time.sleep(1)
