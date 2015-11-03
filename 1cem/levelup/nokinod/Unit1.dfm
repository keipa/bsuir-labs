object Form1: TForm1
  Left = 192
  Top = 117
  Width = 252
  Height = 455
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
  object Label1: TLabel
    Left = 80
    Top = 64
    Width = 86
    Height = 13
    Caption = 'Enter your number'
  end
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 217
    Height = 41
    Caption = 'Programma schitaet NOD i NOK'
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 8
    Top = 80
    Width = 105
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object Memo1: TMemo
    Left = 8
    Top = 208
    Width = 225
    Height = 161
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 376
    Width = 225
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 104
    Width = 225
    Height = 65
    Caption = 'Chto shchitaem'
    ItemIndex = 0
    Items.Strings = (
      'NAIBOLSHIY OBSHCHIY DELITEL'
      'NAIMENSHEE OBSHCHEE KRATNOE')
    TabOrder = 4
  end
  object Button1: TButton
    Left = 8
    Top = 176
    Width = 225
    Height = 25
    Caption = 'DO SOMETHING'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 120
    Top = 80
    Width = 113
    Height = 21
    TabOrder = 6
    Text = '1'
  end
end
