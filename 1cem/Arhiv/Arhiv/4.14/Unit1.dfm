object Form1: TForm1
  Left = 192
  Top = 114
  Width = 676
  Height = 500
  Caption = 
    #1048#1085#1076#1080#1074#1080#1076#1091#1072#1083#1100#1085#1086#1077' '#1079#1072#1076#1072#1085#1080#1077' '#8470'4 '#1075#1088'. 712502 '#1058#1088#1077#1075#1091#1073#1086#1074#1072' '#1042#1080#1090#1072#1083#1080#1103'   '#1042#1072#1088#1080#1072#1085#1090 +
    ' 14'
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
    Left = 32
    Top = 16
    Width = 85
    Height = 24
    Caption = #1055#1086#1088#1103#1076#1086#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
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
    Left = 56
    Top = 48
    Width = 33
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 144
    Top = 32
    Width = 217
    Height = 41
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1088#1103#1076#1086#1082' '#1084#1072#1090#1088#1080#1094#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
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
    TabOrder = 3
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 304
    Top = 368
    Width = 105
    Height = 41
    TabOrder = 4
    Kind = bkClose
  end
  object Memo1: TMemo
    Left = 472
    Top = 176
    Width = 161
    Height = 177
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 5
  end
end
