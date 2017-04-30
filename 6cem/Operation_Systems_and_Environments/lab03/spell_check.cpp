#include "stdio.h"
#include <iostream>

#include <string>
using namespace std;



bool isSimilarWord(string input, string sample){
    if (input.length() != sample.length()) return false;
    bool errors_allowed = true;
    int current_char = 0;
    while(errors_allowed || current_char != input.length()-1){
        if(input[current_char]==sample[current_char]) continue;
        if (errors_allowed){
            errors_allowed = false;
            continue;
        }
        else return false;
    }
    return true;
}

int main(int argc, char* argv[]){
    string a = "kek";
    string b = "kak";
    cout << isSimilarWord(a,b);
}