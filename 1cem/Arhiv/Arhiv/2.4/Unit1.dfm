object Form1: TForm1
  Left = 192
  Top = 114
  Width = 522
  Height = 375
  Caption = 'Form1'
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
    Top = 24
    Width = 12
    Height = 24
    Caption = 'x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 11
    Height = 24
    Caption = 'y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 88
    Width = 11
    Height = 24
    Caption = 'z'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 40
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 40
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 40
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object RadioGroup1: TRadioGroup
    Left = 312
    Top = 8
    Width = 185
    Height = 113
    Caption = #1042#1099#1073#1086#1088' '#1092#1091#1085#1082#1094#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'sinh(x)'
      'sqr(x)'
      'exp(x)')
    ParentFont = False
    TabOrder = 3
  end
  object CheckBox1: TCheckBox
    Left = 176
    Top = 48
    Width = 121
    Height = 33
    Caption = #1054#1082#1088#1091#1075#1083#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 16
    Top = 152
    Width = 481
    Height = 105
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object Button1: TButton
    Left = 40
    Top = 280
    Width = 153
    Height = 41
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 6
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 312
    Top = 280
    Width = 161
    Height = 41
    TabOrder = 7
    Kind = bkClose
  end
end
