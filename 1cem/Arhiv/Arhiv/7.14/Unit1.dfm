object Form1: TForm1
  Left = 192
  Top = 114
  Width = 350
  Height = 355
  Caption = #1051#1072#1073'.'#1088#1072#1073'.'#8470'7 '#1075#1088'.712502 '#1058#1088#1077#1075#1091#1073#1086#1074' '#1042'.'#1042'.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 40
    Top = 8
    Width = 257
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'ComboBox1'
    OnClick = ComboBox1Click
    OnKeyPress = ComboBox1KeyPress
  end
  object Memo1: TMemo
    Left = 40
    Top = 40
    Width = 257
    Height = 209
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 120
    Top = 264
    Width = 97
    Height = 41
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Kind = bkClose
  end
end
