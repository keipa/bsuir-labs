object Form1: TForm1
  Left = 652
  Top = 155
  Width = 258
  Height = 362
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
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 19
    Height = 13
    Caption = 'Xn='
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 19
    Height = 13
    Caption = 'Xk='
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 21
    Height = 13
    Caption = '  M='
  end
  object Label4: TLabel
    Left = 8
    Top = 88
    Width = 18
    Height = 13
    Caption = '  e='
  end
  object Edit1: TEdit
    Left = 32
    Top = 16
    Width = 57
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 32
    Top = 40
    Width = 57
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 32
    Top = 64
    Width = 57
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 32
    Top = 88
    Width = 57
    Height = 21
    TabOrder = 3
    Text = 'Edit4'
  end
  object RadioGroup1: TRadioGroup
    Left = 104
    Top = 8
    Width = 129
    Height = 105
    Caption = #1060#1091#1085#1082#1094#1080#1103
    Items.Strings = (
      'S(x)'
      'Y(x)')
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 8
    Top = 120
    Width = 225
    Height = 153
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 280
    Width = 153
    Height = 25
    Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 6
    OnClick = BitBtn1Click
    Kind = bkYes
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 280
    Width = 65
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
end
