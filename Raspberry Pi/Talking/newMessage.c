// This script playing beeping sound 
// and female voice talk

// February 27 2019
// By Alexander Noyanov

#include <stdio.h>

int main(int argc, const char* argv[])
{
// Playing recorded sounds:
	system("amixer sset 'PCM' 80%");
	system("aplay /home/pi/Music/Beeps/accept.wav ");
	system("amixer  sset 'PCM'  90% ");	// Change sound level
	system("aplay /home/pi/Music/HumanVoices/you_have_a_new_text_message.wav");
	system("amixer set Mast 30%");
// Reading message:
	FILE* f = fopen("textMessage.txt","w");

// Copy all comand line arguments to the file:
	int i = 0;
	for(i = 1; i < argc; i++)
		fprintf(f,"%s\n",argv[i]);
	fclose(f);

// Read the message from the text file:
	system("flite -voice slt  -f \"textMessage.txt\"");

}
