object Form1: TForm1
  Left = 226
  Top = 255
  Width = 453
  Height = 317
  Caption = #1051#1072#1073'. '#1088#1072#1073'. 4, 453504, '#1056#1086#1074#1076#1086' '#1053#1080#1082#1086#1083#1072#1081
  Color = clMenu
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
    Left = 16
    Top = 40
    Width = 31
    Height = 13
    Caption = 'Count:'
  end
  object Label2: TLabel
    Left = 16
    Top = 16
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object Label3: TLabel
    Left = 16
    Top = 64
    Width = 61
    Height = 13
    Caption = 'Factory num:'
  end
  object Label4: TLabel
    Left = 384
    Top = 16
    Width = 23
    Height = 13
    Caption = 'Find:'
  end
  object Edit1: TEdit
    Left = 80
    Top = 32
    Width = 145
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 80
    Top = 8
    Width = 145
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 80
    Top = 56
    Width = 145
    Height = 21
    TabOrder = 2
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 352
    Top = 32
    Width = 81
    Height = 21
    TabOrder = 3
    Text = 'Edit4'
  end
  object Memo1: TMemo
    Left = 88
    Top = 88
    Width = 265
    Height = 153
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object Button1: TButton
    Left = 8
    Top = 88
    Width = 81
    Height = 57
    Caption = 'Create BASE'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 144
    Width = 81
    Height = 49
    Caption = 'Open BASE'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 192
    Width = 81
    Height = 49
    Caption = 'Save BASE'
    TabOrder = 7
    OnClick = Button3Click
  end
  object BitBtn7: TBitBtn
    Left = 8
    Top = 248
    Width = 425
    Height = 25
    TabOrder = 8
    Kind = bkClose
  end
  object btn1: TButton
    Left = 232
    Top = 8
    Width = 57
    Height = 73
    Caption = 'ADD'
    TabOrder = 9
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 288
    Top = 8
    Width = 57
    Height = 73
    Caption = 'Delete'
    TabOrder = 10
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 352
    Top = 56
    Width = 81
    Height = 25
    Caption = 'Find'
    TabOrder = 11
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 360
    Top = 88
    Width = 73
    Height = 49
    Caption = 'LineSearch'
    TabOrder = 12
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 360
    Top = 136
    Width = 73
    Height = 49
    Caption = 'Binary Search'
    TabOrder = 13
    OnClick = btn5Click
  end
  object btn6: TButton
    Left = 360
    Top = 184
    Width = 73
    Height = 57
    Caption = 'QuickSort'
    TabOrder = 14
    OnClick = btn6Click
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093'|*.dat'
    Left = 488
    Top = 304
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'|*.txt'
    Left = 456
    Top = 304
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.dat'
    Filter = #1060#1072#1081#1083' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093'|*.dat'
    Left = 520
    Top = 304
  end
end
