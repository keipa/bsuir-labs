object Form1: TForm1
  Left = 192
  Top = 114
  Width = 312
  Height = 397
  Caption = #1051#1072#1073'.'#1088#1072#1073'.'#8470'7 '#1042#1072#1088#1080#1072#1085#1090' 15'
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
  object Memo1: TMemo
    Left = 16
    Top = 48
    Width = 273
    Height = 265
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 88
    Top = 320
    Width = 113
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Kind = bkClose
  end
  object Edit1: TEdit
    Left = 16
    Top = 16
    Width = 273
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
    OnKeyPress = Edit1KeyPress
  end
end
