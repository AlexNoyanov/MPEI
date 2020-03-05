
// Use this program to turn ON the GPIO pin
// ledON <pin number>

#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv){

int pin = atoi(argv[1]);
int pin2 = atoi(argv[2]);
int delayTime = atoi(argv[3]);

 printf("Raspberry Pi wiringPi blink test\n");

  if (wiringPiSetup() == -1)
//    exit (1);

  pinMode(pin, OUTPUT);

  for (;;){
    printf("LED On\n");
    digitalWrite(pin, 1);
    digitalWrite(pin2,0);
    delay(delayTime);
    printf("LED Off\n");
    digitalWrite(pin, 0);
    digitalWrite(pin2,1);
    delay(delayTime);
  }
 return 0;

}
