object Form1: TForm1
  Left = 229
  Top = 119
  Width = 229
  Height = 453
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
    Left = 64
    Top = 64
    Width = 82
    Height = 13
    Caption = 'Vvedite diapason'
  end
  object Label2: TLabel
    Left = 8
    Top = 88
    Width = 26
    Height = 13
    Caption = 'From:'
  end
  object Label3: TLabel
    Left = 120
    Top = 88
    Width = 16
    Height = 13
    Caption = 'To:'
  end
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 185
    Height = 41
    Caption = 'Programma vavodit polindromi '
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 40
    Top = 88
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '120'
  end
  object Edit2: TEdit
    Left = 152
    Top = 88
    Width = 57
    Height = 21
    TabOrder = 2
    Text = '122'
  end
  object Memo1: TMemo
    Left = 8
    Top = 120
    Width = 201
    Height = 233
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 360
    Width = 201
    Height = 25
    Caption = 'Find polyndrom'
    TabOrder = 4
    OnClick = Button1Click
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 392
    Width = 201
    Height = 25
    TabOrder = 5
    Kind = bkClose
  end
end
