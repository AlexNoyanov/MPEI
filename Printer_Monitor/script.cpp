// This script will execute commands 
// in the comand line

// September 17 2019
// By Alex Noyanov 

#include <iostream>
#include <cstdlib>
#include <string>

using namespace std;

const std::string currentDateTime() {
    time_t     now = time(0);
    struct tm  tstruct;
    char       buf[80];
    tstruct = *localtime(&now);
    // Visit http://en.cppreference.com/w/cpp/chrono/c/strftime
    // for more information about date/time format
    strftime(buf, sizeof(buf), "%Y-%m-%d.%X", &tstruct);
    
    return buf;
}

const std::string currentTime(){
    
    return buf;
}

int main()
{
    
    string cDate = currentDateTime();
    string cTime =
    cout << "currentDate = " << cDate << endl;
    system(" echo === Making a picture ===");
    char* com;
    string command = "raspistill -o /home/pi/work/Projects/Website/Photos/" + cDate + ".jpg";
    for(int i = 0; i < command.size()+1;i++){
        com[i] = command[i];
    }
    
    system(com);
           
return 0;
}
