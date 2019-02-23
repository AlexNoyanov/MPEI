//
//  PrintData.cpp
//  
//
//  Created by Александр Ноянов on 23/02/2019.
//

// To compilate use:
// g++ PrintData.cpp -o PrintData -lrt -lwiringPi -lwiringPiDev

// How to use: ./PrintData <First string data> <Second string data>
// Just type what you want to type on each string after ./PrintData

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

//#include "PrintData.hpp"

#include <iostream>

#include <wiringPi.h>
#include <lcd.h>

#include <unistd.h>

#include <errno.h>
#include <stdlib.h>

const int RS = 3;       //
const int EN = 14;      //
const int D0 = 4;       //
const int D1 = 12;      //
const int D2 = 13;      //
const int D3 = 6;       //


using namespace std;

int main(int argc,char *argv[])
{
    // Experimenting with argc and *argv[] parameters
    //cout << "You have entered " << argc
    //<< " arguments:" << "\n";
    
    //for (int i = 0; i < argc; ++i)
        //cout << argv[i] << "\n";

    
    // Wiring pi status
    if (wiringPiSetup() < 0)
    {
        //fprintf (stderr, "Unable to open serial device: %s\n", strerror (errno)) ;
        return 1 ;
    }
    
    int lcdFD;
    lcdFD = lcdInit(2, 16, 4, RS, EN, D0, D1, D2, D3, D0, D1, D2, D3);
    
    lcdPosition(lcdFD, 0,0);
    
    lcdPrintf(lcdFD,argv[1]);
    
    lcdPosition(lcdFD, 0,1);
    
    lcdPrintf(lcdFD,argv[2]);
    
    return 0;
}

