//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
        int A [8] = {0,0,0,0,0,0,0,0};
        int B [8] = {0,0,0,0,0,0,0,0};
        int C [8] = {0,0,0,0,0,0,0,0};
        int D [8] = {0,0,0,0,0,0,0,0};
        
        Edit1->Text = StrToInt(rand()%10+1);
        A[0] = StrToInt(Edit1->Text);
        A[1] = StrToInt(Edit1->Text);
        A[2] = StrToInt(Edit1->Text);
        A[3] = StrToInt(Edit1->Text);

        A[4] = StrToInt(Edit1->Text);
        A[5] = StrToInt(Edit1->Text);
        A[6] = StrToInt(Edit1->Text);
        A[7] = StrToInt(Edit1->Text);


        B[0] = StrToInt(Edit1->Text);
        B[1] = StrToInt(Edit1->Text);
        B[2] = StrToInt(Edit1->Text);
        B[3] = StrToInt(Edit1->Text);

        B[4] = StrToInt(Edit1->Text);
        B[5] = StrToInt(Edit1->Text);
        B[6] = StrToInt(Edit1->Text);
        B[7] = StrToInt(Edit1->Text);


        C[0] = StrToInt(Edit1->Text);
        C[1] = StrToInt(Edit1->Text);
        C[2] = StrToInt(Edit1->Text);
        C[3] = StrToInt(Edit1->Text);

        C[4] = StrToInt(Edit1->Text);
        C[5] = StrToInt(Edit1->Text);
        C[6] = StrToInt(Edit1->Text);
        C[7] = StrToInt(Edit1->Text);


        D[0] = StrToInt(Edit1->Text);
        D[1] = StrToInt(Edit1->Text);
        D[2] = StrToInt(Edit1->Text);
        D[3] = StrToInt(Edit1->Text);

        D[4] = StrToInt(Edit1->Text);
        D[5] = StrToInt(Edit1->Text);
        D[6] = StrToInt(Edit1->Text);
        D[7] = StrToInt(Edit1->Text);

  __int64 m64_1 = 0x0a0d0b0c12ef093c;
  __int64 m64_2 = 0x1f05db0c93eee9a0;
  __int64 m64_3 = 0x0000000000000000;

  __asm
  {
    movq    mm0, m64_1
    paddd  mm0, m64_2
    movq    m64_3, mm0
  }
  Memo1->Text = "assemble";
}

//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
        Edit1->Text = StrToInt(rand()%10+1);
        Edit2->Text = StrToInt(rand()%10+1);
        Edit3->Text = StrToInt(rand()%10+1);
        Edit4->Text = StrToInt(rand()%10+1);
        Edit5->Text = StrToInt(rand()%10+1);
        Edit6->Text = StrToInt(rand()%10+1);
        Edit7->Text = StrToInt(rand()%10+1);
        Edit8->Text = StrToInt(rand()%10+1);
        Edit9->Text = StrToInt(rand()%10+1);
        Edit10->Text = StrToInt(rand()%10+1);
        Edit11->Text = StrToInt(rand()%10+1);
        Edit12->Text = StrToInt(rand()%10+1);
        Edit13->Text = StrToInt(rand()%10+1);
        Edit14->Text = StrToInt(rand()%10+1);
        Edit15->Text = StrToInt(rand()%10+1);
        Edit16->Text = StrToInt(rand()%10+1);
        Edit17->Text = StrToInt(rand()%10+1);
        Edit18->Text = StrToInt(rand()%10+1);
        Edit19->Text = StrToInt(rand()%10+1);
        Edit20->Text = StrToInt(rand()%10+1);
        Edit21->Text = StrToInt(rand()%10+1);
        Edit22->Text = StrToInt(rand()%10+1);
        Edit23->Text = StrToInt(rand()%10+1);
        Edit24->Text = StrToInt(rand()%10+1);
        Edit25->Text = StrToInt(rand()%10+1);
        Edit26->Text = StrToInt(rand()%10+1);
        Edit27->Text = StrToInt(rand()%10+1);
        Edit28->Text = StrToInt(rand()%10+1);
        Edit29->Text = StrToInt(rand()%10+1);
        Edit30->Text = StrToInt(rand()%10+1);
        Edit31->Text = StrToInt(rand()%10+1);
        Edit32->Text = StrToInt(rand()%10+1);


}
//---------------------------------------------------------------------------


void __fastcall TForm1::Button3Click(TObject *Sender)
{
        Edit1->Clear();
        Edit2->Clear();
        Edit3->Clear();
        Edit4->Clear();
        Edit5->Clear();
        Edit6->Clear();
        Edit7->Clear();
        Edit8->Clear();
        Edit9->Clear();
        Edit10->Clear();
        Edit11->Clear();
        Edit12->Clear();
        Edit13->Clear();
        Edit14->Clear();
        Edit15->Clear();
        Edit16->Clear();
        Edit17->Clear();
        Edit18->Clear();
        Edit19->Clear();
        Edit20->Clear();
        Edit21->Clear();
        Edit22->Clear();
        Edit23->Clear();
        Edit24->Clear();
        Edit25->Clear();
        Edit26->Clear();
        Edit27->Clear();
        Edit28->Clear();
        Edit29->Clear();
        Edit30->Clear();
        Edit31->Clear();
        Edit32->Clear();
}
//---------------------------------------------------------------------------
