object Form1: TForm1
  Left = 352
  Top = 196
  Width = 175
  Height = 534
  Caption = #1056#1086#1074#1076#1088#1086' '#1053#1080#1082#1086#1083#1072#1081' 453504'
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
  object lbl1: TLabel
    Left = 8
    Top = 232
    Width = 56
    Height = 13
    Caption = 'Result first:'
  end
  object lbl2: TLabel
    Left = 8
    Top = 264
    Width = 71
    Height = 13
    Caption = 'Result second:'
  end
  object strngrd1: TStringGrid
    Left = 8
    Top = 8
    Width = 137
    Height = 161
    ColCount = 2
    RowCount = 6
    TabOrder = 0
  end
  object edt1: TEdit
    Left = 8
    Top = 176
    Width = 137
    Height = 21
    TabOrder = 1
  end
  object edt2: TEdit
    Left = 8
    Top = 200
    Width = 137
    Height = 21
    TabOrder = 2
  end
  object edt3: TEdit
    Left = 72
    Top = 232
    Width = 73
    Height = 21
    TabOrder = 3
  end
  object btn1: TBitBtn
    Left = 8
    Top = 296
    Width = 145
    Height = 33
    Caption = 'Polish form'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btn1Click
    Kind = bkYes
  end
  object btn2: TBitBtn
    Left = 8
    Top = 328
    Width = 145
    Height = 33
    Caption = 'Calculate st'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btn2Click
    Kind = bkYes
  end
  object btn3: TBitBtn
    Left = 8
    Top = 400
    Width = 145
    Height = 57
    Caption = 'Clear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btn3Click
    Kind = bkAbort
  end
  object btn4: TBitBtn
    Left = 8
    Top = 456
    Width = 145
    Height = 25
    TabOrder = 7
    Kind = bkClose
  end
  object edt4: TEdit
    Left = 88
    Top = 264
    Width = 57
    Height = 21
    TabOrder = 8
  end
  object btn5: TBitBtn
    Left = 8
    Top = 360
    Width = 145
    Height = 41
    Caption = 'Calculate pol'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btn5Click
    Kind = bkYes
  end
end
