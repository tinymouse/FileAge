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
    { Private �錾 }
    FSelected: TStringList;  { �I�����ꂽ�t�@�C��/�t�H���_�̃p�X }
  public
    { Public �錾 }
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
  { �ϐ��������� }
  FSelected := TStringList.Create;
  { �h���b�O���h���b�v��������� }
  DragAcceptFiles(Handle, True);
  { �t�H�[���̕\���ʒu�𕜌� }
  if ParamCount > 0 then
    Exit;
  IniFile.ReadFormPos('MainForm', 'Window', Self);
  IniFile.ReadFormSize('MainForm', 'Window', Self);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  { �ϐ������ }
  FSelected.Free;
  { �t�H�[���̕\���ʒu��ۑ� }
  if ParamCount > 0 then
    Exit;
  IniFile.WriteFormPos('MainForm', 'Window', Self);
  IniFile.WriteFormSize('MainForm', 'Window', Self);
end;

procedure TMainForm.RunCommand;
var
  n: Integer;
begin
  { ���C���t�H�[����\�������Ȃ� }
  Application.ShowMainForm := False;
  { �R�}���h���C���ϐ�����擾 }
  FSelected.Clear;
  for n := 1 to ParamCount do
    if ParamStr(n)[1] <> '-' then
      FSelected.Add(GetLongFileName(ParamStr(n)));
  if FSelected.Count = 0 then
    Exit;
  { �_�C�A���O��\�� }
  ShowFileAgeDlg;
end;

procedure TMainForm.OnAcceptFiles(var msg: TMessage);
var
  n: Integer;
  buf: array[0..MAX_PATH] of Char;
begin
  { �h���b�v���ꂽ�t�@�C��/�t�H���_���擾 }
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
  { �_�C�A���O��\�� }
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
    { �t�@�C��/�t�H���_�����݂��Ă��Ȃ���� }
    if not (FileExists(Path) or DirectoryExists(Path)) then
    begin
      MessageDlg(QuotedStr(Path) + ' �͑��݂��Ă��Ȃ��t�@�C��/�t�H���_�ł��B', mtError, [mbOK], 0);
      Exit;
    end;
    { �t�H���_�����[�g�Ȃ�� }
    if DirectoryExists(Path) and PathIsRoot(PChar(Path)) then
    begin
      MessageDlg(QuotedStr(Path) + ' �̓��[�g�t�H���_�ł��B����/�����͕ύX�ł��܂���B', mtError, [mbOK], 0);
      Exit;
    end;
  end;
  { �_�C�A���O��\�� }
  with TFileAgeDlg.Create(Self) do
  try
    Selected := FSelected;
    ShowModal;
  finally
    Free;
  end;
end;

end.
