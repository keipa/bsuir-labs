object Form1: TForm1
  Left = 222
  Top = 127
  Width = 551
  Height = 457
  Caption = 'LabRab Rouda 453504'
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
    Top = 16
    Width = 14
    Height = 13
    Caption = 'N='
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 15
    Height = 13
    Caption = 'M='
  end
  object Button1: TButton
    Left = 104
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 0
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 352
    Top = 328
    Width = 75
    Height = 25
    Caption = 'End'
    TabOrder = 1
    Kind = bkClose
  end
  object Edit1: TEdit
    Left = 32
    Top = 16
    Width = 49
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 32
    Top = 48
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Button2: TButton
    Left = 184
    Top = 328
    Width = 161
    Height = 25
    Caption = 'Change array capacity'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 88
    Width = 337
    Height = 209
    ColCount = 4
    RowCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 5
  end
  object StringGrid2: TStringGrid
    Left = 368
    Top = 88
    Width = 73
    Height = 217
    ColCount = 1
    FixedCols = 0
    RowCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 6
  end
  object StringGrid3: TStringGrid
    Left = 456
    Top = 88
    Width = 73
    Height = 217
    ColCount = 1
    FixedCols = 0
    RowCount = 4
    TabOrder = 7
  end
end
