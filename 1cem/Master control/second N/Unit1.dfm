object Form1: TForm1
  Left = 243
  Top = 250
  Width = 399
  Height = 259
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 48
    Top = 32
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object lbl2: TLabel
    Left = 56
    Top = 64
    Width = 30
    Height = 17
    Caption = 'b'
  end
  object Label1: TLabel
    Left = 64
    Top = 104
    Width = 22
    Height = 13
    Caption = 'n'
  end
  object Label2: TLabel
    Left = 72
    Top = 136
    Width = 8
    Height = 13
    Caption = 'm'
  end
  object edt1: TEdit
    Left = 88
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edt2: TEdit
    Left = 88
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '10'
  end
  object edt3: TEdit
    Left = 96
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object edt4: TEdit
    Left = 104
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '5'
  end
  object Button1: TButton
    Left = 120
    Top = 192
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 4
    OnClick = Button1Click
  end
  object btn1: TBitBtn
    Left = 272
    Top = 192
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkClose
  end
  object SaveDialog1: TSaveDialog
    Filter = 'text file|*.txt'
    Left = 224
    Top = 176
  end
end
