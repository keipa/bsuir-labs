#include <stdio.h>

int main(){
 FILE *file;
 char* file_name = "file.txt";

 file = fopen(file_name, "w");
fputs("Misha loh", file);
close(file);
}
