program FileAge;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  FileAgeDlg in 'FileAgeDlg.pas' {FileAgeDlg},
  Utils in 'Utils.pas',
  Util2 in 'Util2.pas' {DateTimeDiff: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '�ȒP�t�@�C�������ύX';
  Application.CreateForm(TMainForm, MainForm);
  { �R�}���h�s�Ƀp�����[�^�w�肪����� }
  if ParamCount > 0 then
    { �t�H�[����\������ }
    MainForm.RunCommand
  { �R�}���h�s�Ƀp�����[�^�w�肪�Ȃ���� }
  else
    { �t�H�[����\������ }
    Application.Run;
end.
