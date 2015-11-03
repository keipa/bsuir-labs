object Form1: TForm1
  Left = 424
  Top = 112
  Width = 343
  Height = 294
  Caption = #1051#1072#1073'.'#1088#1072#1073'.'#8470'7 '#1075#1088'.712502 '#1057#1077#1074#1077#1088#1080#1085' '#1040'.'#1057'.'
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
    Top = 64
    Width = 174
    Height = 13
    Caption = #1057#1083#1086#1074#1072' '#1084#1080#1085#1080#1084#1072#1083#1100#1085#1086#1081' '#1076#1083#1080#1085#1085#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 75
    Height = 13
    Caption = #1042#1074#1086#1076' '#1089#1090#1088#1086#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 16
    Top = 88
    Width = 305
    Height = 113
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 305
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
    OnKeyPress = Edit1KeyPress
  end
  object BitBtn1: TBitBtn
    Left = 240
    Top = 216
    Width = 75
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Kind = bkClose
  end
end
