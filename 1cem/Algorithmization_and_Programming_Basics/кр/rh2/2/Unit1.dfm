object Form1: TForm1
  Left = 285
  Top = 133
  Width = 1088
  Height = 563
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 24
    Width = 21
    Height = 13
    Caption = 'A = '
  end
  object Label2: TLabel
    Left = 64
    Top = 56
    Width = 17
    Height = 13
    Caption = 'B ='
  end
  object Label3: TLabel
    Left = 64
    Top = 88
    Width = 21
    Height = 13
    Caption = 'N = '
  end
  object Label4: TLabel
    Left = 64
    Top = 120
    Width = 19
    Height = 13
    Caption = 'M ='
  end
  object Edit1: TEdit
    Left = 96
    Top = 24
    Width = 97
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 96
    Top = 56
    Width = 97
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 96
    Top = 88
    Width = 97
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 96
    Top = 120
    Width = 105
    Height = 21
    TabOrder = 3
    Text = 'Edit4'
  end
  object Button1: TButton
    Left = 144
    Top = 176
    Width = 153
    Height = 57
    Caption = 'OK'
    TabOrder = 4
    OnClick = Button1Click
  end
  object SaveDiaog1: TSaveDialog
    Left = 56
    Top = 160
  end
end
