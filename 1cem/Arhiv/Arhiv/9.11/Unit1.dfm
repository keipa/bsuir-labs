object Form1: TForm1
  Left = 194
  Top = 122
  Width = 650
  Height = 580
  Caption = #1051#1072#1073'.'#1088#1072#1073'.'#8470'9 '#1075#1088'.712502 '#1052#1072#1081#1082#1086' '#1050'.'#1057'.'
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
    Left = 0
    Top = 0
    Width = 642
    Height = 546
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1043#1088#1072#1092#1080#1082
      object Label10: TLabel
        Left = 48
        Top = 440
        Width = 84
        Height = 20
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 176
        Top = 440
        Width = 116
        Height = 20
        Caption = #1050#1086#1083'-'#1074#1086' '#1096#1072#1075#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 312
        Top = 440
        Width = 115
        Height = 20
        Caption = #1055#1086#1075#1088#1077#1096#1085#1086#1089#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Chart1: TChart
        Left = 8
        Top = 8
        Width = 617
        Height = 417
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          #1043#1088#1072#1092#1080#1082' '#1092#1091#1085#1082#1094#1080#1081)
        View3D = False
        TabOrder = 0
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Title = 's(x,eps)'
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
        object Series2: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clGreen
          Title = 'y(x)'
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
      object Edit9: TEdit
        Left = 16
        Top = 472
        Width = 65
        Height = 21
        TabOrder = 1
        Text = 'Edit9'
      end
      object Edit10: TEdit
        Left = 96
        Top = 472
        Width = 65
        Height = 21
        TabOrder = 2
        Text = 'Edit10'
      end
      object Edit11: TEdit
        Left = 200
        Top = 472
        Width = 65
        Height = 21
        TabOrder = 3
        Text = 'Edit11'
      end
      object Edit12: TEdit
        Left = 312
        Top = 472
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'Edit12'
      end
      object Button2: TButton
        Left = 480
        Top = 440
        Width = 113
        Height = 33
        Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = Button2Click
      end
      object BitBtn2: TBitBtn
        Left = 480
        Top = 480
        Width = 113
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        Kind = bkClose
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1063#1077#1090#1099#1088#1077#1093#1091#1075#1086#1083#1100#1085#1080#1082
      ImageIndex = 1
      object Image1: TImage
        Left = 8
        Top = 12
        Width = 617
        Height = 385
      end
      object Label1: TLabel
        Left = 8
        Top = 417
        Width = 28
        Height = 20
        Caption = 'X1:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 449
        Width = 28
        Height = 20
        Caption = 'Y1:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 120
        Top = 417
        Width = 28
        Height = 20
        Caption = 'X2:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 120
        Top = 449
        Width = 28
        Height = 20
        Caption = 'Y2:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 232
        Top = 417
        Width = 28
        Height = 20
        Caption = 'X3:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 232
        Top = 449
        Width = 28
        Height = 20
        Caption = 'Y3:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 344
        Top = 417
        Width = 28
        Height = 20
        Caption = 'X4:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 344
        Top = 449
        Width = 28
        Height = 20
        Caption = 'Y4:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 8
        Top = 485
        Width = 63
        Height = 24
        Caption = 'Label9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit5: TEdit
        Left = 264
        Top = 416
        Width = 65
        Height = 21
        TabOrder = 0
        Text = 'Edit5'
      end
      object BitBtn1: TBitBtn
        Left = 480
        Top = 444
        Width = 105
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Kind = bkClose
      end
      object Edit1: TEdit
        Left = 40
        Top = 416
        Width = 65
        Height = 21
        TabOrder = 2
        Text = 'Edit1'
      end
      object Edit2: TEdit
        Left = 40
        Top = 448
        Width = 65
        Height = 21
        TabOrder = 3
        Text = 'Edit2'
      end
      object Edit3: TEdit
        Left = 152
        Top = 416
        Width = 65
        Height = 21
        TabOrder = 4
        Text = 'Edit3'
      end
      object Edit4: TEdit
        Left = 152
        Top = 448
        Width = 65
        Height = 21
        TabOrder = 5
        Text = 'Edit4'
      end
      object Edit6: TEdit
        Left = 264
        Top = 448
        Width = 65
        Height = 21
        TabOrder = 6
        Text = 'Edit6'
      end
      object Edit7: TEdit
        Left = 376
        Top = 416
        Width = 65
        Height = 21
        TabOrder = 7
        Text = 'Edit7'
      end
      object Edit8: TEdit
        Left = 376
        Top = 448
        Width = 65
        Height = 21
        TabOrder = 8
        Text = 'Edit8'
      end
      object Button1: TButton
        Left = 480
        Top = 412
        Width = 105
        Height = 25
        Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        OnClick = Button1Click
      end
    end
  end
end
