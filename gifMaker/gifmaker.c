//
//  gifmaker.c
//  
//
//  Created by Alex Noyanov on 16/02/2020.
//

// gifmaker will create a gif file
// Parameter: <time between photos> <number of photos>

#include <stdio.h>
#include <time.h>

#include <stdlib.h>

int main(int argc, char *argv[]){
    if(argc>1)
 {
    int delayTime = strtol(argv[0], NULL, 10);;        // Delay time between the photos
    int numbOfPhotos = strtol(argv[1], NULL, 10);      // Number of photos
    
    // The new folder with photos will be named as curentDate+time:
    time_t rawtime;
    struct tm * timeinfo;

    time ( &rawtime );
    timeinfo = localtime ( &rawtime );
    printf ( "Current local time and date: %s", asctime (timeinfo) );
    
    char* fileName = asctime (timeinfo);
 }   
    
    return 0;
}


