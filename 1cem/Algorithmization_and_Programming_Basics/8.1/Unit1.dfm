object Form1: TForm1
  Left = 190
  Top = 114
  Width = 418
  Height = 532
  Caption = 'Lab 8 Rovdo 453504'
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
    Left = 48
    Top = 16
    Width = 45
    Height = 13
    Caption = 'Surname:'
  end
  object Label2: TLabel
    Left = 192
    Top = 16
    Width = 41
    Height = 13
    Caption = 'Address:'
  end
  object Label3: TLabel
    Left = 120
    Top = 48
    Width = 23
    Height = 13
    Caption = 'Date'
  end
  object Button1: TButton
    Left = 80
    Top = 456
    Width = 65
    Height = 33
    Caption = 'Open'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 96
    Top = 16
    Width = 81
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 240
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 104
    Width = 377
    Height = 153
    ColCount = 4
    FixedCols = 0
    RowCount = 9
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
    ColWidths = (
      25
      101
      131
      139)
  end
  object Button2: TButton
    Left = 152
    Top = 456
    Width = 73
    Height = 33
    Caption = 'Save'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 152
    Top = 72
    Width = 97
    Height = 25
    Caption = 'Add'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = Button3Click
  end
  object StringGrid2: TStringGrid
    Left = 16
    Top = 320
    Width = 377
    Height = 129
    ColCount = 4
    FixedCols = 0
    RowCount = 9
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 6
    ColWidths = (
      26
      114
      158
      64)
  end
  object Button5: TButton
    Left = 16
    Top = 272
    Width = 145
    Height = 25
    Caption = 'Show on screen'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 248
    Top = 272
    Width = 145
    Height = 25
    Caption = 'Save into file'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = Button6Click
  end
  object DateTimePicker2: TDateTimePicker
    Left = 152
    Top = 48
    Width = 113
    Height = 21
    Date = 41938.669018263890000000
    Time = 41938.669018263890000000
    TabOrder = 9
  end
  object BitBtn1: TBitBtn
    Left = 232
    Top = 456
    Width = 81
    Height = 33
    TabOrder = 10
    Kind = bkClose
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Dat file|*.dat|All files|*.*'
    Title = '??????? ???? ??????????'
    Left = 168
    Top = 272
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.dat'
    Filter = 'Dat file |*.dat|Text file|*.txt|All files|*.*'
    Title = '????????? ??????????'
    Left = 216
    Top = 272
  end
end
