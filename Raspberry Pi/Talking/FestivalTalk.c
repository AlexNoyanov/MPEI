

// This script can talk the speech
// as command line argument

// Using Flite
#include <stdio.h>
#include <iostream>

using namespace std;

int main(int argc, const char * argv[]){
    

std::string first_arge;
  std::vector<std::string> all_args;

  if (argc > 1) {

    first_arge = argv[1];

    all_args.assign(argv + 1, argv + argc);
  }

    string  speech =   "flite -voice slt -t " + first_arge;
    system(speech);
    
    return 0;
}
