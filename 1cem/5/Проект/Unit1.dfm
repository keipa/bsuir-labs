object Form1: TForm1
  Left = 190
  Top = 127
  Width = 711
  Height = 221
  Caption = #1051#1072#1073'. '#1088#1072#1073#1086#1090#1072' '#8470'5; 152003 - '#1063#1077#1088#1085#1103#1074#1089#1082#1080#1081
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
    Left = 24
    Top = 8
    Width = 95
    Height = 13
    Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1084#1072#1089#1089#1080#1074':'
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 94
    Height = 13
    Caption = #1042#1099#1093#1086#1076#1085#1086#1081' '#1084#1072#1089#1089#1080#1074':'
  end
  object StringGrid1: TStringGrid
    Left = 24
    Top = 24
    Width = 657
    Height = 33
    ColCount = 10
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
  end
  object StringGrid2: TStringGrid
    Left = 24
    Top = 80
    Width = 657
    Height = 33
    ColCount = 10
    RowCount = 1
    FixedRows = 0
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 24
    Top = 120
    Width = 337
    Height = 49
    Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkYes
  end
  object BitBtn2: TBitBtn
    Left = 368
    Top = 120
    Width = 313
    Height = 49
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    Kind = bkClose
  end
end
