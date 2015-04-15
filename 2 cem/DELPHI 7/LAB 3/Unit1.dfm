object Form1: TForm1
  Left = 481
  Top = 281
  Width = 441
  Height = 384
  Caption = #1056#1086#1074#1076#1086' '#1053#1080#1082#1086#1083#1072#1081'  453504  02.03.2015'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl7: TLabel
    Left = 32
    Top = 16
    Width = 374
    Height = 23
    Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1080' '#1079#1072#1074#1086#1076#1072' N'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object pgc1: TPageControl
    Left = 8
    Top = 48
    Width = 409
    Height = 289
    ActivePage = ts4
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    object ts1: TTabSheet
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
      object lbl10: TLabel
        Left = 144
        Top = 16
        Width = 105
        Height = 18
        Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Button1: TButton
        Left = 312
        Top = 200
        Width = 75
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 0
      end
      object Button2: TButton
        Left = 16
        Top = 200
        Width = 97
        Height = 25
        Caption = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1041#1072#1079#1091
        TabOrder = 1
      end
      object StringGrid1: TStringGrid
        Left = 16
        Top = 40
        Width = 369
        Height = 153
        TabOrder = 2
      end
    end
    object ts2: TTabSheet
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1086#1076#1091#1082#1094#1080#1102
      ImageIndex = 1
      object lbl1: TLabel
        Left = 112
        Top = 48
        Width = 52
        Height = 13
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
      end
      object lbl2: TLabel
        Left = 104
        Top = 80
        Width = 64
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
      end
      object lbl3: TLabel
        Left = 104
        Top = 112
        Width = 62
        Height = 13
        Caption = #1053#1086#1084#1077#1088' '#1094#1077#1093#1072':'
      end
      object lbl6: TLabel
        Left = 88
        Top = 16
        Width = 235
        Height = 18
        Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1086#1074#1086#1081' '#1087#1088#1086#1076#1091#1082#1094#1080#1080' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 152
        Top = 184
        Width = 90
        Height = 18
        Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1086'!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object edit2: TEdit
        Left = 176
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object edit3: TEdit
        Left = 176
        Top = 80
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object edit4: TEdit
        Left = 176
        Top = 112
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object btn1: TButton
        Left = 296
        Top = 232
        Width = 105
        Height = 25
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103'!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = btn1Click
      end
      object btn2: TButton
        Left = 128
        Top = 152
        Width = 137
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1041#1072#1079#1091'...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
    end
    object ts4: TTabSheet
      Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1041#1044' '
      ImageIndex = 3
      object lbl11: TLabel
        Left = 216
        Top = 8
        Width = 123
        Height = 13
        Caption = #1055#1086#1080#1089#1082' '#1079#1072#1087#1080#1089#1080' '#1087#1086' '#1050#1083#1102#1095#1091':'
      end
      object lbl12: TLabel
        Left = 8
        Top = 8
        Width = 126
        Height = 13
        Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1041#1072#1079#1086#1081' '#1044#1072#1085#1085#1099#1093' :'
      end
      object btn3: TButton
        Left = 16
        Top = 32
        Width = 105
        Height = 25
        Caption = #1057#1086#1079#1076#1072#1090#1100' '#1041#1044'...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object btn4: TButton
        Left = 16
        Top = 96
        Width = 105
        Height = 25
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1041#1044'...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object btn5: TButton
        Left = 16
        Top = 64
        Width = 105
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1041#1044'...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object edit7: TEdit
        Left = 216
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object btn6: TButton
        Left = 232
        Top = 96
        Width = 91
        Height = 25
        Caption = #1055#1086#1080#1089#1082'...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object Memo1: TMemo
        Left = 16
        Top = 136
        Width = 361
        Height = 113
        Lines.Strings = (
          'Memo1')
        TabOrder = 5
      end
    end
  end
  object StaticText1: TStaticText
    Left = 192
    Top = 56
    Width = 59
    Height = 17
    Caption = 'StaticText1'
    TabOrder = 1
  end
end
