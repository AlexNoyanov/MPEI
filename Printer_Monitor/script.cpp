// This script will execute commands 
// in the comand line

// September 17 2019
// By Alex Noyanov 

// Making pictures with current date and time name

#include <iostream>
#include <cstdlib>
#include <string>
#include <fstream>
#include <cstring>

using namespace std;

// Getting current date and the time:
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

int main()
{
    string cDate = currentDateTime();
    
    //FILE* flog = fopen("log.txt","-wt");

    cout << "currentDate = " << cDate << endl;
    
    // Cutting the Date part from the string:
    int k = 0;
    string date;
    while(cDate[k] != '.'){
        date += cDate[k];
        k++;
    }
    
    // Cutting the Time part from the string:
    string tme;
    for(int i = k+1; i < cDate.size();i++){
        tme += cDate[i];
    }
    
    cout << "Time = " << tme << endl;
    
    cout << "Date = " << date << endl;
    
    system(" echo === Making a picture ===");
   
    string picName = date+".jpg";

    // Making command from it:
    cout << "Picture name:" << picName << endl;
    string command = "raspistill -o /home/pi/work/Projects/Website/Photos/" + picName ;
    cout << "Command = " << command << endl;
    
    // Converting string to char* format:
    char* com = new char[command.size()+1];
    command.copy(com,command.size()+1);
    com[command.size()] = '\0';
    
    cout << com << endl;
    system(com);    // Photo with name date and time
    system("raspistill -o /home/pi/work/Projects/Website/Photos/current.jpg");  // Photo current
    
//    fprintf(flog,"=== Making picture ===");
//    fprintf(flog,cDate);
//    fprintf(flog,tme);
    
    ofstream flog;
    flog.open("log.txt",ios::app);
    if (flog == 0)
    {
        cout << "ERROR opening log file!" << endl;
        return 1;
    }
    else
    {
        flog << "=== Making a picture ===" << endl;
        flog << cDate << endl;
    }
    flog.close();
    
return 0;
}
