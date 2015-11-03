object Form1: TForm1
  Left = 192
  Top = 124
  Width = 320
  Height = 256
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
    Top = 16
    Width = 14
    Height = 13
    Caption = 'N='
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 15
    Height = 13
    Caption = 'M='
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 64
    Width = 281
    Height = 113
    ColCount = 4
    RowCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    ColWidths = (
      64
      64
      64
      64)
  end
  object Edit1: TEdit
    Left = 32
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 32
    Top = 40
    Width = 41
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 80
    Top = 16
    Width = 209
    Height = 41
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1088#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100' '#1084#1072#1089#1089#1080#1074#1072
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 112
    Top = 184
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 4
    OnClick = Button2Click
  end
end
