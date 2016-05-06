object Form1: TForm1
  Left = 257
  Top = 125
  Width = 777
  Height = 519
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
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 746
    Height = 393
  end
  object Button1: TButton
    Left = 314
    Top = 408
    Width = 130
    Height = 41
    Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 591
    Top = 408
    Width = 154
    Height = 55
    Caption = #1045#1061#1040#1058#1068' '#1042#1055#1045#1056#1025#1044
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button5: TButton
    Left = 15
    Top = 408
    Width = 154
    Height = 55
    Caption = #1045#1061#1040#1058#1068' '#1053#1040#1047#1040#1044
    TabOrder = 2
    OnClick = Button5Click
  end
  object BitBtn1: TBitBtn
    Left = 322
    Top = 454
    Width = 116
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100'  '
    TabOrder = 3
    OnClick = BitBtn1Click
    Kind = bkClose
  end
  object Button3: TButton
    Left = 184
    Top = 408
    Width = 113
    Height = 57
    Caption = #1057#1058#1054#1055'!'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Timer: TTimer
    Enabled = False
    Interval = 40
    OnTimer = TimerTimer
    Left = 40
    Top = 24
  end
end
