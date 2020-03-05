
// Use this program to turn ON the GPIO pin
// ledBlinking <pin1 number> <pin2 number> <delay between blinks>
// For example: ./ledBlinking 3 4 500

#include <wiringPi.h>
#include <stdio.h>

int main(int argc, char **argv){

int pin = atoi(argv[1]);
int pin2 = atoi(argv[2]);
int delayTime = atoi(argv[3]);

 printf(" ==== Raspberry Pi wiringPi blink test ====\n");

  if (wiringPiSetup() == -1)
  //    exit (1);

  pinMode(pin, OUTPUT);

    while(1){
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
