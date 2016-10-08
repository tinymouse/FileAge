object DateTimeDiff: TDateTimeDiff
  Left = 0
  Top = 0
  Width = 246
  Height = 35
  TabOrder = 0
  object edtYY: TEditEx
    Left = 8
    Top = 8
    Width = 22
    Height = 20
    TabOrder = 0
    Text = '0'
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object Label1: TLabel
    Left = 32
    Top = 12
    Width = 6
    Height = 12
    Caption = '/'
  end
  object edtMM: TEditEx
    Left = 42
    Top = 8
    Width = 22
    Height = 20
    TabOrder = 1
    Text = '0'
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object Label2: TLabel
    Left = 67
    Top = 12
    Width = 6
    Height = 12
    Caption = '/'
  end
  object edtDD: TEditEx
    Left = 76
    Top = 8
    Width = 22
    Height = 20
    TabOrder = 2
    Text = '0'
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object updnDate: TUpDown
    Left = 102
    Top = 8
    Width = 17
    Height = 20
    TabOrder = 3
    OnChangingEx = updnDateTimeChangingEx
  end
  object edtHH: TEditEx
    Left = 126
    Top = 8
    Width = 22
    Height = 20
    TabOrder = 4
    Text = '0'
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object Label3: TLabel
    Left = 153
    Top = 12
    Width = 2
    Height = 12
    Caption = ':'
  end
  object edtNN: TEditEx
    Left = 160
    Top = 8
    Width = 22
    Height = 20
    TabOrder = 5
    Text = '0'
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object Label4: TLabel
    Left = 187
    Top = 12
    Width = 2
    Height = 12
    Caption = ':'
  end
  object edtSS: TEditEx
    Left = 194
    Top = 8
    Width = 22
    Height = 20
    TabOrder = 6
    Text = '0'
    OnExit = EditExit
    OnKeyPress = EditKeyPress
  end
  object updnTime: TUpDown
    Left = 220
    Top = 8
    Width = 17
    Height = 20
    TabOrder = 7
    OnChangingEx = updnDateTimeChangingEx
  end
end
