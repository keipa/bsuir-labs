object Form1: TForm1
  Left = 220
  Top = 166
  Width = 668
  Height = 416
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
  object lbl1: TLabel
    Left = 160
    Top = 24
    Width = 6
    Height = 13
    Caption = 'n'
  end
  object lbl2: TLabel
    Left = 176
    Top = 72
    Width = 14
    Height = 13
    Caption = 'ele'
  end
  object edt1: TEdit
    Left = 224
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'edt1'
  end
  object edt2: TEdit
    Left = 216
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edt2'
  end
  object strngrd1: TStringGrid
    Left = 104
    Top = 120
    Width = 481
    Height = 41
    RowCount = 1
    FixedRows = 0
    TabOrder = 2
  end
  object strngrd2: TStringGrid
    Left = 104
    Top = 208
    Width = 489
    Height = 41
    RowCount = 1
    FixedRows = 0
    TabOrder = 3
  end
  object btn1: TButton
    Left = 400
    Top = 32
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 4
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 416
    Top = 80
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 5
  end
  object btn3: TBitBtn
    Left = 280
    Top = 336
    Width = 75
    Height = 25
    TabOrder = 6
    OnClick = btn3Click
    Kind = bkClose
  end
end
