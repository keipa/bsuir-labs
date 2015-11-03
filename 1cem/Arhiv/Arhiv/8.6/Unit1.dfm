object Form1: TForm1
  Left = 238
  Top = 118
  Caption = #1047#1072#1103#1094' '#1048'. '#1040'. '#1075#1088'. 811801'
  ClientHeight = 502
  ClientWidth = 633
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
  object Button1: TButton
    Left = 16
    Top = 8
    Width = 105
    Height = 33
    Caption = #1054#1090#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 56
    Width = 97
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 120
    Top = 56
    Width = 113
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 240
    Top = 56
    Width = 113
    Height = 21
    TabOrder = 3
    Text = 'Edit3'
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 88
    Width = 609
    Height = 193
    ColCount = 7
    FixedCols = 0
    RowCount = 9
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 4
    ColWidths = (
      101
      144
      129
      52
      53
      49
      50)
  end
  object Button2: TButton
    Left = 136
    Top = 8
    Width = 105
    Height = 33
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 552
    Top = 56
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 256
    Top = 8
    Width = 105
    Height = 33
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = Button4Click
  end
  object Edit4: TEdit
    Left = 360
    Top = 56
    Width = 41
    Height = 21
    TabOrder = 8
    Text = 'Edit4'
  end
  object Edit5: TEdit
    Left = 408
    Top = 56
    Width = 41
    Height = 21
    TabOrder = 9
    Text = 'Edit5'
  end
  object Edit6: TEdit
    Left = 456
    Top = 56
    Width = 41
    Height = 21
    TabOrder = 10
    Text = 'Edit6'
  end
  object Edit7: TEdit
    Left = 504
    Top = 56
    Width = 41
    Height = 21
    TabOrder = 11
    Text = 'Edit7'
  end
  object Button5: TButton
    Left = 16
    Top = 296
    Width = 153
    Height = 25
    Caption = #1042#1099#1074#1077#1089#1090#1080' '#1085#1072' '#1101#1082#1088#1072#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 184
    Top = 296
    Width = 153
    Height = 25
    Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074' '#1092#1072#1081#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = Button6Click
  end
  object StringGrid2: TStringGrid
    Left = 16
    Top = 336
    Width = 609
    Height = 153
    ColCount = 7
    FixedCols = 0
    RowCount = 9
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 14
    ColWidths = (
      101
      144
      129
      52
      53
      49
      50)
  end
  object OpenDialog1: TOpenDialog
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.dat|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Title = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1103
    Left = 384
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083#1099' '#1076#1072#1085#1085#1099#1093'|*.dat|'#1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077
    Left = 424
    Top = 8
  end
end
