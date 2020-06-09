object Form1: TForm1
  Left = 248
  Top = 221
  Width = 593
  Height = 479
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
  object img1: TImage
    Left = 32
    Top = 40
    Width = 521
    Height = 249
  end
  object btn1: TButton
    Left = 256
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Graph'
    TabOrder = 0
    OnClick = btn1Click
  end
  object edt1: TEdit
    Left = 376
    Top = 312
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object edt2: TEdit
    Left = 376
    Top = 344
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object edt3: TEdit
    Left = 376
    Top = 376
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '10'
  end
  object edt4: TEdit
    Left = 376
    Top = 408
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '5'
  end
  object mmo1: TMemo
    Left = 48
    Top = 296
    Width = 153
    Height = 129
    Lines.Strings = (
      'mmo1')
    TabOrder = 5
  end
end
