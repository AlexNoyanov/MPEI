
// CPU temperature writing in the text file
// And talk

// The 6th of September 2018

// To compilate use: gcc <fileName.c> -o <result> -lrt

#include <stdio.h>

int main(){

    // === TO WRITE TEMPERATURE IN THE TEXT FILE  ===
    /*
    float systemp, millideg;
    FILE *thermal;
    FILE *fout;
    int n,deg;
    
    thermal = fopen("/sys/class/thermal/thermal_zone0/temp","r");       // System temp file
    fout = fopen("temp.txt","w");                                       // Output text file
    
    n = fscanf(thermal,"%f",&millideg);
    fclose(thermal);
    systemp = millideg / 1000;                                          // Temperature float
    deg = millideg / 1000;                                              // Temperature
    
    printf("CPU temperature is %f degrees C\n",systemp);
    
    fprintf(fout,"%d \n",deg);                                          // Print in the file

    fclose(fout);                                                       // Close file
     
     */
//      =========== ============
    
    //system("/home/pi/work/Programs/CPU_temp/temp_to_file ");   // Run program to write temperature in the file
    
   // system ("cd ");
   // system("cd work/Programs/CPU_temp");
    
   // system("./temp_to_file");
    
    //system("cd");
    
    system("./temp_to_file");
    
    system("flite -voice slt -f \"/home/pi/work/Voice/CPU_temp_talk/cpu_temp_frase.txt\" ");   // Frase
    system("flite -voice slt -f \"/home/pi/work/Programs/CPU_temp/temp.txt\" ");               // Temp
    
    system("flite -voice slt -t \" degrees Celsius\" ");
    
    return 0;
    

}
