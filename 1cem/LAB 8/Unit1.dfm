object Form1: TForm1
  Left = 264
  Top = 149
  Width = 458
  Height = 394
  Caption = 'Lab 8 271014 Rovdo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 32
    Top = 56
    Width = 18
    Height = 17
    Caption = 'S.N'
  end
  object Label3: TLabel
    Left = 16
    Top = 88
    Width = 38
    Height = 13
    Caption = 'Address'
  end
  object Label4: TLabel
    Left = 16
    Top = 120
    Width = 62
    Height = 13
    Caption = 'Delivery date'
  end
  object Edit2: TEdit
    Left = 64
    Top = 56
    Width = 369
    Height = 21
    TabOrder = 0
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 64
    Top = 88
    Width = 369
    Height = 21
    TabOrder = 1
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 88
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit4'
  end
  object Memo1: TMemo
    Left = 16
    Top = 152
    Width = 417
    Height = 161
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object Button1: TButton
    Left = 232
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Make an entry'
    TabOrder = 4
  end
  object Button2: TButton
    Left = 320
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Sort'
    TabOrder = 5
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.dat'
    Filter = 'Data file |*.dat|all files|*.*'
    Left = 8
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'data file|*.txt|all files|*.*'
    Left = 40
    Top = 8
  end
end
