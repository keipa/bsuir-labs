object Form1: TForm1
  Left = 594
  Top = 147
  Width = 375
  Height = 386
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
  object PageControl1: TPageControl
    Left = 8
    Top = 4
    Width = 345
    Height = 285
    ActivePage = TabSheet4
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      object Label1: TLabel
        Left = 88
        Top = 8
        Width = 25
        Height = 13
        Caption = 'X1 = '
      end
      object Label2: TLabel
        Left = 168
        Top = 8
        Width = 19
        Height = 13
        Caption = 'X2='
      end
      object Label3: TLabel
        Left = 88
        Top = 40
        Width = 19
        Height = 13
        Caption = 'Y1='
      end
      object Label4: TLabel
        Left = 168
        Top = 40
        Width = 19
        Height = 13
        Caption = 'Y2='
      end
      object Edit1: TEdit
        Left = 112
        Top = 8
        Width = 41
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object Edit2: TEdit
        Left = 112
        Top = 40
        Width = 41
        Height = 21
        TabOrder = 1
        Text = 'Edit2'
      end
      object Edit3: TEdit
        Left = 192
        Top = 8
        Width = 41
        Height = 21
        TabOrder = 2
        Text = 'Edit3'
      end
      object Edit4: TEdit
        Left = 192
        Top = 40
        Width = 41
        Height = 21
        TabOrder = 3
        Text = 'Edit4'
      end
      object Button1: TButton
        Left = 8
        Top = 72
        Width = 321
        Height = 177
        Caption = '&'#1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1088#1080#1089#1091#1085#1086#1082
        TabOrder = 4
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1056#1080#1089#1091#1085#1086#1082
      ImageIndex = 1
      object Image1: TImage
        Left = 8
        Top = 8
        Width = 321
        Height = 209
      end
      object Button3: TButton
        Left = 0
        Top = 224
        Width = 337
        Height = 33
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        TabOrder = 0
        OnClick = Button3Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1051#1072#1073'. '#1088#1072#1073'. '#8470'3'
      ImageIndex = 2
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 19
        Height = 13
        Caption = 'Xn='
      end
      object Label6: TLabel
        Left = 8
        Top = 32
        Width = 19
        Height = 13
        Caption = 'Xk='
      end
      object Label7: TLabel
        Left = 16
        Top = 56
        Width = 15
        Height = 13
        Caption = 'M='
      end
      object Label8: TLabel
        Left = 16
        Top = 80
        Width = 12
        Height = 13
        Caption = 'e='
      end
      object Label9: TLabel
        Left = 80
        Top = 8
        Width = 80
        Height = 13
        Caption = #1056#1072#1079#1084#1077#1090#1082#1072' '#1086#1089#1077#1081':'
      end
      object Label10: TLabel
        Left = 80
        Top = 24
        Width = 29
        Height = 13
        Caption = 'Xmin='
      end
      object Label11: TLabel
        Left = 160
        Top = 24
        Width = 32
        Height = 13
        Caption = 'Xmax='
      end
      object Label12: TLabel
        Left = 80
        Top = 48
        Width = 29
        Height = 13
        Caption = 'Ymin='
      end
      object Label13: TLabel
        Left = 160
        Top = 48
        Width = 32
        Height = 13
        Caption = 'Ymax='
      end
      object Edit5: TEdit
        Left = 32
        Top = 8
        Width = 41
        Height = 21
        TabOrder = 0
        Text = 'Edit5'
      end
      object Edit6: TEdit
        Left = 32
        Top = 32
        Width = 41
        Height = 21
        TabOrder = 1
        Text = 'Edit6'
      end
      object Edit7: TEdit
        Left = 32
        Top = 56
        Width = 41
        Height = 21
        TabOrder = 2
        Text = 'Edit7'
      end
      object Edit8: TEdit
        Left = 32
        Top = 80
        Width = 41
        Height = 21
        TabOrder = 3
        Text = 'Edit8'
      end
      object RadioGroup1: TRadioGroup
        Left = 248
        Top = 8
        Width = 73
        Height = 97
        Caption = 'f(x) = '
        Items.Strings = (
          'S(x)'
          'Y(x)')
        TabOrder = 4
      end
      object BitBtn2: TBitBtn
        Left = 8
        Top = 208
        Width = 321
        Height = 41
        Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082
        TabOrder = 5
        OnClick = BitBtn2Click
      end
      object Memo1: TMemo
        Left = 16
        Top = 112
        Width = 305
        Height = 89
        Lines.Strings = (
          'Memo1')
        TabOrder = 6
      end
      object Edit9: TEdit
        Left = 112
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 7
        Text = 'Edit9'
      end
      object Edit10: TEdit
        Left = 200
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 8
        Text = 'Edit10'
      end
      object Edit11: TEdit
        Left = 112
        Top = 48
        Width = 41
        Height = 21
        TabOrder = 9
        Text = 'Edit11'
      end
      object Edit12: TEdit
        Left = 200
        Top = 48
        Width = 41
        Height = 21
        TabOrder = 10
        Text = 'Edit12'
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1043#1088#1072#1092#1080#1082' '#1051'.'#1056'.'#8470'3'
      ImageIndex = 3
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 337
        Height = 249
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TChart')
        BottomAxis.ExactDateTime = False
        BottomAxis.Increment = 0.200000000000000000
        BottomAxis.Title.Caption = 'x'
        LeftAxis.ExactDateTime = False
        LeftAxis.Increment = 0.100000000000000000
        LeftAxis.Title.Caption = 'f(x)'
        Legend.Visible = False
        View3D = False
        TabOrder = 0
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #1043#1088#1072#1092#1080#1082' (TImage)'
      ImageIndex = 4
      object Image2: TImage
        Left = 8
        Top = 8
        Width = 321
        Height = 201
      end
      object Button2: TButton
        Left = 8
        Top = 216
        Width = 321
        Height = 33
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        TabOrder = 0
        OnClick = Button2Click
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 296
    Width = 329
    Height = 41
    TabOrder = 1
    Kind = bkClose
  end
end
