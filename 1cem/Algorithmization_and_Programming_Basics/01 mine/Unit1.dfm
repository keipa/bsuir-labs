object Form1: TForm1
  Left = 346
  Top = 168
  Width = 346
  Height = 438
  Caption = 'Sample text'
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
    Left = 152
    Top = 72
    Width = 11
    Height = 13
    Caption = 'x='
  end
  object Label2: TLabel
    Left = 152
    Top = 96
    Width = 11
    Height = 13
    Caption = 'y='
  end
  object Label3: TLabel
    Left = 152
    Top = 120
    Width = 11
    Height = 13
    Caption = 'z='
  end
  object Edit3: TEdit
    Left = 176
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit3'
  end
  object Edit1: TEdit
    Left = 176
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 176
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Memo1: TMemo
    Left = 32
    Top = 152
    Width = 265
    Height = 129
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Button1: TButton
    Left = 120
    Top = 328
    Width = 97
    Height = 25
    Cancel = True
    Caption = 'run'
    TabOrder = 4
    OnClick = Button1Click
  end
end
