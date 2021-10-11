object FormMain: TFormMain
  Left = 345
  Top = 188
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1043#1088#1072#1092#1080#1082' '#1088#1072#1073#1086#1090#1099
  ClientHeight = 295
  ClientWidth = 396
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Label_: TLabel
    Left = 70
    Top = 3
    Width = 5
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button_1: TButton
    Left = 375
    Top = 1
    Width = 20
    Height = 20
    Caption = '?'
    TabOrder = 0
    OnClick = Button_1Click
  end
  object Panel_L: TPanel
    Left = 0
    Top = 205
    Width = 195
    Height = 90
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 1
    object Label_1: TLabel
      Left = 45
      Top = 2
      Width = 114
      Height = 16
      Caption = #1043#1088#1072#1092#1080#1082' '#1088#1072#1073#1086#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label_Work: TLabel
      Left = 72
      Top = 30
      Width = 25
      Height = 16
      Caption = #1056#1072#1073
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label_Relax: TLabel
      Left = 152
      Top = 30
      Width = 24
      Height = 16
      Caption = #1042#1099#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label_2: TLabel
      Left = 18
      Top = 45
      Width = 164
      Height = 16
      Caption = #1055#1077#1088#1074#1099#1081' '#1088#1072#1073#1086#1095#1080#1081' '#1076#1077#1085#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit_Work: TEdit
      Left = 30
      Top = 20
      Width = 25
      Height = 24
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '2'
    end
    object Edit_Relax: TEdit
      Left = 110
      Top = 20
      Width = 25
      Height = 24
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '2'
    end
    object UpDown_Relax_Day: TUpDown
      Left = 135
      Top = 20
      Width = 15
      Height = 24
      Associate = Edit_Relax
      Min = 1
      Max = 31
      Position = 2
      TabOrder = 2
      OnClick = UpDown_Relax_DayClick
    end
    object UpDown_Work_Day: TUpDown
      Left = 55
      Top = 20
      Width = 15
      Height = 24
      Associate = Edit_Work
      Min = 1
      Max = 31
      Position = 2
      TabOrder = 3
      OnClick = UpDown_Work_DayClick
    end
    object DateTimePicker_Work_Day: TDateTimePicker
      Left = 20
      Top = 60
      Width = 160
      Height = 24
      Date = 0.580343958332378000
      Time = 0.580343958332378000
      DateFormat = dfLong
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnChange = DateTimePicker_Work_DayChange
    end
  end
  object Panel_R: TPanel
    Left = 198
    Top = 205
    Width = 198
    Height = 90
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 2
    object Label_3: TLabel
      Left = 40
      Top = 5
      Width = 113
      Height = 16
      Caption = #1056#1072#1073#1086#1095#1080#1081' '#1084#1077#1089#1103#1094
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DateTimePicker_: TDateTimePicker
      Left = 25
      Top = 27
      Width = 150
      Height = 24
      Date = 0.550720844898023600
      Format = 'MMMM yyyy'
      Time = 0.550720844898023600
      DateFormat = dfLong
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnChange = DateTimePicker_Change
    end
    object Button_: TButton
      Left = 8
      Top = 57
      Width = 185
      Height = 25
      Caption = #1056#1072#1089#1095#1080#1090#1072#1090#1100' '#1075#1088#1072#1092#1080#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button_Click
    end
  end
  object XPManifest_: TXPManifest
    Left = 360
    Top = 120
  end
  object Timer_: TTimer
    OnTimer = Timer_Timer
    Left = 360
    Top = 160
  end
end
