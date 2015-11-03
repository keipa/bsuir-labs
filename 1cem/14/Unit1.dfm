object Form1: TForm1
  Left = 567
  Top = 145
  Width = 392
  Height = 330
  Caption = #1051#1072#1073'. '#1088#1072#1073'. 14; 152003 - '#1063#1077#1088#1085#1103#1074#1089#1082#1080#1081' '#1069'.'#1040'.'
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
    Top = 8
    Width = 95
    Height = 13
    Caption = #1055#1091#1085#1082#1090' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103':'
  end
  object Label2: TLabel
    Left = 24
    Top = 32
    Width = 74
    Height = 13
    Caption = #1058#1080#1087' '#1089#1072#1084#1086#1083#1105#1090#1072':'
  end
  object Label3: TLabel
    Left = 24
    Top = 56
    Width = 70
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1088#1077#1081#1089#1072':'
  end
  object Label4: TLabel
    Left = 24
    Top = 80
    Width = 76
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1074#1099#1083#1077#1090#1072':'
  end
  object Edit1: TEdit
    Left = 104
    Top = 8
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 104
    Top = 32
    Width = 145
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 104
    Top = 56
    Width = 145
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 104
    Top = 80
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'Edit4'
  end
  object BitBtn1: TBitBtn
    Left = 160
    Top = 80
    Width = 89
    Height = 25
    Caption = '&Add'
    TabOrder = 4
    OnClick = BitBtn1Click
    Kind = bkIgnore
  end
  object Memo1: TMemo
    Left = 16
    Top = 112
    Width = 233
    Height = 137
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object Button1: TButton
    Left = 16
    Top = 256
    Width = 75
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1041#1044
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 256
    Width = 75
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1041#1044
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 176
    Top = 256
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1041#1044
    TabOrder = 8
    OnClick = Button3Click
  end
  object BitBtn3: TBitBtn
    Left = 256
    Top = 8
    Width = 113
    Height = 25
    Caption = '&'#1055#1086#1080#1089#1082
    TabOrder = 9
    OnClick = BitBtn3Click
    Kind = bkHelp
  end
  object BitBtn4: TBitBtn
    Left = 256
    Top = 40
    Width = 113
    Height = 25
    Caption = '&'#1055#1088#1103#1084#1086#1081' '#1074#1099#1073#1086#1088
    TabOrder = 10
    OnClick = BitBtn4Click
    Kind = bkRetry
  end
  object BitBtn2: TBitBtn
    Left = 256
    Top = 72
    Width = 113
    Height = 25
    Caption = '&QuickSort'
    TabOrder = 11
    OnClick = BitBtn2Click
    Kind = bkRetry
  end
  object BitBtn5: TBitBtn
    Left = 256
    Top = 104
    Width = 113
    Height = 25
    Caption = '&'#1044#1074#1086#1080#1095#1085#1099#1081' '#1087#1086#1080#1089#1082
    TabOrder = 12
    OnClick = BitBtn5Click
    Kind = bkHelp
  end
  object BitBtn6: TBitBtn
    Left = 256
    Top = 136
    Width = 113
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' 1 '#1087#1091#1085#1082#1090
    TabOrder = 13
    OnClick = BitBtn6Click
    Kind = bkAbort
  end
  object BitBtn7: TBitBtn
    Left = 256
    Top = 256
    Width = 113
    Height = 25
    TabOrder = 14
    Kind = bkClose
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093'|*.dat'
    Left = 296
    Top = 168
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'|*.txt'
    Left = 264
    Top = 168
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093'|*.dat'
    Left = 328
    Top = 168
  end
end
