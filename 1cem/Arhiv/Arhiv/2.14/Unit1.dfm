object Form1: TForm1
  Left = 202
  Top = 128
  Width = 593
  Height = 367
  Caption = #1083#1072#1073'.'#1088#1072#1073'2 810202 '#1064#1077#1084#1086#1085#1072#1077#1074' '#1054#1083#1077#1075
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
    Left = 0
    Top = 0
    Width = 25
    Height = 29
    Caption = 'x='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 152
    Top = 0
    Width = 20
    Height = 24
    Caption = 'y='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 312
    Top = 0
    Width = 20
    Height = 24
    Caption = 'z='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 56
    Width = 297
    Height = 20
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 0
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 152
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 312
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object Button1: TButton
    Left = 208
    Top = 296
    Width = 129
    Height = 33
    Caption = #1074#1099#1087#1086#1083#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 80
    Width = 281
    Height = 185
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object RadioGroup1: TRadioGroup
    Left = 448
    Top = 96
    Width = 137
    Height = 241
    Caption = 'F(X)'
    Items.Strings = (
      'sh(X)'
      'x '#1074' '#1082#1074#1072#1076#1088#1072#1090#1077
      #1101#1082#1089#1087#1072#1085#1077#1085#1090#1072' x')
    TabOrder = 5
  end
  object CheckBox1: TCheckBox
    Left = 456
    Top = 24
    Width = 113
    Height = 33
    Caption = #1086#1082#1088#1091#1075#1083#1103#1090#1100
    TabOrder = 6
  end
end
