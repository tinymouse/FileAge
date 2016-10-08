object MainForm: TMainForm
  Left = 192
  Top = 106
  Width = 480
  Height = 320
  Caption = #31777#21336#12501#12449#12452#12523#26085#26178#22793#26356
  Color = clBtnFace
  Font.Charset = SHIFTJIS_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #65325#65331' '#65328#12468#12471#12483#12463
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object pnlAccept: TPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 293
    Align = alClient
    BevelOuter = bvNone
    Caption = #12371#12371#12408#12501#12449#12452#12523'/'#12501#12457#12523#12480#12434#12489#12521#12483#12464#65286#12489#12525#12483#12503#12375#12390#19979#12373#12356#12290
    TabOrder = 0
  end
  object IniFile: TExIniFile
    BaseDir = bdAppData
    FileName = 'EzExpEx\FileAge.ini'
    Fence = fcNone
    CaseSensitive = False
    AutoUpdate = True
    Left = 50
    Top = 18
  end
  object XPManifest: TXPManifest
    Left = 50
    Top = 56
  end
end
