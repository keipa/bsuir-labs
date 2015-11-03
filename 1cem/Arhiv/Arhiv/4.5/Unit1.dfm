object Form1: TForm1
  Left = 192
  Top = 114
  Width = 624
  Height = 500
  Caption = '"'#1084#1072#1089#1089#1080#1074#1099'" '#1075#1088'. 712502 '#1042#1072#1089#1080#1083#1077#1094
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
    Left = 32
    Top = 16
    Width = 177
    Height = 24
    Caption = #1055#1086#1088#1103#1076#1086#1082' '#1084#1072#1090#1088#1080#1094#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 32
    Top = 56
    Width = 81
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object StringGrid1: TStringGrid
    Left = 40
    Top = 168
    Width = 320
    Height = 120
    ColCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 320
    Top = 368
    Width = 113
    Height = 41
    TabOrder = 2
    Kind = bkClose
  end
  object Button1: TButton
    Left = 272
    Top = 96
    Width = 281
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1088#1103#1076#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 128
    Top = 368
    Width = 113
    Height = 41
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 168
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 184
    Top = 328
    Width = 121
    Height = 21
    TabOrder = 6
  end
end
