object Form1: TForm1
  Left = 207
  Top = 153
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
    Left = 40
    Top = 32
    Width = 24
    Height = 13
    Caption = ' N = '
  end
  object Label2: TLabel
    Left = 256
    Top = 24
    Width = 18
    Height = 13
    Caption = 'C ='
  end
  object Edit1: TEdit
    Left = 80
    Top = 24
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 296
    Top = 16
    Width = 193
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 48
    Top = 64
    Width = 193
    Height = 49
    Caption = 'Change'
    TabOrder = 2
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 56
    Top = 128
    Width = 673
    Height = 97
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 3
  end
  object StringGrid2: TStringGrid
    Left = 56
    Top = 248
    Width = 673
    Height = 81
    RowCount = 2
    TabOrder = 4
  end
  object Button2: TButton
    Left = 208
    Top = 352
    Width = 193
    Height = 65
    Caption = 'Insert'
    TabOrder = 5
    OnClick = Button2Click
  end
end
