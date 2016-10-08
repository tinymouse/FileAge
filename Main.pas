unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ExIniFile, XPMan;

type
  TMainForm = class(TForm)
    pnlAccept: TPanel;
    IniFile: TExIniFile;
    XPManifest: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private 宣言 }
    FSelected: TStringList;  { 選択されたファイル/フォルダのパス }
  public
    { Public 宣言 }
    procedure RunCommand;
    procedure OnAcceptFiles(var msg: TMessage); message WM_DROPFILES;
    procedure ShowFileAgeDlg;
  end;

var
  MainForm: TMainForm;

implementation

uses
  FileCtrl, ShellApi,
  FileAgeDlg, Utils;

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  { 変数を初期化 }
  FSelected := TStringList.Create;
  { ドラッグ＆ドロップを受入する }
  DragAcceptFiles(Handle, True);
  { フォームの表示位置を復元 }
  if ParamCount > 0 then
    Exit;
  IniFile.ReadFormPos('MainForm', 'Window', Self);
  IniFile.ReadFormSize('MainForm', 'Window', Self);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  { 変数を解放 }
  FSelected.Free;
  { フォームの表示位置を保存 }
  if ParamCount > 0 then
    Exit;
  IniFile.WriteFormPos('MainForm', 'Window', Self);
  IniFile.WriteFormSize('MainForm', 'Window', Self);
end;

procedure TMainForm.RunCommand;
var
  n: Integer;
begin
  { メインフォームを表示させない }
  Application.ShowMainForm := False;
  { コマンドライン変数から取得 }
  FSelected.Clear;
  for n := 1 to ParamCount do
    if ParamStr(n)[1] <> '-' then
      FSelected.Add(GetLongFileName(ParamStr(n)));
  if FSelected.Count = 0 then
    Exit;
  { ダイアログを表示 }
  ShowFileAgeDlg;
end;

procedure TMainForm.OnAcceptFiles(var msg: TMessage);
var
  n: Integer;
  buf: array[0..MAX_PATH] of Char;
begin
  { ドロップされたファイル/フォルダを取得 }
  FSelected.Clear;
  for n := 0 to DragQueryFile(msg.WParam, $ffffffff, nil, 0) - 1 do
  begin
    if DragQueryFile(msg.WParam, n, buf, SizeOf(buf)) = 0 then
      Continue;
    FSelected.Add(String(buf));
  end;
  DragFinish(msg.WParam);
  if FSelected.Count = 0 then
    Exit;
  { ダイアログを表示 }
  ShowFileAgeDlg;
end;

procedure TMainForm.ShowFileAgeDlg;
var
  n: Integer;
  Path: String;
begin
  for n := 0 to FSelected.Count - 1 do
  begin
    Path := FSelected.Strings[n];
    { ファイル/フォルダが存在していなければ }
    if not (FileExists(Path) or DirectoryExists(Path)) then
    begin
      MessageDlg(QuotedStr(Path) + ' は存在していないファイル/フォルダです。', mtError, [mbOK], 0);
      Exit;
    end;
    { フォルダがルートならば }
    if DirectoryExists(Path) and PathIsRoot(PChar(Path)) then
    begin
      MessageDlg(QuotedStr(Path) + ' はルートフォルダです。日時/属性は変更できません。', mtError, [mbOK], 0);
      Exit;
    end;
  end;
  { ダイアログを表示 }
  with TFileAgeDlg.Create(Self) do
  try
    Selected := FSelected;
    ShowModal;
  finally
    Free;
  end;
end;

end.
