#include <stdio.h>
#include <conio.h>
#include <dos.h>

void play_sound(double freq, unsigned int time);
// void pause(int cycle);

void registers_status();
void division_factor();
unsigned int rnd(unsigned int range);

// pauses
// #define sp 2
// #define sdp 3
// #define ep 4
// #define edp 5

#define sp 86
#define sdp 129
#define ep 172
#define edp 258
#define qp 344
#define qdp 516
#define hp 688
#define hdp 1032
#define wp 1376
#define nil 10

// vocals
#define Fd 739.98
#define fd 369.99
#define d 239.66
#define D 587.32
#define cd 554.36
#define Cd 1108.70
#define h 493.88
#define e 659.26
#define E 1318.50
#define gd 415.30
#define Gd 830.60
#define aa 220.0
#define a 440.0
#define A 880.0
#define H 987.70

#define ps 1


double notes[] =
  {
    // ta ta ta ta ta  ta ta
    
    Fd, ps, Fd, ps, D, ps, h, ps, h, ps, e, ps,
    ps, e, ps, e, ps, Gd, ps, Gd, ps, A, ps, H, ps,
    A, ps, A, ps, A, ps, e, ps, D, ps, Fd, ps,
    ps, Fd, ps, Fd, ps, e, ps, e, ps, Fd, ps, e, ps,
    
    Fd, ps, Fd, ps, D, ps, h, ps, h, ps, e, ps,
    ps, e, ps, e, ps, Gd, ps, Gd, ps, A, ps, H, ps,
    A, ps, A, ps, A, ps, e, ps, D, ps, Fd, ps,
    ps, Fd, ps, Fd, ps, e, ps, e, ps, Fd, ps, e, ps,

    Fd, ps, Fd, ps, D, ps, h, ps, h, ps, e, ps,
    ps, e, ps, e, ps, Gd, ps, Gd, ps, A, ps, H, ps,
    A, ps, A, ps, A, ps, e, ps, D, ps, Fd, ps,

    ps, Fd, ps, Fd, ps, e, ps, e, ps, e, ps,

    // something 
    D, ps, D, ps, cd, ps, h,
    ps, h, ps,
    cd, ps, cd, ps, cd, ps, a, ps,
    a, ps, Fd, ps, Fd, ps, Fd, ps, e, ps, D, ps,
    D, ps, D, ps, cd, ps, h, ps,
    ps, ps, h, ps,
    cd, ps, D, ps, cd, ps, h, ps, a, ps,
    a, ps, h, ps, cd, ps, h, ps, a, ps,
    ps, D, ps, D, ps, D, ps, D, ps,
    ps,
    ps, a, ps, a, ps, a, ps, a, ps, a, ps, gd, ps,
    gd, ps, gd, ps, fd, ps, fd, ps, fd, ps,

    // take on me
  
    aa, ps,			// take
    gd, ps,			// on
    a, ps,			// me
    
    e, ps, Fd, ps, e, ps, 	// take on me

    a, ps,			// take
    e, ps, 			// me
    Fd, ps,			// on

    e, ps, Fd, ps, e, ps, 	// take on me

    cd, ps,			// i'll
    Gd, ps, Gd, ps,		// be
    A, ps,			// gone

    ps, H, ps, Cd, ps, H, ps, A, ps, // In a day
    A, ps, E, ps,		     // or T
    E, ps,			     // W
    E, ps			     // O
    
    ,-1
  };

unsigned int pauses[] =
  {
    sp, sp, sp, sp, sp, sp, sp, edp, sp, edp, sp, sp,
    ep, sp, edp, sp, sp, sp, sp, sp, sp, sp, sp, sp, sp,
    sp, sp, sp, sp, sp, sp, sp, edp, sp, edp, sp, sp,
    ep, sp, edp, sp, sp, sp, sp, sp, sp, sp, sp, sp, sp,

    sp, sp, sp, sp, sp, sp, sp, edp, sp, edp, sp, sp,
    ep, sp, edp, sp, sp, sp, sp, sp, sp, sp, sp, sp, sp,
    sp, sp, sp, sp, sp, sp, sp, edp, sp, edp, sp, sp,
    ep, sp, edp, sp, sp, sp, sp, sp, sp, sp, sp, sp, sp,

    sp, sp, sp, sp, sp, sp, sp, edp, sp, edp, sp, sp,
    ep, sp, edp, sp, sp, sp, sp, sp, sp, sp, sp, sp, sp,
    sp, sp, sp, sp, sp, sp, sp, edp, sp, edp, sp, sp,
    ep, sp, edp, sp, sp, sp, sp, sp, sp, sp, edp,
            
    qdp, nil, qp, nil, ep, nil, qp,
    nil, hp, hp,
    ep, nil, qp, nil, qp, nil, qdp, nil,
    ep, nil, qp, nil, ep, nil, qp, nil, ep, nil, ep, nil, 
    qdp, nil, qp, nil, ep, nil, qp, nil,
    hdp, ep, ep, nil,
    qp, nil, ep, nil, qp, nil, ep, ep, ep, nil,
    ep, nil, qp, nil, ep, nil, qp, nil, qp, nil,
    qp, qp, nil, qp, nil, ep, nil, ep, nil,
    hp,
    qp, ep, nil, ep, nil, ep, nil, ep, nil, ep, nil, ep, nil, 
    ep, nil, ep, nil, ep, nil, hp, nil, ep, nil,

    wp, nil,
    wp, nil,
    wp, nil,

    qdp, nil, qdp, nil, qp, nil,

    wp, nil,
    wp, nil,
    wp, nil,

    qdp, nil, qdp, nil, qp, nil,

    wp, nil,
    hdp, nil, qp, nil,
    wp, ps,

    qp, ep, nil, qp, nil, qp, nil, ep, nil,
    qp, nil, hdp, nil,
    wp, nil,
    wp, nil
    
  };

