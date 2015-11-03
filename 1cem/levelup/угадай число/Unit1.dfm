object Form1: TForm1
  Left = 192
  Top = 117
  Width = 230
  Height = 421
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 185
    Height = 41
    Caption = 'Programma zagadivaet chislo'
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 16
    Top = 64
    Width = 185
    Height = 41
    Caption = 'zadacha polzovatelya - otgagat ego'
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 24
    Top = 176
    Width = 73
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object Memo1: TMemo
    Left = 8
    Top = 216
    Width = 201
    Height = 121
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object Button1: TButton
    Left = 120
    Top = 176
    Width = 91
    Height = 25
    Caption = 'TRY IF YOU CAN'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 72
    Top = 128
    Width = 75
    Height = 25
    Caption = 'New Number'
    TabOrder = 5
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 72
    Top = 352
    Width = 97
    Height = 25
    Caption = 'i'#39'm not vanga'
    TabOrder = 6
    Kind = bkClose
  end
end
