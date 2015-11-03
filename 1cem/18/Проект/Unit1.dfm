object Form1: TForm1
  Left = 193
  Top = 124
  Width = 687
  Height = 404
  Caption = #1063#1077#1088#1085#1103#1074#1089#1082#1080#1081' '#1069'. '#1040'.; 152003; '#1051#1072#1073'. '#1088#1072#1073'. 18'
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
    Top = 8
    Width = 28
    Height = 24
    Caption = 'N='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 184
    Top = 128
    Width = 150
    Height = 13
    Caption = #1051#1080#1089#1090', '#1073#1083#1080#1078#1072#1081#1096#1080#1081' '#1082' '#1089#1088#1077#1076#1085#1077#1084#1091
  end
  object Label2: TLabel
    Left = 176
    Top = 80
    Width = 169
    Height = 13
    Caption = #1053#1072#1081#1090#1080' '#1089#1088#1077#1076#1085#1077#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1082#1083#1102#1095#1077#1081':'
  end
  object Memo1: TMemo
    Left = 504
    Top = 8
    Width = 153
    Height = 281
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 48
    Top = 8
    Width = 41
    Height = 21
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 96
    Top = 8
    Width = 81
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 16
    Top = 328
    Width = 161
    Height = 25
    Caption = #1042#1074#1077#1089#1090#1080' '#1076#1077#1088#1077#1074#1086
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkOK
  end
  object TreeView1: TTreeView
    Left = 344
    Top = 8
    Width = 153
    Height = 313
    Indent = 19
    TabOrder = 4
  end
  object BitBtn3: TBitBtn
    Left = 504
    Top = 296
    Width = 153
    Height = 25
    Caption = #1055#1088#1103#1084#1086#1081' '#1086#1073#1093#1086#1076
    TabOrder = 5
    OnClick = BitBtn3Click
    Kind = bkOK
  end
  object BitBtn4: TBitBtn
    Left = 504
    Top = 328
    Width = 153
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1077#1088#1077#1074#1086
    TabOrder = 6
    OnClick = BitBtn4Click
    Kind = bkOK
  end
  object BitBtn5: TBitBtn
    Left = 344
    Top = 328
    Width = 153
    Height = 25
    Caption = #1057#1073#1072#1083#1072#1085#1089#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 7
    OnClick = BitBtn5Click
    Kind = bkOK
  end
  object LabeledEdit1: TLabeledEdit
    Left = 192
    Top = 24
    Width = 145
    Height = 21
    EditLabel.Width = 109
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1081#1090#1080' '#1087#1086' '#1087#1072#1089#1087#1086#1088#1090#1091' '#8470
    TabOrder = 8
  end
  object BitBtn6: TBitBtn
    Left = 192
    Top = 48
    Width = 65
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 9
    OnClick = BitBtn6Click
    Kind = bkOK
  end
  object BitBtn7: TBitBtn
    Left = 264
    Top = 48
    Width = 73
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 10
    OnClick = BitBtn7Click
    Kind = bkAbort
  end
  object BitBtn8: TBitBtn
    Left = 184
    Top = 96
    Width = 153
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 11
    OnClick = BitBtn8Click
    Kind = bkOK
  end
  object BitBtn9: TBitBtn
    Left = 184
    Top = 144
    Width = 153
    Height = 25
    Caption = '&'#1042#1099#1074#1077#1089#1090#1080
    TabOrder = 12
    OnClick = BitBtn9Click
    Kind = bkOK
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 40
    Width = 161
    Height = 281
    ColCount = 2
    FixedCols = 0
    RowCount = 10
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 13
  end
end
