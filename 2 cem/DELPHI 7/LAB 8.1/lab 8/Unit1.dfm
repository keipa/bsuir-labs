object Form1: TForm1
  Left = 250
  Top = 79
  Width = 801
  Height = 345
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
    Left = 568
    Top = 200
    Width = 14
    Height = 13
    Caption = 'N='
  end
  object Label2: TLabel
    Left = 672
    Top = 128
    Width = 26
    Height = 13
    Caption = #1050#1083#1102#1095
  end
  object Edit1: TEdit
    Left = 584
    Top = 200
    Width = 81
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 145
    Height = 289
    ColCount = 2
    FixedCols = 0
    RowCount = 10
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
  end
  object Button1: TButton
    Left = 664
    Top = 200
    Width = 105
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 568
    Top = 8
    Width = 97
    Height = 25
    Caption = #1042#1074#1077#1089#1090#1080' '#1076#1077#1088#1077#1074#1086
    TabOrder = 3
    OnClick = Button2Click
  end
  object TreeView1: TTreeView
    Left = 168
    Top = 8
    Width = 177
    Height = 257
    Indent = 19
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 360
    Top = 8
    Width = 201
    Height = 257
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object Button3: TButton
    Left = 568
    Top = 168
    Width = 97
    Height = 25
    Caption = #1055#1088#1103#1084#1086#1081' '#1086#1073#1093#1086#1076
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 680
    Top = 8
    Width = 89
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1077#1088#1077#1074#1086
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 568
    Top = 40
    Width = 105
    Height = 25
    Caption = #1057#1073#1072#1083#1072#1085#1089#1080#1088#1086#1074#1072#1085#1080#1077
    TabOrder = 8
    OnClick = Button5Click
  end
  object Edit2: TEdit
    Left = 704
    Top = 128
    Width = 65
    Height = 21
    TabOrder = 9
    Text = 'Edit2'
  end
  object Button6: TButton
    Left = 568
    Top = 104
    Width = 97
    Height = 25
    Caption = #1053#1072#1081#1090#1080' '#1087#1086' '#1082#1083#1102#1095#1091
    TabOrder = 10
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 568
    Top = 136
    Width = 97
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086' '#1082#1083#1102#1095#1091
    TabOrder = 11
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 680
    Top = 40
    Width = 91
    Height = 25
    Caption = #1057#1080#1084#1084#1077#1090#1088#1080#1095#1085#1099#1081
    TabOrder = 12
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 664
    Top = 168
    Width = 105
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1087#1080#1089#1100
    TabOrder = 13
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 568
    Top = 72
    Width = 201
    Height = 25
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1080#1084#1074#1086#1083#1086#1074
    TabOrder = 14
    OnClick = Button10Click
  end
end
