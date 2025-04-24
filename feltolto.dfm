object OptionsWin: TOptionsWin
  Left = 342
  Top = 323
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ScreenTEXT 1.13'
  ClientHeight = 489
  ClientWidth = 790
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 449
    Height = 193
    Lines.Strings = (
      'ScreenTEXT 1.1')
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object ScrollBar1: TScrollBar
    Left = 136
    Top = 232
    Width = 321
    Height = 16
    LargeChange = 10
    Max = 0
    PageSize = 0
    TabOrder = 1
    OnScroll = ScrollBar1Scroll
  end
  object ScrollBar2: TScrollBar
    Left = 40
    Top = 232
    Width = 89
    Height = 16
    Max = 10
    Min = -10
    PageSize = 0
    TabOrder = 2
  end
  object Button5: TButton
    Left = 8
    Top = 232
    Width = 25
    Height = 16
    Caption = '&S'
    TabOrder = 3
    OnClick = Button5Click
  end
  object Roll1: TRoll
    Left = 464
    Top = 8
    Width = 320
    Height = 473
    Memo = Memo1
    MirrorX = False
    MirrorY = False
    EnableJoyControl = False
    OnPositionChange = Roll1PositionChange
    JoyCenter = 0
    Style = False
    WorkWidth = 320
    WorkHeight = 0
    JoyStatus = 0
    MsgMode = False
  end
  object Button9: TButton
    Left = 376
    Top = 208
    Width = 81
    Height = 17
    Caption = 'Friss'#237't'
    TabOrder = 5
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 272
    Top = 208
    Width = 97
    Height = 17
    Caption = 'Sz'#246'veg file import'
    TabOrder = 6
    OnClick = Button10Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 256
    Width = 449
    Height = 225
    ActivePage = TabSheet5
    MultiLine = True
    TabIndex = 3
    TabOrder = 7
    object TabSheet1: TTabSheet
      Caption = 'Vez'#233'rl'#233's'
      object CheckBox3: TCheckBox
        Left = 8
        Top = 8
        Width = 145
        Height = 17
        Caption = 'Joystick enged'#233'lyezve'
        TabOrder = 0
        OnClick = CheckBox3Click
      end
      object CheckBox4: TCheckBox
        Left = 8
        Top = 32
        Width = 113
        Height = 17
        Caption = 'Anal'#243'g vez'#233'rl'#233's'
        TabOrder = 1
        OnClick = Checkbox4Click
      end
      object Button1: TButton
        Left = 240
        Top = 10
        Width = 193
        Height = 25
        Caption = 'Vez'#233'rl'#337' kalibr'#225'l'#225'sa'
        TabOrder = 2
        OnClick = Button1Click
      end
      object TrackBar1: TTrackBar
        Left = 8
        Top = 56
        Width = 217
        Height = 25
        Max = 2000
        Min = 100
        Orientation = trHorizontal
        Frequency = 100
        Position = 1000
        SelEnd = 0
        SelStart = 0
        TabOrder = 3
        TickMarks = tmBottomRight
        TickStyle = tsAuto
        OnChange = TrackBar1Change
      end
      object RadioButton1: TRadioButton
        Left = 8
        Top = 104
        Width = 129
        Height = 17
        Caption = 'Gombok: (Start/Stop)'
        Checked = True
        Enabled = False
        TabOrder = 4
        TabStop = True
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 8
        Top = 120
        Width = 161
        Height = 17
        Caption = 'Analog csak gombnyom'#225'ssal'
        Enabled = False
        TabOrder = 5
        OnClick = RadioButton1Click
      end
      object StaticText2: TStaticText
        Left = 8
        Top = 152
        Width = 217
        Height = 17
        AutoSize = False
        BorderStyle = sbsSunken
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Megjelen'#237't'#233's'
      ImageIndex = 1
      object CheckBox1: TCheckBox
        Left = 144
        Top = 44
        Width = 73
        Height = 17
        Caption = 'X t'#252'kr'#246'z'#233's'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 44
        Width = 73
        Height = 17
        Caption = 'Y t'#252'kr'#246'z'#233's'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object Runbutton: TButton
        Left = 8
        Top = 72
        Width = 209
        Height = 25
        Caption = 'Futtat MOST!'
        TabOrder = 2
        OnClick = RunbuttonClick
      end
      object StaticText1: TStaticText
        Left = 8
        Top = 108
        Width = 209
        Height = 33
        AutoSize = False
        BorderStyle = sbsSunken
        Caption = 'Fut'#225'si m'#243'd: K'
        TabOrder = 3
      end
      object Button2: TButton
        Left = 304
        Top = 40
        Width = 129
        Height = 25
        Caption = 'Alap bet'#369't'#237'pus'
        TabOrder = 4
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 304
        Top = 112
        Width = 129
        Height = 25
        Caption = 'Kiemelt bet'#369't'#237'pus'
        TabOrder = 5
        OnClick = Button2Click
      end
      object Button4: TButton
        Left = 304
        Top = 72
        Width = 129
        Height = 25
        Caption = 'H'#225'tt'#233'rsz'#237'n'
        TabOrder = 6
        OnClick = Button4Click
      end
      object Button6: TButton
        Left = 304
        Top = 144
        Width = 129
        Height = 25
        Caption = 'Kiemelt H'#225'tt'#233'rsz'#237'n'
        TabOrder = 7
        OnClick = Button4Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Preset'
      ImageIndex = 2
      object Button7: TButton
        Left = 8
        Top = 32
        Width = 57
        Height = 25
        Caption = 'Bet'#246'lt'#233's'
        TabOrder = 0
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 72
        Top = 32
        Width = 57
        Height = 25
        Caption = 'Ment'#233's'
        TabOrder = 1
        OnClick = Button8Click
      end
    end
    object TabSheet5: TTabSheet
      Caption = #220'zenet'
      ImageIndex = 4
      object Bevel1: TBevel
        Left = 192
        Top = -24
        Width = 9
        Height = 241
        Shape = bsLeftLine
      end
      object Bevel2: TBevel
        Left = 192
        Top = 104
        Width = 289
        Height = 9
        Shape = bsTopLine
      end
      object RadioButton3: TRadioButton
        Left = 16
        Top = 10
        Width = 16
        Height = 17
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = RadioButton3Click
      end
      object RadioButton4: TRadioButton
        Left = 16
        Top = 40
        Width = 161
        Height = 17
        Caption = 'Pontos id'#337' megjelen'#237't'#233'se'
        TabOrder = 1
        OnClick = RadioButton3Click
      end
      object RadioButton5: TRadioButton
        Left = 16
        Top = 72
        Width = 161
        Height = 17
        Caption = 'Visszasz'#225'ml'#225'l'#243' megjelen'#237't'#233'se'
        TabOrder = 2
        OnClick = RadioButton3Click
      end
      object Edit2: TEdit
        Left = 32
        Top = 94
        Width = 57
        Height = 21
        Enabled = False
        TabOrder = 3
        Text = '0'
        OnChange = Edit2Change
      end
      object UpDown1: TUpDown
        Left = 89
        Top = 94
        Width = 16
        Height = 21
        Associate = Edit2
        Enabled = False
        Min = 0
        Max = 7200
        Position = 0
        TabOrder = 4
        Wrap = False
        OnChangingEx = UpDown1ChangingEx
      end
      object Button11: TButton
        Left = 112
        Top = 94
        Width = 73
        Height = 20
        Caption = #218'jraind'#237't'
        TabOrder = 5
        OnClick = Button11Click
      end
      object ShowMessage: TCheckBox
        Left = 200
        Top = 112
        Width = 113
        Height = 17
        Caption = #220'zenet kirak'#225'sa'
        Enabled = False
        TabOrder = 6
        OnClick = ShowMessageClick
      end
      object CheckBox5: TCheckBox
        Left = 200
        Top = 8
        Width = 209
        Height = 17
        Caption = #220'zenetek bekapcsol'#225'sa a vez'#233'rl'#337'vel'
        Checked = True
        State = cbChecked
        TabOrder = 7
        OnClick = CheckBox5Click
      end
      object StaticText4: TStaticText
        Left = 32
        Top = 126
        Width = 153
        Height = 21
        Alignment = taCenter
        AutoSize = False
        BevelInner = bvSpace
        BorderStyle = sbsSunken
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object Panel1: TPanel
        Left = 200
        Top = 32
        Width = 233
        Height = 65
        Alignment = taRightJustify
        BevelOuter = bvNone
        BiDiMode = bdLeftToRight
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentBiDiMode = False
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 9
        object Label1: TLabel
          Left = 0
          Top = 8
          Width = 125
          Height = 13
          Caption = 'A vez'#233'rl'#337' 3. gombja...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RadioButton6: TRadioButton
          Left = 0
          Top = 24
          Width = 137
          Height = 17
          Caption = 'Megjelen'#237'ti az '#252'zenetet'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = RadioButton6Click
        end
        object RadioButton7: TRadioButton
          Left = 0
          Top = 40
          Width = 233
          Height = 17
          Caption = #193'tkapcsol az '#252'zenet '#233's a s'#250'g'#243'sz'#246'veg k'#246'z'#246'tt'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = RadioButton6Click
        end
      end
      object Edit1: TEdit
        Left = 32
        Top = 8
        Width = 153
        Height = 21
        TabOrder = 10
        OnChange = Edit1Change
      end
      object stopper_running: TCheckBox
        Left = 32
        Top = 152
        Width = 97
        Height = 17
        Caption = 'Fut'
        TabOrder = 11
        OnClick = stopper_runningClick
      end
      object stopper_autostop: TCheckBox
        Left = 32
        Top = 176
        Width = 113
        Height = 17
        Caption = #193'lljon meg null'#225'n'
        Checked = True
        State = cbChecked
        TabOrder = 12
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Info'
      ImageIndex = 3
      object Label2: TLabel
        Left = 8
        Top = 80
        Width = 87
        Height = 13
        Caption = 'Elm'#233'leti telitetts'#233'g:'
      end
      object ProgressBar1: TProgressBar
        Left = 8
        Top = 96
        Width = 425
        Height = 16
        Min = 0
        Max = 100
        Smooth = True
        TabOrder = 0
      end
    end
  end
  object StaticText3: TStaticText
    Left = 8
    Top = 208
    Width = 257
    Height = 17
    Alignment = taCenter
    AutoSize = False
    BorderStyle = sbsSunken
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 8
  end
  object Timer2: TTimer
    Interval = 40
    OnTimer = Timer2Timer
    Left = 616
    Top = 208
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 552
    Top = 208
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 584
    Top = 208
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'spr'
    Filter = 'GRT S'#250'g'#243'g'#233'p preset-ek|*.spr'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Preset megnyit'#225'sa'
    Left = 680
    Top = 208
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'spr'
    Filter = 'GRT S'#250'g'#243'g'#233'p preset-ek|*.spr'
    Options = [ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Title = 'Preset ment'#233'se'
    Left = 712
    Top = 208
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Sz'#246'veg f'#225'jlok|*.txt'
    Left = 680
    Top = 240
  end
  object Timer4: TTimer
    Interval = 100
    OnTimer = Timer4Timer
    Left = 648
    Top = 208
  end
end
