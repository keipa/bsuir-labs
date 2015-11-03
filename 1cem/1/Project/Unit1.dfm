object Form1: TForm1
  Left = 275
  Top = 208
  Width = 350
  Height = 456
  Caption = 'Form1'
  Color = clMedGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 16
    Top = 40
    Width = 74
    Height = 16
    Caption = 'Znachenie X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 75
    Height = 16
    Caption = 'Znachenie Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 120
    Width = 77
    Height = 16
    Caption = 'Znachenie Z '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 192
    Width = 45
    Height = 16
    Caption = 'Results'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 144
    Top = 32
    Width = 145
    Height = 22
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 144
    Top = 72
    Width = 145
    Height = 22
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 144
    Top = 112
    Width = 145
    Height = 22
    TabOrder = 2
    Text = 'Edit3'
  end
  object Button1: TButton
    Left = 128
    Top = 160
    Width = 75
    Height = 25
    Caption = 'RUN'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 208
    Width = 305
    Height = 121
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
end
