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
        try{
        A[0] = StrToInt(Edit1->Text);
        A[1] = StrToInt(Edit2->Text);
        A[2] = StrToInt(Edit3->Text);
        A[3] = StrToInt(Edit4->Text);

        A[4] = StrToInt(Edit5->Text);
        A[5] = StrToInt(Edit6->Text);
        A[6] = StrToInt(Edit7->Text);
        A[7] = StrToInt(Edit8->Text);


        B[0] = StrToInt(Edit9->Text);
        B[1] = StrToInt(Edit10->Text);
        B[2] = StrToInt(Edit11->Text);
        B[3] = StrToInt(Edit12->Text);

        B[4] = StrToInt(Edit13->Text);
        B[5] = StrToInt(Edit14->Text);
        B[6] = StrToInt(Edit15->Text);
        B[7] = StrToInt(Edit16->Text);


        C[0] = StrToInt(Edit17->Text);
        C[1] = StrToInt(Edit18->Text);
        C[2] = StrToInt(Edit19->Text);
        C[3] = StrToInt(Edit20->Text);

        C[4] = StrToInt(Edit21->Text);
        C[5] = StrToInt(Edit22->Text);
        C[6] = StrToInt(Edit23->Text);
        C[7] = StrToInt(Edit24->Text);


        D[0] = StrToInt(Edit25->Text);
        D[1] = StrToInt(Edit26->Text);
        D[2] = StrToInt(Edit27->Text);
        D[3] = StrToInt(Edit28->Text);

        D[4] = StrToInt(Edit29->Text);
        D[5] = StrToInt(Edit30->Text);
        D[6] = StrToInt(Edit31->Text);
        D[7] = StrToInt(Edit32->Text);
        }
        catch(Exception *ex)
        {
        Memo1->Lines->Add("type NUMBERS");
        return;
        }

  __int8 m64_a0 = A[0];
  __int8 m64_a1 = A[1];
  __int8 m64_a2 = A[2];
  __int8 m64_a3 = A[3];

  __int8 m64_a4 = A[4];
  __int8 m64_a5 = A[5];
  __int8 m64_a6 = A[6];
  __int8 m64_a7 = A[7];

  __int8 m64_b0 = B[0];
  __int8 m64_b1 = B[1];
  __int8 m64_b2 = B[2];
  __int8 m64_b3 = B[3];

  __int8 m64_b4 = B[4];
  __int8 m64_b5 = B[5];
  __int8 m64_b6 = B[6];
  __int8 m64_b7 = B[7];

  __int8 m64_c0 = C[0];
  __int8 m64_c1 = C[1];
  __int8 m64_c2 = C[2];
  __int8 m64_c3 = C[3];

  __int8 m64_c4 = C[4];
  __int8 m64_c5 = C[5];
  __int8 m64_c6 = C[6];
  __int8 m64_c7 = C[7];

  for(int i = 0; i<7;i++){
        if (A[i]<-128 || A[i]>127){
                Memo1->Lines->Add("A["+IntToStr(i+1)+ "] is out of range");
                return;   }
         if (B[i]<-128 || B[i]>127){
                Memo1->Lines->Add( "B["+IntToStr(i+1)+ "] is out of range");
                return;    }
          if (C[i]<-128 || C[i]>127){
                Memo1->Lines->Add("C["+IntToStr(i+1)+ "] is out of range");
                return;   }
          if (D[i]<-16384 || D[i]>16256){
                Memo1->Lines->Add("D ["+IntToStr(i+1)+ "] is out of range");
                return;

  }
  }
  __int16 m64_d0 = D[0];
  __int16 m64_d1 = D[1];
  __int16 m64_d2 = D[2];
  __int16 m64_d3 = D[3];

  __int16 m64_d4 = D[4];
  __int16 m64_d5 = D[5];
  __int16 m64_d6 = D[6];
  __int16 m64_d7 = D[7];

  //d = -16384/16256   abc = -128/127
  __int8 masa[8] = {m64_a0, m64_a1, m64_a2, m64_a3, m64_a4, m64_a5, m64_a6, m64_a7};
  __int8 masb[8] = {m64_b0,m64_b1,m64_b2,m64_b3,m64_b4,m64_b5,m64_b6,m64_b7};
  __int8 masc[8] = {m64_c0,m64_c1,m64_c2,m64_c3,m64_c4,m64_c5,m64_c6,m64_c7};
  __int16 masd[8] = {m64_d0,m64_d1,m64_d2,m64_d3,m64_d4,m64_d5,m64_d6,m64_d7};
  __int16 masr[8] = {0,0,0,0,0,0,0,0};
  // __int16 masaw[8] = {0,0,0,0,0,0,0,0};
  // __int16 masbw[8] = {0,0,0,0,0,0,0,0};
  // __int16 mascw[8] = {0,0,0,0,0,0,0,0};
