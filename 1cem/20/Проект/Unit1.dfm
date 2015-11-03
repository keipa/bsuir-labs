object Form1: TForm1
  Left = 186
  Top = 103
  Width = 356
  Height = 332
  Caption = #1051#1072#1073'. '#1088#1072#1073'. 20; 152003 - '#1063#1077#1088#1085#1103#1074#1089#1082#1080#1081' '#1069'. '#1040'.'
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
    Left = 128
    Top = 8
    Width = 95
    Height = 13
    Caption = #1048#1089#1093#1086#1076#1085#1072#1103' '#1084#1072#1090#1088#1080#1094#1072
  end
  object StringGrid1: TStringGrid
    Left = 32
    Top = 24
    Width = 281
    Height = 185
    DefaultColWidth = 24
    FixedCols = 0
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
  end
  object LabeledEdit1: TLabeledEdit
    Left = 32
    Top = 240
    Width = 105
    Height = 21
    EditLabel.Width = 112
    EditLabel.Height = 13
    EditLabel.Caption = #1042#1074#1077#1076#1080#1090#1077' '#1088#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 176
    Top = 272
    Width = 89
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 40
    Top = 272
    Width = 89
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkOK
  end
  object LabeledEdit2: TLabeledEdit
    Left = 168
    Top = 240
    Width = 105
    Height = 21
    EditLabel.Width = 153
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1081#1090#1080' '#1086#1087#1088#1077#1076#1077#1083#1080#1090#1077#1083#1100' '#1084#1072#1090#1088#1080#1094#1099
    TabOrder = 4
  end
end
