object Form1: TForm1
  Left = 211
  Top = 131
  Width = 425
  Height = 209
  Caption = #1051#1072#1073'. '#1056#1072#1073'. '#8470'11; 152003; '#1063#1077#1088#1085#1103#1074#1089#1082#1080#1081' '#1069'. '#1040'.'
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
    Left = 16
    Top = 112
    Width = 12
    Height = 13
    Caption = 'n='
  end
  object Label2: TLabel
    Left = 16
    Top = 136
    Width = 55
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 393
    Height = 97
    Caption = #1050#1072#1082' '#1085#1072#1093#1086#1076#1080#1084' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1086#1089#1083#1077#1076#1086#1074#1072#1090#1077#1083#1100#1085#1086#1089#1090#1080'?'
    Items.Strings = (
      #1056#1077#1082#1091#1088#1089#1080#1103
      #1056#1077#1082#1091#1088#1077#1085#1090#1085#1086#1077' '#1074#1099#1088#1072#1078#1077#1085#1080#1077)
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 32
    Top = 112
    Width = 49
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 80
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 88
    Top = 112
    Width = 313
    Height = 17
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 208
    Top = 136
    Width = 193
    Height = 25
    TabOrder = 4
    Kind = bkClose
  end
end
