#include <dos.h>
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct VIDEO
{
  unsigned char symb;
  unsigned char attr;
};

unsigned char new_color();
void change_color();
unsigned char color = 0;
void print(int value, int offset, char* msg);
void get_register();     


/* standart master interruptions */
void interrupt (*std_int8)(...);
void interrupt (*std_int9)(...);
void interrupt (*std_int10)(...);
void interrupt (*std_int11)(...);
void interrupt (*std_int12)(...);
void interrupt (*std_int13)(...);
void interrupt (*std_int14)(...);
void interrupt (*std_int15)(...);

/* standart slave interruptions */
void interrupt (*std_int70)(...);
void interrupt (*std_int71)(...);
void interrupt (*std_int72)(...);
void interrupt (*std_int73)(...);
void interrupt (*std_int74)(...);
void interrupt (*std_int75)(...);
void interrupt (*std_int76)(...);
void interrupt (*std_int77)(...);

void interrupt new_int8(...)
{
  get_register();
  (*std_int8)();
}

void interrupt new_int9(...)
{
  get_register();	
  change_color();
  (*std_int9)();
}

/* new master interruptions */
void interrupt new_int10(...) { (*std_int10)(); }
void interrupt new_int11(...) { (*std_int11)(); }
void interrupt new_int12(...) { (*std_int12)(); }
void interrupt new_int13(...) { (*std_int13)(); }
void interrupt new_int14(...) { (*std_int14)(); }
void interrupt new_int15(...) { (*std_int15)(); }

/* new slave interruptions*/
void interrupt new_int70(...) { (*std_int70)(); }
void interrupt new_int71(...) { (*std_int71)(); }
void interrupt new_int72(...) { (*std_int72)(); }
void interrupt new_int73(...) { (*std_int73)(); }
void interrupt new_int74(...) { (*std_int74)(); }
void interrupt new_int75(...) { (*std_int75)(); }
void interrupt new_int76(...) { (*std_int76)(); }
void interrupt new_int77(...) { (*std_int77)(); }

/* clear screen before output */
void clear_screen()
{
  int i;
  VIDEO far* scr_beg = (VIDEO far *)MK_FP(0xB800, 0);
  for (i = 0; i < 25 * 80; ++i)
    {
      scr_beg[i].symb = 0;
      scr_beg[i].attr = color;
    }
}
/* change screen color */
void change_color()
{
  int i;
  VIDEO far* scr_beg = (VIDEO far *)MK_FP(0xB800, 0);
  for (i = 0; i < 25 * 80; ++i)
    scr_beg[i].attr = color;
}
/* change color constant  */ 
unsigned char new_color()
{
  srand(time(NULL));
  return rand()%255 & 0x7F;
}

/* initialize interruption vectors */ 
void init()
{
  /* save standart master IRQ vectors */
  std_int8 = getvect(0x08);
  std_int9 = getvect(0x09);
  std_int10 = getvect(0x0A);
  std_int11 = getvect(0x0B);
  std_int12 = getvect(0x0C);
  std_int13 = getvect(0x0D);
  std_int14 = getvect(0x0E);
  std_int15 = getvect(0x0F);

  /* set new master IRQ interruptions*/
  
  setvect(0x08, new_int8);
  setvect(0x09, new_int9);
  setvect(0x0A, new_int10);
  setvect(0x0B, new_int11);
  setvect(0x0C, new_int12);
  setvect(0x0D, new_int13);
  setvect(0x0E, new_int14);
  setvect(0x0F, new_int15);

  /* save standart slave IRQ vectors*/
  std_int70 = getvect(0x70);
  std_int71 = getvect(0x71);
  std_int72 = getvect(0x72);
  std_int73 = getvect(0x73);
  std_int74 = getvect(0x74);
  std_int75 = getvect(0x75);
  std_int76 = getvect(0x76);
  std_int77 = getvect(0x77);

  /* set new slave IRQ interruptions*/
  setvect(0x90, new_int70);
  setvect(0x91, new_int71);
  setvect(0x92, new_int72);
  setvect(0x93, new_int73);
  setvect(0x94, new_int74);
  setvect(0x95, new_int75);
  setvect(0x96, new_int76);
  setvect(0x97, new_int77);

  /* make operations atomic */ 
  _disable();


  outp(0x20,0x11);		// send ICW1
  outp(0x21,0x08);		// send ICW2
  outp(0x21,0x04);		// send ICW3
  outp(0x21,0x01);		// send ICW4


  outp(0xA0,0x11);		// same above
  outp(0xA1,0x90);
  outp(0xA1,0x02);
  outp(0xA1,0x01);

  _enable();
}

/* print register's values */
void print(int value, int offset,  char* msg)
{
  char temp;
  int i;
  VIDEO far* screen = (VIDEO far *)MK_FP(0xB800, 0);
  screen += offset; 		// offset from the beginning of the screen 
  for(i = 0;i <= 3;i++)        
    {
      screen->symb = msg[i];
      screen++;
    }
  
  screen->symb=':';
  screen++;

  for(i = 7;i >= 0;i--)       
    {
      temp = value % 2;
      value /= 2;         
      screen->symb = temp + '0';
      screen++;
    }
}
/* get register values from ports */
void get_register()
{
  color = new_color();		// update color

  outp(0x20, 0x0B);
  print(inp(0x20),0,"ISR1");
  
  outp(0x20, 0x0A);
  print(inp(0x20),20,"IRR1");
  print(inp(0x21),40,"IMR1");

  outp(0xA0, 0x0B);
  print(inp(0xA0),80,"ISR2");
  
  outp(0xA0, 0x0A);
  print(inp(0xA0),100,"IRR2");
  print(inp(0xA1),120,"IMR2");
}

int main()
{
  unsigned far *fp;
  clear_screen();
  init();
  FP_SEG (fp) = _psp;
  FP_OFF (fp) = 0x2c;
  _dos_freemem(*fp);
  _dos_keep(0,(_DS - _CS) + (_SP / 16) + 1);
  return 0;
}




