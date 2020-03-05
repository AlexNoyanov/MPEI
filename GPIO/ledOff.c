
// Use this program to turn OFF the GPIO pin
// ledOff <pin number>

#include <wiringPi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv){

int pin = atoi(argv[1]);
//int pin2 = atoi(argv[2]);
//int delayTime = atoi(argv[3]);

 printf("       ======= Raspberry PI LED OFF ====== \n");

  if (wiringPiSetup() == -1)
//    exit (1);

    pinMode(pin, OUTPUT);

    printf("LED Off\n");
    digitalWrite(pin, 0);

return 0;
}

