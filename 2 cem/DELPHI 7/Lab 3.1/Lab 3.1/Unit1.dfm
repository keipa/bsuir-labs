object Form1: TForm1
  Left = 340
  Top = 253
  BorderStyle = bsSingle
  Caption = #1056#1086#1074#1076#1086' '#1053#1080#1082#1086#1083#1072#1081'  453504  02.03.2015'
  ClientHeight = 340
  ClientWidth = 426
  Color = clMenu
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
    Left = 40
    Top = 8
    Width = 341
    Height = 24
    Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1080' '#1079#1072#1074#1086#1076#1072' N'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 40
    Width = 425
    Height = 297
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
      object Label10: TLabel
        Left = 256
        Top = 16
        Width = 41
        Height = 13
        Caption = #1050#1086#1083'-'#1074#1086
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object StringGrid1: TStringGrid
        Left = 8
        Top = 72
        Width = 393
        Height = 201
        ColCount = 4
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        ColWidths = (
          64
          169
          60
          85)
      end
      object Button7: TButton
        Left = 8
        Top = 8
        Width = 105
        Height = 25
        Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
        TabOrder = 1
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 304
        Top = 40
        Width = 81
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 2
        OnClick = Button8Click
      end
      object Edit5: TEdit
        Left = 312
        Top = 8
        Width = 73
        Height = 21
        TabOrder = 3
      end
      object Button9: TButton
        Left = 120
        Top = 8
        Width = 113
        Height = 25
        Caption = #1055#1088#1103#1084#1086#1081' '#1087#1077#1088#1077#1073#1086#1088
        TabOrder = 4
        OnClick = Button9Click
      end
      object Button10: TButton
        Left = 120
        Top = 40
        Width = 113
        Height = 25
        Caption = #1044#1074#1086#1080#1095#1085#1099#1081' '#1087#1086#1080#1089#1082
        TabOrder = 5
        OnClick = Button10Click
      end
      object Memo2: TMemo
        Left = 240
        Top = 32
        Width = 57
        Height = 41
        Lines.Strings = (
          'Memo2')
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1094#1080#1102
      ImageIndex = 1
      object Label4: TLabel
        Left = 56
        Top = 16
        Width = 311
        Height = 24
        Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077'  '#1085#1086#1074#1086#1081' '#1087#1088#1086#1076#1091#1082#1094#1080#1080':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 96
        Top = 56
        Width = 53
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
      end
      object Label6: TLabel
        Left = 96
        Top = 88
        Width = 62
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
      end
      object Label7: TLabel
        Left = 96
        Top = 120
        Width = 63
        Height = 13
        Caption = #1053#1086#1084#1077#1088' '#1094#1077#1093#1072':'
      end
      object Label8: TLabel
        Left = 48
        Top = 200
        Width = 121
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1086'!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Edit2: TEdit
        Left = 168
        Top = 56
        Width = 209
        Height = 21
        TabOrder = 0
      end
      object Edit3: TEdit
        Left = 168
        Top = 88
        Width = 57
        Height = 21
        TabOrder = 1
      end
      object Edit4: TEdit
        Left = 168
        Top = 120
        Width = 57
        Height = 21
        TabOrder = 2
      end
      object Button5: TButton
        Left = 144
        Top = 160
        Width = 121
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1041#1072#1079#1091'...'
        TabOrder = 3
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 312
        Top = 232
        Width = 91
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103
        TabOrder = 4
      end
    end
    object TabSheet3: TTabSheet
      Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1041#1044' '
      ImageIndex = 2
      object Label2: TLabel
        Left = 256
        Top = 16
        Width = 149
        Height = 13
        Caption = #1055#1086#1080#1089#1082' '#1079#1072#1087#1080#1089#1080' '#1087#1086' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1091':'
      end
      object Label3: TLabel
        Left = 32
        Top = 8
        Width = 122
        Height = 13
        Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1041#1072#1079#1086#1081' '#1076#1072#1085#1085#1099#1093':'
      end
      object Edit1: TEdit
        Left = 272
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object Button1: TButton
        Left = 296
        Top = 72
        Width = 75
        Height = 25
        Caption = #1055#1086#1080#1089#1082'..'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Memo1: TMemo
        Left = 40
        Top = 144
        Width = 345
        Height = 113
        Lines.Strings = (
          'Memo1')
        TabOrder = 2
      end
      object Button3: TButton
        Left = 40
        Top = 32
        Width = 97
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1041#1072#1079#1091
        TabOrder = 3
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 40
        Top = 64
        Width = 97
        Height = 25
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1041#1072#1079#1091
        TabOrder = 4
        OnClick = Button4Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 156
    Top = 160
  end
  object SaveDialog1: TSaveDialog
    Left = 156
    Top = 128
  end
end
