// Save CPU parameters to the text file
// Print data on the screen

// To compile:  gcc tempLCD.c -o tempLCD -lwiringPi -lwiringPiDev
// gcc statistics.c -o statistics -lwiringPi -lwiringPiDev

/* 26 October 2017
 
    define from  wiringPi.h                     define from Board DVK5$
      3.3V | | 5V               ->                 3.3V | | 5V
     8/SDA | | 5V               ->                  SDA | | 5V
     9/SCL | | GND              ->                  SCL | | GND
         7 | | 14/TX            ->                  IO7 | | TX
       GND | | 15/RX            ->                  GND | | RX
         0 | | 18               ->                  IO0 | | IO1
         2 | | GND              ->                  IO2 | | GND
         3 | | 23               ->                  IO3 | | IO4
       VCC | | 24               ->                  VCC | | IO5
   MOSI/12 | | GND              ->                 MOSI | | GND
   MISO/13 | | 25               ->                 MISO | | IO6
    SCK/14 | | 8/CE0            ->                  SCK | | CE0
       GND | | 9/CE19           ->                  GND | | CE1
 */

#include <stdio.h>
//#include <iostream>

#include <string.h>
#include <errno.h>
#include <stdlib.h>

#include<wiringPi.h>
#include<lcd.h>
//#include <time.h>
#include <unistd.h>

const int RS = 3;       //
const int EN = 14;      //
const int D0 = 4;       //
const int D1 = 12;      //
const int D2 = 13;      //
const int D3 = 6;       //

//using namespace std;

void stringScroll(char* str,int speed)
{
    int lcdFD;
    lcdFD = lcdInit(2, 16, 4, RS, EN, D0, D1, D2, D3, D0, D1, D2, D3);
    
    char buffer[16];
    int pos = 0;
    int i;
   // lcdPosition(lcdFD,0,0);
    while(str[pos] != '\0')
    {
//        if(pos > 16)
        //lcdFD = lcdInit(2, 16, 4, RS, EN, D0, D1, D2, D3, D0, D1, D2, D3);
        lcdPosition(lcdFD,0,0);
        //
        for(i = 0; i < 16 ;i++)
        {
            buffer[i] = str[pos+i];
        }
        sleep(speed);
       // delay(speed);
        pos++;
        lcdPrintf(lcdFD,buffer);
        //lcdPrintf(lcdFD,buffer);
        //sleep(speed);
        //pos++;
    }
//    for(i = 0; i< 16; i++)
//    {
//        sleep(1);
//        lcdPosition(lcdFD,0,i);
//        lcdPrintf(lcdFD,buffer[i]);
//        pos++;
//    }
    
    
}

// Use vcgencmd commands to show status
int main()
{
    // Wiring pi status
    if (wiringPiSetup() < 0)
    {
        fprintf (stderr, "Unable to open serial device: %s\n", strerror (errno)) ;
        return 1 ;
    }

    int lcdFD;
    lcdFD = lcdInit(2, 16, 4, RS, EN, D0, D1, D2, D3, D0, D1, D2, D3);
    lcdPosition(lcdFD,0,1);
    lcdPrintf(lcdFD," ");
    stringScroll("Testing string! Scrolling... 1 2 3 4 5 6 7 8 9 0", 1);
    
    //lcdPosition(lcdFD, 0,0);
    
    //lcdPrintf(lcdFD,"===RPI STATUS:===");
    
    //lcdPosition(lcdFD, 0,1);
    
    //lcdPrintf(lcdFD, "Hello from PI!");
    
    
//    printf("    ==== Raspberry Pi A  Status====\n");
//
//    system("/opt/vc/bin/vcgencmd measure_temp > sysTemp.txt");          // Create files with status
//    system("/opt/vc/bin/vcgencmd get_config int > Config.txt");
//
    
    
    //printf("Core frequency: ");
    //system("vcgencmd measure_clock core");
    //system("vcgencmd measure_volts");
    //system("vcgencmd measure_temp");
    /*
    FILE* ftemp = fopen("/opt/vc/bin/vcgencmd measure_temp","-rb");   // Temp file
    
    if(!ftemp)                                                      // If not temp file
        printf("Can't open temp file to read!");
    /*
    char buf[BUFSIZE];                                              // Buffer
    
    fread(buf, BUFSIZE, 1, ftemp);
    
    //while (fscanf(ftemp,"%s",sizeof(buf) )==1)                               // Copy from temp file to buffer
    // {}
    int i;
    for(i = 0; i < BUFSIZE; i++)
    {
        printf("%s",buf[i]);
    }
       // printf("%s\n", buf);
    
    FILE* tTemp = fopen("CPUtemp.txt","w");
    
    if(!tTemp)
        printf("Can't create txt file!");
    
    
    
    //while(buf != null)
    //fprintf(tTemp,"",sizeof(buf),buf);
    /*
    while(ftemp != NULL)
    {
        temp[i] = fscanf(ftemp,"%s");
    }
     */
    
   
    
    //fclose(ftemp);
    //fclose(tTemp);
    //printf(" Hz \n");
    
 return 0;
}
