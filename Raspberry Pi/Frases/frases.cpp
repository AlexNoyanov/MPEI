
// Frases to make speech more interesting
// The 7th of September 2018

// This program can randomly generate some sentencis

// Speech modeling in 3 steps:
//  1) Choose speech type
//  2) Choose sentence type
//  3) Choose sentence case and generate it randomly

#include <stdio.h>          // C standart
#include <string.h>         // For C++ string
#include <stdlib.h>
#include <time.h>
//#include <iostream.h>       // For C++ cin >> and cout <<
//#include <fstream>          // For C++ files

#define WORDSIZE 64           // Size of one word

using namespace std;

// Sentences model:

// 1) Improducing sentence:
// <First improducing words> -> <Second words>

// All words for sentences are situated in the following folders

// Generating random number:
int random_number(int min_num, int max_num)
{
    int result = 0, low_num = 0, hi_num = 0;
    
    if (min_num < max_num)
    {
        low_num = min_num;
        hi_num = max_num + 1; // include max_num in output
    } else {
        low_num = max_num + 1; // include max_num in output
        hi_num = min_num;
    }
    
    result = (rand() % (hi_num - low_num)) + low_num;
    
    printf("%d-%d -> %d\n",low_num,hi_num,result);
    return result;
}

/*  // Sentence as class:
class sentence{
    int type;       // Type of the sentence:
//    [0-Improducing (To start the dialoge)] [1 - Affirmative] [2-Question] [3-Fact]
    
public:
    sentence(int tpe);  // Class constructor with type of the sentence
    ~sentence();        // Destructor
    int showType();     // Show this sentence type method
    void generateType();// This method will generate type of the sentence
    
};
*/

//  ==  Generate word function: ==

//               file with words,how many words in file, output file
void generateWord(FILE* inWords, int n, FILE* speechFile)
{
    char word[WORDSIZE]; // Word buffer
    int i;
    int randomWord = 0;
    
    //Create sentence
    randomWord = random_number(1,3);               // Generate random word from "Hi" file
    
    // Now first word of this sentence should be one of this:
    for(i = 0; i < randomWord;i++){
        fgets(word,64,inWords);                     // Skip all words before the word we need
     }
    
    puts(word);                                     // Print this random word to the screen
    
    fputs(word,speechFile);                         // Print first word in the file
    
    memset(word,0,WORDSIZE*(sizeof (word[0])) );   // Clear the word array
}

int main(){

    int randomCase = 0;
   
    srand(time(NULL));

    // Open files:
    FILE* hiFrases = fopen("Hi.txt","rt");              // Hello frases
    FILE* secondWord = fopen("secondWord.txt","rt");    // After "Hello"
    
    FILE* questions = fopen("Questions.txt","rt");      // Questions for speech
    
    FILE* speech = fopen("speech.txt","w");             // Resulting speech made of random sentences
    
    
   /*
    
    char word[WORDSIZE]; // Word buffer
    
    //Create improducing sentence
    randomWord = random_number(1,3);            // Generate random word from "Hi" file
    
    // Now first word of this sentence should be one of this:
    for(i = 0; i < randomWord;i++){
        fgets(word,64,hiFrases);                // Skip all words before the word we need
    }
    
    puts(word);                                 // Print this random word to the screen
    
    fputs(word,speech);                         // Print first word in the file
    
    memset(word,0,WORDSIZE*(sizeof (word[0])) );// Clear the word array
    
    // Generate second word
    randomWord = random_number(1,3);            // Generate random word from "second word" file
    // Now first word of this sentence should be one of this:
    for(i = 0; i < randomWord;i++){
        fgets(word,64,secondWord);               // Skip all words before the word we need
    }
    puts(word);                                 // Print this random word to the screen
    
    fputs(word,speech);                         // Print first word in the file
    
    memset(word,0,WORDSIZE*(sizeof (word[0])) );// Clear the word array
   // }
    
    */
    
    generateWord(hiFrases,3,speech);
    generateWord(secondWord,3,speech);
    
    
    // Close all files:
    fclose(hiFrases);
    fclose(secondWord);
    fclose(questions);
    fclose(speech);
    
    return 0;

}
