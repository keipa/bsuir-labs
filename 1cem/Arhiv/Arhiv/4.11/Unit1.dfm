object Form1: TForm1
  Left = 190
  Top = 113
  Width = 429
  Height = 518
  Caption = #1051#1072#1073'.'#1088#1072#1073'.'#8470'4 '#1089#1090'.'#1075#1088'.712502, '#1052#1072#1081#1082#1086' '#1050'.'#1057'.'
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
    Width = 166
    Height = 24
    Caption = #1055#1086#1088#1103#1076#1086#1082' '#1084#1072#1090#1088#1080#1094#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 368
    Width = 133
    Height = 20
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1081':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 224
    Top = 368
    Width = 125
    Height = 20
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 56
    Width = 3
    Height = 13
  end
  object Edit1: TEdit
    Left = 24
    Top = 48
    Width = 129
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 184
    Top = 40
    Width = 217
    Height = 41
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1088#1103#1076#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 440
    Width = 145
    Height = 41
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 232
    Top = 440
    Width = 145
    Height = 41
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Kind = bkClose
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 96
    Width = 385
    Height = 249
    ColCount = 4
    RowCount = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 4
  end
  object Button3: TButton
    Left = 296
    Top = 8
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 5
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 24
    Top = 392
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 224
    Top = 392
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'Edit3'
  end
end
