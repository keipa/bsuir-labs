object Form1: TForm1
  Left = 623
  Top = 196
  Width = 752
  Height = 630
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
    Left = 24
    Top = 16
    Width = 28
    Height = 21
    Caption = 'N ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 48
    Width = 50
    Height = 21
    Caption = 'Input :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 192
    Width = 62
    Height = 21
    Caption = 'Output :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 72
    Top = 16
    Width = 161
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object StringGrid1: TStringGrid
    Left = 24
    Top = 80
    Width = 441
    Height = 89
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
  end
  object Button1: TButton
    Left = 24
    Top = 344
    Width = 217
    Height = 41
    Caption = 'Calculate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object StringGrid2: TStringGrid
    Left = 24
    Top = 224
    Width = 441
    Height = 89
    RowCount = 2
    TabOrder = 3
  end
  object Button2: TButton
    Left = 256
    Top = 16
    Width = 177
    Height = 25
    Caption = 'Change'
    TabOrder = 4
    OnClick = Button2Click
  end
end
