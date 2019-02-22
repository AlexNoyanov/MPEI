
// CPU temperature writing in the text file
// The 6th of September 2018

// To compilate use: gcc <fileName.c> -o <result> -lrt

// Write temperature to the file
// Then read it with female voice

#include <stdio.h>

int main(){

    float systemp, millideg;
    FILE *thermal;
    FILE *fout;
    int n,deg;
    
    thermal = fopen("/sys/class/thermal/thermal_zone0/temp","r");       // System temp file
    fout = fopen("temp.txt","w");                                       // Output text file
    
    n = fscanf(thermal,"%f",&millideg);
    fclose(thermal);
    systemp = millideg / 1000;                                          // Temperature float
    
    printf("CPU temperature is %f degrees C\n",systemp);
    
    fprintf(fout,"%f \n",systemp);                                      // Print in the file
    
    fclose(fout);                                                       // Close file
    
    system("");   // Read it from file with nice female voice!
    system("flite -voice slt -t \"My processor temperature is\" ");   // Frase
    system("flite -voice slt -f \"temp.txt\" ");                        // Temp
    system("flite -voice slt -t \" degrees Celsius\" ");
    
    return 0;

}