__asm
{
        //b conversion
    lea esi, masb
    movq mm0, [esi]
    movq mm1, [esi]
    pcmpgtb mm7,mm0
    punpcklbw mm0, mm7
    // pcmpgtb mm7,mm1
    punpckhbw mm1, mm7
    // pmullw mm0, [edi]

    //to c array
    // lea eax, masr
    // movq [eax], mm0
    // movq [eax+8], mm1
    pxor mm7,mm7
        //c conversion
    lea edi, masc
    movq mm2, [edi]
    movq mm3, [edi]
    pcmpgtb mm7,mm2
    punpcklbw mm2, mm7
    // pcmpgtb mm7,mm1
    punpckhbw mm3, mm7

    pmullw mm0, mm2   //first part of b*c in lowreg
    pmullw mm1, mm3   // second part of b*c in lowreg


    pxor mm2,mm2
    pxor mm3,mm3
    // to c array
    // lea eax, masr
    // movq [eax], mm2
    // movq [eax+8], mm3
            //a conversion
        lea eax, masa
        movq mm2, [eax]
        movq mm3, [eax]
        pcmpgtb mm7,mm2
        punpcklbw mm2, mm7
        // pcmpgtb mm7,mm1
        punpckhbw mm3, mm7
        // pmullw mm0, [edi]

        psubw mm2,mm0  // mm2 contains fisrt past of a-b*c
        psubw mm3,mm1   //mm3 contains second part of a-b*c

        pxor mm0,mm0
        pxor mm1,mm1
        pxor mm7, mm7
        pxor mm6, mm6
     //   pxor esi, esi
     //   pxor edi, edi

                   //mm2 -> mm5 mm6
        /*     pcmpgtb mm7,mm2
             punpcklwd mm5, mm7   //1/4 a-b*c
             // pcmpgtb mm7,mm1
             punpckhwd mm6, mm7              //2/4 a-b*c     */

        pxor mm7,mm7

        lea ebx, masd
        movq mm0, [ebx] //mm3 mm4
        movq mm1, [ebx+8]

        /*pcmpgtb mm7,mm0
             punpcklwd mm3, mm7        // 1/4 d
             // pcmpgtb mm7,mm1
             punpckhwd mm4, mm7        //2/4 d             */


        psubw mm2,mm0  // mm2 contains fisrt past of a-b*c-d   1/4
        psubw mm3,mm1   //mm3 contains second part of a-b*c-d   2/4
        // to c array

        lea ecx, masr   //saving first part
        movq [ecx], mm2
        movq [ecx+8], mm3


    // movq [esi], mm0
    // mov get, esi
    // paddd mm1, m64_2;
    // movq m64_3, mm1;
    pxor mm0, mm0
    pxor mm1, mm1
    pxor mm2, mm2
    pxor mm3, mm3
    pxor mm4, mm4
    pxor mm5, mm5
    pxor mm6, mm6
    pxor mm7, mm7

    emms
}

Edit33->Text = IntToStr(masr[0]);
Edit34->Text = IntToStr(masr[1]);
Edit35->Text = IntToStr(masr[2]);
Edit36->Text = IntToStr(masr[3]);
Edit37->Text = IntToStr(masr[4]);
Edit38->Text = IntToStr(masr[5]);
Edit39->Text = IntToStr(masr[6]);
Edit40->Text = IntToStr(masr[7]);
Memo1->Text = "assembled";
masr[0] = 0;
masr[1] = 0;
masr[2] = 0;
masr[3] = 0;
masr[4] = 0;
masr[5] = 0;
masr[6] = 0;
masr[7] = 0;
}





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





void __fastcall TForm1::Button4Click(TObject *Sender)
{
        Edit1->Text = StrToInt(rand()%240-120);
        Edit2->Text = StrToInt(rand()%240-120);
        Edit3->Text = StrToInt(rand()%240-120);
        Edit4->Text = StrToInt(rand()%240-120);
        Edit5->Text = StrToInt(rand()%240-120);
        Edit6->Text = StrToInt(rand()%240-120);
        Edit7->Text = StrToInt(rand()%240-120);
        Edit8->Text = StrToInt(rand()%240-120);
        Edit9->Text = StrToInt(rand()%240-120);
        Edit10->Text = StrToInt(rand()%240-120);
        Edit11->Text = StrToInt(rand()%240-120);
        Edit12->Text = StrToInt(rand()%240-120);
        Edit13->Text = StrToInt(rand()%240-120);
        Edit14->Text = StrToInt(rand()%240-120);
        Edit15->Text = StrToInt(rand()%240-120);
        Edit16->Text = StrToInt(rand()%240-120);
        Edit17->Text = StrToInt(rand()%240-120);
        Edit18->Text = StrToInt(rand()%240-120);
        Edit19->Text = StrToInt(rand()%240-120);
        Edit20->Text = StrToInt(rand()%240-120);
        Edit21->Text = StrToInt(rand()%240-120);
        Edit22->Text = StrToInt(rand()%240-120);
        Edit23->Text = StrToInt(rand()%240-120);
        Edit24->Text = StrToInt(rand()%240-120);
        Edit25->Text = StrToInt(rand()%32000-16000);
        Edit26->Text = StrToInt(rand()%32000-16000);
        Edit27->Text = StrToInt(rand()%32000-16000);
        Edit28->Text = StrToInt(rand()%32000-16000);
        Edit29->Text = StrToInt(rand()%32000-16000);
        Edit30->Text = StrToInt(rand()%32000-16000);
        Edit31->Text = StrToInt(rand()%32000-16000);
        Edit32->Text = StrToInt(rand()%32000-16000);
}
//---------------------------------------------------------------------------




