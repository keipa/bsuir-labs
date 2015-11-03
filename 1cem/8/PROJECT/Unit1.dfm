object Form1: TForm1
  Left = 699
  Top = 75
  Width = 265
  Height = 462
  Caption = #1051#1072#1073'. '#1056#1072#1073#1086#1090#1072' '#8470'8; '#1042#1072#1088'. 12; '#1063#1077#1088#1085#1103#1074#1089#1082#1080#1081' - 152003'
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
    Left = 40
    Top = 8
    Width = 69
    Height = 13
    Caption = #1044#1077#1085#1100' '#1085#1077#1076#1077#1083#1080':'
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 95
    Height = 13
    Caption = #1055#1091#1085#1082#1090' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103':'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 104
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1080#1103':'
  end
  object Label4: TLabel
    Left = 48
    Top = 80
    Width = 65
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1084#1077#1089#1090':'
  end
  object Label5: TLabel
    Left = 8
    Top = 240
    Width = 234
    Height = 13
    Caption = 
      '----------------------------------------------------------------' +
      '--------------'
  end
  object Label6: TLabel
    Left = 8
    Top = 256
    Width = 128
    Height = 13
    Caption = #1055#1072#1085#1077#1083#1100' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072':'
  end
  object Edit1: TEdit
    Left = 120
    Top = 8
    Width = 33
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 120
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 120
    Top = 56
    Width = 73
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 120
    Top = 80
    Width = 33
    Height = 21
    TabOrder = 3
    Text = 'Edit4'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 104
    Width = 233
    Height = 25
    TabOrder = 4
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 208
    Width = 233
    Height = 25
    TabOrder = 5
    OnClick = BitBtn2Click
    Kind = bkClose
  end
  object Memo1: TMemo
    Left = 8
    Top = 136
    Width = 233
    Height = 65
    Lines.Strings = (
      'Memo1')
    TabOrder = 6
  end
  object Button2: TButton
    Left = 168
    Top = 272
    Width = 73
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 7
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 304
    Width = 233
    Height = 113
    Lines.Strings = (
      'Memo2')
    TabOrder = 8
  end
  object Button3: TButton
    Left = 160
    Top = 80
    Width = 81
    Height = 17
    Caption = #1042#1085#1077#1089#1090#1080' '#1074' '#1041#1044
    TabOrder = 9
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 272
    Width = 73
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100
    TabOrder = 10
    OnClick = Button4Click
  end
  object Button1: TButton
    Left = 88
    Top = 272
    Width = 73
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 11
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.dat'
    Left = 160
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.dat'
    Left = 192
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.txt'
    Filter = '*.txt|'#1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083
    Left = 200
    Top = 56
  end
end
