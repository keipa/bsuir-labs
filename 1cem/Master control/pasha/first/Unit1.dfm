object Form1: TForm1
  Left = 235
  Top = 224
  Width = 1004
  Height = 390
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
    Left = 8
    Top = 256
    Width = 69
    Height = 13
    Caption = 'element  value'
  end
  object lbl2: TLabel
    Left = 48
    Top = 288
    Width = 26
    Height = 13
    Caption = 'Index'
  end
  object lbl3: TLabel
    Left = 8
    Top = 224
    Width = 60
    Height = 13
    Caption = 'array capcity'
  end
  object btn1: TButton
    Left = 296
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Sort'
    TabOrder = 0
    Visible = False
    OnClick = btn1Click
  end
  object btn2: TBitBtn
    Left = 272
    Top = 320
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkClose
  end
  object strngrd1: TStringGrid
    Left = 8
    Top = 8
    Width = 937
    Height = 89
    DefaultColWidth = 40
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 2
    Visible = False
  end
  object strngrd2: TStringGrid
    Left = 8
    Top = 112
    Width = 937
    Height = 70
    Color = clBtnFace
    DefaultColWidth = 40
    RowCount = 2
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    Visible = False
  end
  object edt1: TEdit
    Left = 88
    Top = 256
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '666'
  end
  object edt2: TEdit
    Left = 88
    Top = 288
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '2'
  end
  object btn3: TButton
    Left = 216
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Paste'
    TabOrder = 6
    OnClick = btn3Click
  end
  object Button1: TButton
    Left = 216
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 7
    OnClick = Button1Click
  end
  object edt3: TEdit
    Left = 88
    Top = 224
    Width = 121
    Height = 21
    TabOrder = 8
    Text = '10'
  end
end
