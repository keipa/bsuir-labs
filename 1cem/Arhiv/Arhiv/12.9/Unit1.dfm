object Form1: TForm1
  Left = 221
  Top = 164
  Width = 424
  Height = 275
  Caption = #1051#1072#1073'.'#1088#1072#1073'.'#8470'12 '#1042#1072#1088#1080#1072#1085#1090' 9'
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
    Width = 150
    Height = 13
    Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1089#1090#1077#1082' '#1076#1083#1080#1085#1085#1086#1081':'
  end
  object Label2: TLabel
    Left = 24
    Top = 80
    Width = 101
    Height = 13
    Caption = #1063#1086#1090#1072#1090#1072#1090#1072#1084#1085#1072#1081#1090#1080#1074#1086#1090
  end
  object Label3: TLabel
    Left = 296
    Top = 24
    Width = 44
    Height = 13
    Caption = #1069#1083#1077#1084#1077#1085#1090
  end
  object Label4: TLabel
    Left = 32
    Top = 160
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Edit1: TEdit
    Left = 24
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 24
    Top = 112
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 176
    Top = 16
    Width = 65
    Height = 169
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 264
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Button2: TButton
    Left = 288
    Top = 80
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 288
    Top = 120
    Width = 75
    Height = 25
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 288
    Top = 160
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 6
    OnClick = Button4Click
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 200
    Width = 75
    Height = 25
    TabOrder = 7
    OnClick = BitBtn1Click
    Kind = bkClose
  end
end
