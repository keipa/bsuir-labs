object Form1: TForm1
  Left = 435
  Top = 225
  Width = 186
  Height = 371
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
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 49
    Height = 13
    Caption = 'Enterance'
  end
  object Edit1: TEdit
    Left = 88
    Top = 16
    Width = 65
    Height = 21
    TabOrder = 0
    Text = '5'
  end
  object Memo1: TMemo
    Left = 8
    Top = 40
    Width = 153
    Height = 249
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 296
    Width = 153
    Height = 25
    Caption = 'Fill + Sort Recursion'
    TabOrder = 2
    OnClick = Button1Click
  end
end
