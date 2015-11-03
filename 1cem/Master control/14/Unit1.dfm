object Form1: TForm1
  Left = 209
  Top = 209
  Width = 1088
  Height = 563
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object strngrd1: TStringGrid
    Left = 56
    Top = 96
    Width = 464
    Height = 120
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
  end
  object strngrd2: TStringGrid
    Left = 56
    Top = 224
    Width = 464
    Height = 120
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
  end
  object btn1: TButton
    Left = 608
    Top = 168
    Width = 289
    Height = 129
    Cursor = crHandPoint
    Caption = 'btn1'
    TabOrder = 2
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 752
    Top = 72
    Width = 75
    Height = 25
    Caption = 'btn2'
    TabOrder = 3
  end
  object edt1: TEdit
    Left = 616
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'edt1'
  end
  object strngrd3: TStringGrid
    Left = 216
    Top = 408
    Width = 657
    Height = 65
    ColCount = 10
    RowCount = 2
    TabOrder = 5
  end
  object mmo1: TMemo
    Left = 24
    Top = 400
    Width = 105
    Height = 113
    Lines.Strings = (
      'mmo1')
    TabOrder = 6
  end
end
