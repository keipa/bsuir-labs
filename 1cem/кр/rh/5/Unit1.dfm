object Form1: TForm1
  Left = 607
  Top = 251
  Width = 706
  Height = 415
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 32
    Width = 33
    Height = 21
    Caption = 'N = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 64
    Top = 32
    Width = 105
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object RadiouGroup1: TRadioGroup
    Left = 16
    Top = 72
    Width = 177
    Height = 113
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077', '#1095#1090#1086' '#1074#1072#1084' '#1085#1072#1076#1086
    ItemIndex = 0
    Items.Strings = (
      #1057#1091#1084#1084#1072' '#1094#1080#1092#1088
      #1055#1088#1086#1080#1079#1074#1077#1076#1077#1085#1080#1077' '#1094#1080#1092#1088)
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 16
    Top = 200
    Width = 193
    Height = 97
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Button1: TButton
    Left = 56
    Top = 312
    Width = 97
    Height = 33
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 3
    OnClick = Button1Click
  end
end
