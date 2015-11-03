object Form1: TForm1
  Left = 192
  Top = 124
  Width = 1088
  Height = 563
  Caption = 'Form1'
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
  object Label1: TLabel
    Left = 16
    Top = 40
    Width = 28
    Height = 21
    Caption = 'N= '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 608
    Top = 32
    Width = 30
    Height = 21
    Caption = 'c = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 64
    Top = 40
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 232
    Top = 32
    Width = 297
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 32
    Top = 96
    Width = 529
    Height = 65
    ColCount = 4
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 2
  end
  object StringGrid2: TStringGrid
    Left = 32
    Top = 200
    Width = 529
    Height = 81
    RowCount = 2
    TabOrder = 3
  end
  object Button2: TButton
    Left = 120
    Top = 352
    Width = 313
    Height = 81
    Caption = #1054#1082
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 656
    Top = 24
    Width = 249
    Height = 21
    TabOrder = 5
    Text = 'Edit2'
  end
end
