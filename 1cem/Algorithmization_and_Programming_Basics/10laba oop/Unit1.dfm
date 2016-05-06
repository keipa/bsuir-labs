object Form1: TForm1
  Left = 136
  Top = 243
  Width = 491
  Height = 427
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
    Left = 8
    Top = 8
    Width = 465
    Height = 257
  end
  object btn1: TButton
    Left = 208
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Draw'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 208
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Up'
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 208
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Down'
    TabOrder = 2
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 128
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Left'
    TabOrder = 3
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 288
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Right'
    TabOrder = 4
    OnClick = btn5Click
  end
  object btn6: TBitBtn
    Left = 8
    Top = 368
    Width = 465
    Height = 25
    TabOrder = 5
    OnClick = btn6Click
    Kind = bkClose
  end
  object btn7: TButton
    Left = 376
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Increase Size'
    TabOrder = 6
    OnClick = btn7Click
  end
  object btn8: TButton
    Left = 40
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Decrease Size'
    TabOrder = 7
    OnClick = btn8Click
  end
end
