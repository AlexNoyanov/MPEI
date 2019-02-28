
// This script can read the messages with female
// computer voice

#include <stdio.h>

#include <stdlib.h>
#include <string.h>

char* concat(const char *s1, const char *s2)
{
    char *result = malloc(strlen(s1) + strlen(s2) + 1); // +1 for the null-terminator
    // in real code you would check for errors in malloc here
    strcpy(result, s1);
    strcat(result, s2);
    return result;
}

int main(int argc, const char * argv[])
{
	const char * strSpeech = " flite -voice slt  -t ";
	concat(strSpeech,argv[1]);
//	concat(strSpeech,"\"");
	system(strSpeech);

return 0;
}
