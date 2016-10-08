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
  Application.Title := '簡単ファイル日時変更';
  Application.CreateForm(TMainForm, MainForm);
  { コマンド行にパラメータ指定があれば }
  if ParamCount > 0 then
    { フォームを表示せず }
    MainForm.RunCommand
  { コマンド行にパラメータ指定がなければ }
  else
    { フォームを表示する }
    Application.Run;
end.