int main(void)
{
  int i;
  int rand_seed;
  char c;
  c = '\0';

  while ('q' != c)
    {
      printf("Press 1 to play music\n"
      "Press 2 to get random number\n"
      "Press 3 to display division factor\n"
      "Press 4 to display registers status\n"
      "Press q to quit\n");

      c = getchar();
      
      switch (c)
	{
	case '1':
	  {
	    for (i = 0; -1 != notes[i]; i++)
	      {
		play_sound(notes[i], pauses[i]);
	      }
	    getchar();
	    printf("Press any key to continue\n");
	    break;
	  }
	case '2':
	  {
	    printf("Enter random range\n");
	    scanf("%d", &rand_seed);
	    printf("Random number is: %u\n", rnd(rand_seed));
	    printf("Press any key to continue\n");
	    getchar();
	    break;
	  }
	case '3':
	  {
	    division_factor();
	    printf("Press any key to continue\n");
	    getchar();
	    break;
	  }
	case '4':
	  {
	    registers_status();
	    printf("Press any key to continue\n");
	    getchar();
	    break;
	  }
	case 'q':
	  {
    	    break;
	  }
	default:
	  {
	    break;
	  }
	}
      
      while (getchar() != '\n');
      system("CLS");
    }

  return 0;
}


void play_sound(double freq, unsigned int time)
{

  unsigned int cnt;
  
  outp(0x43, 0xB6);

  cnt = (unsigned int)(1193180.0 / freq);
    
  outp(0x42, cnt % 256);
  cnt /= 256;
  outp(0x42, cnt);

  if(ps == freq)
    {
      outp(0x61, inp(0x61) | 1);
    }
  else
    {
      outp(0x61, inp(0x61) | 3);
    }
  
  delay(time);


  outp(0x61, inp(0x61) & 0xfc);
}


// void pause(double cycle)
// {
//   _asm {
//       push si

// 	mov  si, cycle
// 	mov  ah, 0		// lower part of clock -> dx
// 	int  1Ah

// 	mov  bx, dx
// 	add  bx, si		// clock + delay
// 	}

// 	pauses:
//   _asm {
// 	int  1Ah		// get new clock value 
// 	cmp  dx, bx		// cmp time + delay and time
// 	jne  pauses

// 	pop  si
// 	}
//   return;
// }

void print_byte(int number)
{
  // int i;
  // for (i = 0; i < 8; i++)
  //   {
  //     printf("%c", number % 2 ? '1' : '0');
  //     number /= 2;
  //   }
  // return;

  int temp;
  static int i = 0;
  temp = number % 2;

  if (i == 8) return;
  i++;
  print_byte(number / 2);
  i--;
  printf("%d", temp);
}

void registers_status()
{
  int i;
  for (i = 0; i < 3; i++)
    {

      switch (i) {
      case 0:
	{
	  printf("First channel status word: ");
	  outp(0x43, 0xE2);
	  print_byte(inp(0x40));
	  printf("\n");
	  break;
	}

      case 1:
	{
	  printf("Second channel status word: ");
	  outp(0x43, 0xE4);
	  print_byte(inp(0x41));
	  printf("\n");
	  break;
	}
      
      case 2:
	{
	  printf("Third channel status word: ");
	  outp(0x43, 0xE8);
	  print_byte(inp(0x42));
	  printf("\n");
	  break;
	}
      }
    }

  return;
}

void division_factor()
{
  unsigned int low_byte, high_byte, division_factor, max;
  int channel;
  long int i;
  low_byte = high_byte = division_factor = 0;
      
  for (channel = 0; channel < 3; channel++)
    {
      max = 0;

      switch (channel) {
      case 0:
	{
	  for (i = 0; i < 65535; i++)
	    {

	      outp(0x43, 0x00);		// push CLC command for 0 channel to controll register 
	      low_byte = inp(0x40);		// read lower byte
	      high_byte = inp(0x40);	// read higher byte
	      division_factor = high_byte*256 + low_byte;
	      if (division_factor > max)
		max = division_factor;
	    }
	  
	  printf("Division factor for the first channel: %#0x\n", max);
	  break;
	}
      case 1:
	{
	  for (i = 0; i < 65535; i++)
	    {

	      outp(0x43, 0x40);	
	      low_byte = inp(0x41);
	      high_byte = inp(0x41);
	      division_factor = high_byte*256 + low_byte;
	      if (division_factor > max)
		max = division_factor;
	    }
	  
	  printf("Division factor for the second channel: %#0x\n", max);
	  break;
	}
      
      case 2:
	{
	  for (i = 0; i < 65535; i++)
	    {
	      outp(0x43, 0x80);	
	      low_byte = inp(0x42);
  	      high_byte = inp(0x42);	
	      division_factor = high_byte*256 + low_byte;
	      if (division_factor > max)
		max = division_factor;
	    }
	  
	  printf("Division factor for the third channel: %#0x\n", max);
	  break;
	}
      }
    }
  
  return;
}

unsigned int rnd(unsigned int range)
{
  unsigned int result, low, high;

  outp(0x43, 0xB4);
  outp(0x42, range % 256);
  range /= 256;
  outp(0x42,range);
  
  outp(0x61, inp(0x61) | 1); 	// enable channel without speaker
  
  getch();
  
  outp(0x43, 0x86);
  low = inp(0x42);
  high = inp(0x42);
  result = high * 256 + low;
  
  outp(0x61, inp(0x61) & 0xFC);	// disable channel and speaker
  
  return result;
}
