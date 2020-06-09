object Form1: TForm1
  Left = 192
  Top = 124
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 112
    Top = 88
    Width = 45
    Height = 21
    Caption = 'Ans ='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 376
    Top = 16
    Width = 145
    Height = 241
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 176
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object SaveDiaog1: TSaveDialog
    Filter = 'pas|*.pas'
    Left = 40
    Top = 16
  end
end
