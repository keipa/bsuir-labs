object Form1: TForm1
  Left = 328
  Top = 136
  Width = 183
  Height = 469
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
  object ListBox1: TListBox
    Left = 8
    Top = 208
    Width = 153
    Height = 217
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Read'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Add After'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Read After'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 88
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 88
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Search After'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 88
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Sort Inf'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 88
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Sort After'
    TabOrder = 8
    OnClick = Button8Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 153
    Height = 21
    TabOrder = 9
  end
  object Button9: TButton
    Left = 8
    Top = 176
    Width = 153
    Height = 25
    Caption = 'Task'
    TabOrder = 10
    OnClick = Button9Click
  end
end