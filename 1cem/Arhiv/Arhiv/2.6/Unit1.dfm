object Form1: TForm1
  Left = 68
  Top = 142
  Width = 419
  Height = 465
  Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1085#1072#1103' '#1088#1072#1073#1086#1090#1072' #2 '#1044#1072#1085#1080#1083#1082#1080#1085#1072' '#1040#1088#1090#1091#1088#1072
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
    Top = 16
    Width = 19
    Height = 20
    Caption = 'x='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 21
    Height = 20
    Caption = 'b='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 112
    Width = 209
    Height = 20
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 40
    Top = 16
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 40
    Top = 64
    Width = 145
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Memo1: TMemo
    Left = 16
    Top = 144
    Width = 377
    Height = 201
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Button1: TButton
    Left = 16
    Top = 368
    Width = 129
    Height = 41
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 304
    Top = 368
    Width = 89
    Height = 41
    TabOrder = 4
    Kind = bkClose
  end
  object RadioGroup1: TRadioGroup
    Left = 208
    Top = 8
    Width = 185
    Height = 105
    Caption = 'F(X)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'sh(x)'
      'x^2'
      'e^x')
    ParentFont = False
    TabOrder = 5
  end
end
