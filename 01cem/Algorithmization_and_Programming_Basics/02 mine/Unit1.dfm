object Form1: TForm1
  Left = 215
  Top = 136
  Width = 286
  Height = 375
  Caption = 'Lab 2'
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
    Left = 8
    Top = 24
    Width = 13
    Height = 13
    Caption = 'X='
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 13
    Height = 13
    Caption = 'Y='
  end
  object Edit1: TEdit
    Left = 24
    Top = 16
    Width = 121
    Height = 33
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 24
    Top = 56
    Width = 121
    Height = 33
    TabOrder = 1
    Text = 'Edit2'
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 104
    Width = 49
    Height = 17
    Caption = 'OKP'
    TabOrder = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 160
    Top = 8
    Width = 97
    Height = 105
    Caption = 'F(x)'
    Items.Strings = (
      'sin(x)'
      'x v kvadrate'
      'exponent x')
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 16
    Top = 128
    Width = 249
    Height = 153
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object Button1: TButton
    Left = 104
    Top = 304
    Width = 75
    Height = 25
    Caption = 'RUN'
    TabOrder = 5
    OnClick = Button1Click
  end
end
