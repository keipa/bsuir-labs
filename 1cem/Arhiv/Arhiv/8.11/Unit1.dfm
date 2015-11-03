object Form1: TForm1
  Left = 238
  Top = 118
  Width = 649
  Height = 332
  Caption = #1051#1072#1073'.'#1088#1072#1073'.'#8470'8 '#1075#1088'.712502 '#1052#1072#1081#1082#1086' '#1050'.'#1057'.'
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
    Width = 49
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 72
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 200
    Top = 56
    Width = 73
    Height = 21
    TabOrder = 3
    Text = 'Edit3'
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 88
    Width = 337
    Height = 193
    ColCount = 3
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
      60
      176
      76)
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
    Left = 280
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
  object GroupBox1: TGroupBox
    Left = 376
    Top = 8
    Width = 249
    Height = 273
    Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1072#1103
    TabOrder = 7
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 214
      Height = 16
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1091#1085#1082#1090' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 40
      Height = 13
      Caption = #1053#1086#1084#1077#1088
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 72
      Top = 72
      Width = 119
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 48
      Top = 40
      Width = 145
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      Text = 'ComboBox1'
      OnKeyPress = ComboBox1KeyPress
    end
    object Memo1: TMemo
      Left = 16
      Top = 96
      Width = 217
      Height = 161
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
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
    TabOrder = 8
    OnClick = Button4Click
  end
  object OpenDialog1: TOpenDialog
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.dat|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Title = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1103
    Left = 400
    Top = 232
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.dat|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077
    Left = 440
    Top = 232
  end
end
