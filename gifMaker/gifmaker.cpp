//
//  gifmaker.cpp
//  
//
//  Created by Alex Noyanov on 16/02/2020.
//

// gifmaker will create a gif file
// Parameter: <time between photos> <number of photos>

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <bits/stdc++.h>

// Libraries for delay:
#include <chrono>
#include <thread>
// Thus for compiling this code use: "g++ gifmaker.cpp -o gifmaker+  -std=c++11"

using namespace std;

// To converting string to char*
//char* strToChar(string str){
//
//    // convering strign to char*:
//    int n = str.length();
//    char* result;
//    strcpy(result, str.c_str());
//
//    return result;
//}

// The correct way to convert "string" to "char*" is "str.c_str()"

// function for making pictures in the folder
void makePhotos(int num, int dTime, string folder){
    string photoCommand = "raspistill -o /home/pi/Photos/gifMaker/" + folder + "/";
    //photoCommand = photoCommand + to_string(i) + ".jpg";                // The picture name is "<i>.jpg"
    string resCommand ;//= photoCommand + to_string(i) + ".jpg";
    for(int i = 0; i < num; i++){
        resCommand = photoCommand + to_string(i) + ".jpg";
        cout << resCommand << endl;
        system(resCommand.c_str());                                       // Making new photo
        
        // Delay between each photo:
        std::this_thread::sleep_for(std::chrono::milliseconds(dTime*1000));
        resCommand = "";
    }
}

// string gifName, string folder
void createGif(string gifName, string folder)
{   //convert -delay 10 -loop 0 image*.jpg animation.gif'
    string command = "convert -delay 10 -loop 0  /home/pi/Photos/gifMaker/"+folder+"/*.jpg /home/pi/Photos/gifMaker/" + folder + "/" + gifName;
    cout << command << endl;
    system(command.c_str());
    
    cout << "Gif " << gifName << " is done!" << "\n";
}


int main(int argc, char *argv[]){
    
    // Main parameters of the gif:
    int delayTime = 0;              // Time between each frame
    int numbOfPhotos = 0;           // Number of frames in the gif
    
    // Getting the folder name:
    // The new folder with photos will be named as curentDate+time:
       time_t rawtime;
       struct tm * timeinfo;

       time ( &rawtime );
       timeinfo = localtime ( &rawtime );
       //printf ( "Current local time and date: %s", asctime (timeinfo) );
       
        string dFname = asctime (timeinfo) ;
       // dateFilename = remove_if(dateFilename.begin(), dateFilename.end(), isspace());
        dFname.erase( std::remove_if( dFname.begin(), dFname.end(), ::isspace ), dFname.end() );
        std::cout << "File name is:" << dFname << "\n";
        
        // Creating new folder for photos:
        string makeFolder = "mkdir /home/pi/Photos/gifMaker/" + dFname;
        // cout << makeFolder;
        // convering strign to char*:
        //char* cmakeFolder = strToChar(makeFolder);
        system(makeFolder.c_str());                            // Making the folder for the pictures
    
    // Using program with parameters or with terminal input
    if(argc>1)
 {
    delayTime = strtol(argv[0], NULL, 10);;        // Delay time between the photos
    numbOfPhotos = strtol(argv[1], NULL, 10);      // Number of photos
     
 }else{
     cout << "         ==== WELCOME TO GIFMAKER ====" << "\n";
     cout << "This program is making GIFs timelapses from camera" << "\n";
     cout << "Please input main parameters:" << "\n" << "\n";
     cout << "Delay between photos (seconds):"<< "\n";
     cin >> delayTime;
     cout << "Number of photos:"<< "\n";
     cin >> numbOfPhotos;
 }
     // Now making pictures with interval in this folder:
     makePhotos(numbOfPhotos,delayTime,dFname);
    string gifName = "animation.gif";
     createGif(gifName, dFname);
    
    return 0;
}


