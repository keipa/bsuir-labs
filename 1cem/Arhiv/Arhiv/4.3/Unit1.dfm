object Form1: TForm1
  Left = 192
  Top = 114
  Width = 676
  Height = 500
  Caption = #1048#1085#1076#1080#1074#1080#1076#1091#1072#1083#1100#1085#1086#1077' '#1079#1072#1076#1072#1085#1080#1077' '#8470'4 '#1075#1088'. 712502 '#1041#1088#1072#1085#1094#1077#1074#1080#1095' '#1042'   '#1042#1072#1088#1080#1072#1085#1090' '#8470'3'
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
    Width = 35
    Height = 29
    Caption = 'N='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 37
    Height = 29
    Caption = 'M='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 112
    Width = 29
    Height = 29
    Caption = 'k='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 32
    Top = 176
    Width = 401
    Height = 177
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    ColWidths = (
      64
      64
      65
      64
      64)
  end
  object Edit1: TEdit
    Left = 64
    Top = 8
    Width = 105
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 64
    Top = 64
    Width = 105
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 200
    Top = 24
    Width = 217
    Height = 41
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1088#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100' '#1084#1072#1089#1089#1080#1074#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 368
    Width = 105
    Height = 41
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 392
    Top = 368
    Width = 105
    Height = 41
    TabOrder = 5
    Kind = bkClose
  end
  object Edit3: TEdit
    Left = 64
    Top = 112
    Width = 105
    Height = 21
    TabOrder = 6
    Text = 'Edit3'
  end
  object StringGrid2: TStringGrid
    Left = 480
    Top = 176
    Width = 113
    Height = 177
    ColCount = 1
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 7
  end
end
