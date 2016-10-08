unit FileAgeDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, SearchFile, ExIniFile, AppEvnts, Util2;

type
  TFileAgeDlg = class(TForm)
    bvlLine: TBevel;
    imgIcon: TImage;
    imgMulti: TImage;
    txtName: TLabel;
    edtName: TEdit;
    chkName: TCheckBox;
    lblPlace: TLabel;
    txtPlace: TLabel;
    chkDirectories: TCheckBox;
    chkFiles: TCheckBox;
    chkSubdirectories: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    btnSaveOption: TButton;
    PageControl: TPageControl;
    shtFileAge: TTabSheet;
    lblCreate: TLabel;
    datCreate: TDateTimePicker;
    timCreate: TDateTimePicker;
    chkCreate: TCheckBox;
    chkCreateFollowWrite: TCheckBox;
    lblLastWrite: TLabel;
    datLastWrite: TDateTimePicker;
    timLastWrite: TDateTimePicker;
    chkLastWrite: TCheckBox;
    btnResetTime: TButton;
    btnFollowAgeOriginal: TButton;
    lblLastAccess: TLabel;
    datLastAccess: TDateTimePicker;
    timLastAccess: TDateTimePicker;
    chkLastAccess: TCheckBox;
    chkAccessFollowWrite: TCheckBox;
    shtFileAttr: TTabSheet;
    chkReadOnly: TCheckBox;
    chkHidden: TCheckBox;
    chkSysFile: TCheckBox;
    chkArchive: TCheckBox;
    chkFileAttr: TCheckBox;
    shtExifAge: TTabSheet;
    lblOriginal: TLabel;
    datOriginal: TDateTimePicker;
    timOriginal: TDateTimePicker;
    chkOriginal: TCheckBox;
    lblDigitized: TLabel;
    datDigitized: TDateTimePicker;
    timDigitized: TDateTimePicker;
    chkDigitized: TCheckBox;
    chkDigitizedFollowOriginal: TCheckBox;
    lblUpdated: TLabel;
    datUpdated: TDateTimePicker;
    timUpdated: TDateTimePicker;
    chkUpdated: TCheckBox;
    chkUpdatedFollowOriginal: TCheckBox;
    chkResetTime: TCheckBox;
    chkFollowCreateAge: TCheckBox;
    chkFollowAgeOriginal: TCheckBox;
    shtExport: TTabSheet;
    grpItems: TGroupBox;
    ExportItemList: TListView;
    btnItemsUp: TButton;
    btnItemsDown: TButton;
    btnSaveItems: TButton;
    btnExportFileAgeAttr: TButton;
    btnCopyFileAgeAttr: TButton;
    ExportFileAgeAttrDlg: TSaveDialog;
    chkItemName: TCheckBox;
    radAll: TRadioButton;
    radEach: TRadioButton;
    DatFile: TExIniFile;
    shtGeneral: TTabSheet;
    lblCreated: TLabel;
    datCreated: TDateTimePicker;
    timCreated: TDateTimePicker;
    chkCreated: TCheckBox;
    chkCreatedFollow: TCheckBox;
    lblSaved: TLabel;
    datSaved: TDateTimePicker;
    timSaved: TDateTimePicker;
    chkSaved: TCheckBox;
    chkSavedFollow: TCheckBox;
    chkFollowCreated: TCheckBox;
    chkFollowSaved: TCheckBox;
    shtPdfAge: TTabSheet;
    lblCreation: TLabel;
    datCreation: TDateTimePicker;
    timCreation: TDateTimePicker;
    chkCreation: TCheckBox;
    lblMod: TLabel;
    datMod: TDateTimePicker;
    timMod: TDateTimePicker;
    chkMod: TCheckBox;
    chkFollowCreation: TCheckBox;
    chkFollowMod: TCheckBox;
    btnSetNow: TButton;
    radDiff: TRadioButton;
    difCreate: TDateTimeDiff;
    difLastWrite: TDateTimeDiff;
    difLastAccess: TDateTimeDiff;
    difOriginal: TDateTimeDiff;
    difDigitized: TDateTimeDiff;
    difUpdated: TDateTimeDiff;
    difCreated: TDateTimeDiff;
    difSaved: TDateTimeDiff;
    difCreation: TDateTimeDiff;
    difMod: TDateTimeDiff;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure dattimLastWriteChange(Sender: TObject);
    procedure chkLastWriteClick(Sender: TObject);
    procedure btnResetTimeClick(Sender: TObject);
    procedure dattimCreateChange(Sender: TObject);
    procedure chkCreateClick(Sender: TObject);
    procedure chkCreateFollowWriteClick(Sender: TObject);
    procedure dattimLastAccessChange(Sender: TObject);
    procedure chkLastAccessClick(Sender: TObject);
    procedure chkAccessFollowWriteClick(Sender: TObject);
    procedure chkDirectoriesClick(Sender: TObject);
    procedure chkFilesClick(Sender: TObject);
    procedure chkAttrClick(Sender: TObject);
    procedure chkFileAttrClick(Sender: TObject);
    procedure btnSaveOptionClick(Sender: TObject);
    procedure btnFollowAgeOriginalClick(Sender: TObject);
    procedure dattimOriginalChange(Sender: TObject);
    procedure chkOriginalClick(Sender: TObject);
    procedure chkDigitizedClick(Sender: TObject);
    procedure chkDigitizedFollowOriginalClick(Sender: TObject);
    procedure chkUpdatedClick(Sender: TObject);
    procedure chkUpdatedFollowOriginalClick(Sender: TObject);
    procedure dattimDigitizedChange(Sender: TObject);
    procedure dattimUpdatedChange(Sender: TObject);
    procedure radTargetSelect(Sender: TObject);
    procedure chkFollowCreateAgeClick(Sender: TObject);
    procedure chkFollowAgeOriginalClick(Sender: TObject);
    procedure chkResetTimeClick(Sender: TObject);
    procedure btnItemsUpClick(Sender: TObject);
    procedure btnItemsDownClick(Sender: TObject);
    procedure btnExportFileAgeAttrClick(Sender: TObject);
    procedure btnCopyFileAgeAttrClick(Sender: TObject);
    procedure btnSaveItemsClick(Sender: TObject);
    procedure ExportItemListDeletion(Sender: TObject; Item: TListItem);
    procedure PageControlMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PageControlDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure PageControlDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure dattimCreatedChange(Sender: TObject);
    procedure chkCreatedClick(Sender: TObject);
    procedure chkCreatedFollowClick(Sender: TObject);
    procedure chkFollowCreatedClick(Sender: TObject);
    procedure dattimSavedChange(Sender: TObject);
    procedure chkSavedClick(Sender: TObject);
    procedure chkSavedFollowClick(Sender: TObject);
    procedure chkFollowSavedClick(Sender: TObject);
    procedure dattimCreationChange(Sender: TObject);
    procedure chkCreationClick(Sender: TObject);
    procedure chkFollowCreationClick(Sender: TObject);
    procedure dattimModChange(Sender: TObject);
    procedure chkModClick(Sender: TObject);
    procedure chkFollowModClick(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
    procedure btnSetNowClick(Sender: TObject);
    procedure difCreateChange(Sender: TObject);
    procedure difLastWriteChange(Sender: TObject);
    procedure difLastAccessChange(Sender: TObject);
    procedure difOriginalChange(Sender: TObject);
    procedure difDigitizedChange(Sender: TObject);
    procedure difUpdatedChange(Sender: TObject);
    procedure difCreatedChange(Sender: TObject);
    procedure difSavedChange(Sender: TObject);
    procedure difCreationChange(Sender: TObject);
    procedure difModChange(Sender: TObject);
  private
    { Private 宣言 }
    FSelected: TStringList;  { 選択されたファイル/フォルダのパス }
    FTarget: TStringList;  { 対象となるファイル/フォルダのパス }
    FForce: Boolean;  { 強制的にフォルダの日時を変更するか }
    AgeUpdatedValid, AgeOriginalValid, AgeDigitizedValid: Boolean;
    AgeCreatedValid, AgeSavedValid: Boolean;
    CreationAgeValid, ModAgeValid: Boolean;
    FExportBuf: TStringList;  { ファイルに書出する内容 }
    procedure SetSelected(Selected: TStringList);
    function Modified: Boolean;
    function ChangeFileAgeAttr: Boolean;
    function ChangeSameAgeAttr: Boolean;
    function DiffFileAge: Boolean;
    procedure FindTarget;
    procedure FoundTarget(Sender: TObject; Name: String;
      Data: TSearchFileData; var Continue: Boolean);
    function ChangeEachFileAge: Boolean;
    procedure SetExportBuf;
  public
    { Public 宣言 }
    property Selected: TStringList read FSelected write SetSelected;
  end;

implementation

uses
  Main, StrUtils, FileCtrl, ShellApi, ShlObj, Utils, Clipbrd, DateUtils;

{$R *.DFM}

type
  TDelphiControl = class(TWinControl)
  public
    property Caption;
    property TabOrder;
  end;

type
  TExportItem = record
    Ident: String;
    Caption: String;
  end;

const
  ExportItems: array[0..16] of TExportItem =
    ((Ident: 'FileName'; Caption: 'ﾌｧｲﾙ名'),
     (Ident: 'Folder'; Caption: '場所'),
     (Ident: 'FullPath'; Caption: 'ﾌﾙﾊﾟｽ'),
     (Ident: 'CreateAge'; Caption: '作成日時'),
     (Ident: 'LastWriteAge'; Caption: '更新日時'),
     (Ident: 'LastAccessAge'; Caption: 'ｱｸｾｽ日時'),
     (Ident: 'ReadOnly'; Caption: '読み取り専用属性'),
     (Ident: 'Hidden'; Caption: '隠しﾌｧｲﾙ属性'),
     (Ident: 'SysFile'; Caption: 'ｼｽﾃﾑ ﾌｧｲﾙ属性'),
     (Ident: 'Archive'; Caption: 'ｱｰｶｲﾌﾞ属性'),
     (Ident: 'AgeOriginal'; Caption: 'Exif 撮影日時'),
     (Ident: 'AgeDigitized'; Caption: 'Exif ﾃﾞｼﾞﾀﾙ化日時'),
     (Ident: 'AgeUpdated'; Caption: 'Exif 変更日時'),
     (Ident: 'AgeCreated'; Caption: '概要の作成日時'),
     (Ident: 'AgeSaved'; Caption: '概要の保存日時'),
     (Ident: 'PdfCreateAge'; Caption: 'PDF の作成日時'),
     (Ident: 'PdfModAge'; Caption: 'PDF の更新日時'));

procedure TFileAgeDlg.FormCreate(Sender: TObject);
var
  n: Integer;
  ctrl: TDelphiControl;
  list: TStringList;
  item: TListItem;
  data: PString;
begin
  { 変数を生成 }
  FSelected := TStringList.Create;
  FTarget := TStringList.Create;
  FExportBuf := TStringList.Create;
  { キャプションを設定ファイルにより変更 }
  for n := 0 to Self.ComponentCount - 1 do
  begin
    ctrl := TDelphiControl(Self.Components[n]);
    if not DatFile.ValueExists('Caption', ctrl.Name) then
      continue;
    ctrl.Caption := DatFile.ReadStr('Caption', ctrl.Name, ctrl.Caption);
  end;
  list := TStringList.Create;
  DatFile.ReadSection('TabOrder', list);
  for n := 0 to list.Count - 1 do
  begin
    ctrl := TDelphiControl(Self.FindComponent(list.Strings[n]));
    if not Assigned(ctrl) then
      continue;
    ctrl.TabOrder := DatFile.ReadInt('TabOrder', list.Strings[n], ctrl.TabOrder);
  end;
  list.Free;
  { 書出する内容を設定 }
  list := TStringList.Create;
  list.Clear;
  for n := 0 to SizeOf(ExportItems) div SizeOf(TExportItem) - 1 do
  begin
    list.Add(ExportItems[n].Ident);
    list.Add(ExportItems[n].Caption);
    list.Add(BoolToStr(True));
  end;
  list.CommaText := MainForm.IniFile.ReadStr('FileAgeDlg', 'ExportItemList', list.CommaText);
  ExportItemList.Clear;
  for n := 0 to SizeOf(ExportItems) div SizeOf(TExportItem) - 1 do
  begin
    item := ExportItemList.Items.Add;
    item.Caption := list.Strings[n * 3 + 1];
    New(data);
    data^ := list.Strings[n * 3];
    item.Data := data;
    item.Checked := StrToBool(list.Strings[n * 3 + 2]);
  end;
  list.Free;
  chkItemName.Checked := MainForm.IniFile.ReadBool('FileAgeDlg', 'ExportItemName', True);
end;

procedure TFileAgeDlg.FormDestroy(Sender: TObject);
begin
  { 変数を破棄 }
  FSelected.Free;
  FTarget.Free;
  FExportBuf.Free;
end;

procedure TFileAgeDlg.FormShow(Sender: TObject);
var
  n, i: Integer;
begin
  { メインフォームが非表示のとき、タスクバーにアイコンを表示させない }
  if not Application.ShowMainForm then
    ShowWindow(Application.Handle, SW_HIDE);
  { 表示位置を復元 }
  MainForm.IniFile.ReadFormPos('FileAgeDlg', 'Window', Self);
  { タブ順序を復元 }
  for n := 0 to PageControl.PageCount - 1 do
  begin
    for i := 0 to PageControl.PageCount - 1 do
      if PageControl.Pages[i].Tag = MainForm.IniFile.ReadInt('FileAgeDlg', 'Page' + IntToStr(n) + '.Tag', PageControl.Pages[n].Tag) then
        break;
    PageControl.Pages[i].PageIndex := n;
  end;
  PageControl.ActivePage := shtFileAge;
  datLastWrite.SetFocus;
end;

procedure TFileAgeDlg.FormClose(Sender: TObject; var Action: TCloseAction);
var
  n: Integer;
begin
  { 表示位置を保存 }
  MainForm.IniFile.WriteFormPos('FileAgeDlg', 'Window', Self);
  { タブ順序を保存 }
  for n := 0 to PageControl.PageCount - 1 do
    MainForm.IniFile.WriteInt('FileAgeDlg', 'Page' + IntToStr(n) + '.Tag', PageControl.Pages[n].Tag);
end;

procedure TFileAgeDlg.SetSelected(Selected: TStringList);
var
  n: Integer;
  Path: String;
  CreateAge, Create, LastAccessAge, LastAccess, LastWriteAge, LastWrite: TDateTime;
  Attr: Integer;
  ReadOnly, Hidden, SysFile, Archive: TCheckBoxState;
  AgeUpdated, Updated, AgeOriginal, Original, AgeDigitized, Digitized: TDateTime;
  UpdatedValid, OriginalValid, DigitizedValid: Boolean;
  AgeCreated, Created, AgeSaved, Saved: TDateTime;
  CreatedValid, SavedValid: Boolean;
  CreationAge, Creation, ModAge, AgeMod: TDateTime;
  CreationValid, ModValid: Boolean;
  Icon: TIcon;
  ID: Word;
  Directories: Boolean;  { フォルダが選択されているか }
begin
  Directories := False;
  for n := 0 to Selected.Count - 1 do
  begin
    Path := Selected.Strings[n];
  { if not (FileExists(Path) or DirectoryExists(Path)) then
    begin
      MessageDlg(QuotedStr(Path) + ' は存在しないファイル/フォルダです', mtError, [mbOK], 0);
      Continue;
    end; }
    FSelected.Add(Path);
    FileGetAge(Path, Create, LastAccess, LastWrite);
    if Create = 0 then Create := EncodeDate(1980, 1, 1);
    if LastAccess = 0 then LastAccess := EncodeDate(1980, 1, 1);
    if LastWrite = 0 then LastWrite := EncodeDate(1980, 1, 1);
    Attr := FileGetAttr(Path);
    ExifGetAge(Path, Updated, UpdatedValid, Original, OriginalValid, Digitized, DigitizedValid);
    DocGetAge(Path, Created, CreatedValid, Saved, SavedValid);
    PdfGetAge(Path, Creation, CreationValid, AgeMod, ModValid);
    FileSetAge(Path, Create, False, LastAccess, True, LastWrite, False);  { ExifGetAge 、DocGetAge で変更されてしまったアクセス日時を元に戻す }
    if n = 0 then
    begin
      CreateAge := Create;
      LastAccessAge := LastAccess;
      LastWriteAge := LastWrite;
      if (Attr and faReadOnly) = faReadOnly then
        ReadOnly := cbChecked
      else
        ReadOnly := cbUnchecked;
      if (Attr and faHidden) = faHidden then
        Hidden := cbChecked
      else
        Hidden := cbUnchecked;
      if (Attr and faSysFile) = faSysFile then
        SysFile := cbChecked
      else
        SysFile := cbUnchecked;
      if (Attr and faArchive) = faArchive then
        Archive := cbChecked
      else
        Archive := cbUnchecked;
      if UpdatedValid then
        AgeUpdated := Updated;
      AgeUpdatedValid := UpdatedValid;
      if OriginalValid then
        AgeOriginal := Original;
      AgeOriginalValid := OriginalValid;
      if DigitizedValid then
        AgeDigitized := Digitized;
      AgeDigitizedValid := DigitizedValid;
      if CreatedValid then
        AgeCreated := Created;
      AgeCreatedValid := CreatedValid;
      if SavedValid then
        AgeSaved := Saved;
      AgeSavedValid := SavedValid;
      if CreationValid then
        CreationAge := Creation;
      CreationAgeValid := CreationValid;
      if ModValid then
        ModAge := AgeMod;
      ModAgeValid := ModValid;
    end
    else
    begin
      if Create > CreateAge then
        CreateAge := Create;
      if LastAccess > LastAccessAge then
        LastAccessAge := LastAccess;
      if LastWrite > LastWriteAge then
        LastWriteAge := LastWrite;
      if ReadOnly = cbChecked then
        if (FileGetAttr(Path) and faReadOnly) <> faReadOnly then
          ReadOnly := cbGrayed;
      if ReadOnly = cbUnchecked then
        if (FileGetAttr(Path) and faReadOnly) = faReadOnly then
          ReadOnly := cbGrayed;
      if Hidden = cbChecked then
        if (FileGetAttr(Path) and faHidden) <> faHidden then
          Hidden := cbGrayed;
      if Hidden = cbUnchecked then
        if (FileGetAttr(Path) and faHidden) = faHidden then
          Hidden := cbGrayed;
      if SysFile = cbChecked then
        if (FileGetAttr(Path) and faSysFile) <> faSysFile then
          SysFile := cbGrayed;
      if SysFile = cbUnchecked then
        if (FileGetAttr(Path) and faSysFile) = faSysFile then
          SysFile := cbGrayed;
      if Archive = cbChecked then
        if (FileGetAttr(Path) and faArchive) <> faArchive then
          Archive := cbGrayed;
      if Archive = cbUnchecked then
        if (FileGetAttr(Path) and faArchive) = faArchive then
          Archive := cbGrayed;
      if UpdatedValid then
        if Updated > AgeUpdated then
          AgeUpdated := Updated;
      AgeUpdatedValid := AgeUpdatedValid and UpdatedValid;
      if OriginalValid then
        if Original > AgeOriginal then
          AgeOriginal := Original;
      AgeOriginalValid := AgeOriginalValid and OriginalValid;
      if DigitizedValid then
        if Digitized > AgeDigitized then
          AgeDigitized := Digitized;
      AgeDigitizedValid := AgeDigitizedValid and DigitizedValid;
      if CreatedValid then
        if Created > AgeCreated then
          AgeCreated := Created;
      AgeCreatedValid := AgeCreatedValid and CreatedValid;
      if SavedValid then
        if Saved > AgeSaved then
          AgeSaved := Saved;
      AgeSavedValid := AgeSavedValid and SavedValid;
      if CreationValid then
        if Creation > CreationAge then
          CreationAge := Creation;
      CreationAgeValid := CreationAgeValid and CreationValid;
      if ModValid then
        if AgeMod > ModAge then
          ModAge := AgeMod;
      ModAgeValid := ModAgeValid and ModValid;
    end;
    if DirectoryExists(Path) then
    begin
      Directories := True;
    end;
  end;
  { 複数のファイル/フォルダが選択されていれば }
  if FSelected.Count > 1 then
  begin
    txtName.Caption := '(複数のﾌｧｲﾙ/ﾌｫﾙﾀﾞ)';
    txtName.Visible := True;
    edtName.Visible := False;
    chkName.Checked := False;
    chkName.Enabled := False;
    imgIcon.Picture.Assign(imgMulti.Picture);
    txtPlace.Caption := MinimizeName(ExtractFileDir(FSelected.Strings[0]), txtPlace.Canvas, txtPlace.Width);
  end
  { そうでなければ }
  else
  begin
    edtName.Text := ExtractFileName(Path);
    txtName.Visible := False;
    edtName.Visible := True;
    chkName.Checked := False;
    chkName.Enabled := True;
    Icon:= TIcon.Create;
    try
      Icon.Handle := ExtractAssociatedIcon(hInstance, PChar(FSelected.Strings[0]), ID);
      if not (Icon.Handle = 0) then
        imgIcon.Picture.Icon.Assign(Icon);
    finally
      Icon.Free;
    end;
    txtPlace.Caption := MinimizeName(ExtractFileDir(FSelected.Strings[0]), txtPlace.Canvas, txtPlace.Width);
  end;
  { フォルダが選択されていれば }
  if Directories then
  begin
    chkDirectories.Enabled := True;
    chkFiles.Enabled := True;
    chkSubdirectories.Enabled := True;
    { オプション指定を設定ファイルから取得あるいは初期値を設定 }
    chkDirectories.Checked := MainForm.IniFile.ReadBool('FileAge', 'Directories', True);
    chkFiles.Checked := MainForm.IniFile.ReadBool('FileAge', 'Files', False);
    chkSubdirectories.Checked := MainForm.IniFile.ReadBool('FileAge', 'Subdirectories', False);
  end
  else
  { そうでなければ }
  begin
    chkDirectories.Checked := False;
    chkDirectories.Enabled := False;
    chkFiles.Checked := False;
    chkFiles.Enabled := False;
    chkSubdirectories.Checked := False;
    chkSubdirectories.Enabled := False;
  end;
  { ... }
  datCreate.Date := TDate(CreateAge);
  timCreate.Time := TTime(CreateAge);
  difCreate.Reset;
  chkCreate.Checked := False;
  datLastAccess.Date := TDate(LastAccessAge);
  timLastAccess.Time := TTime(LastAccessAge);
  difLastWrite.Reset;
  chkLastAccess.Checked := False;
  datLastWrite.Date := TDate(LastWriteAge);
  timLastWrite.Time := TTime(LastWriteAge);
  difLastAccess.Reset;
  chkLastWrite.Checked := False;
  chkReadOnly.State := ReadOnly;
  chkHidden.State := Hidden;
  chkSysFile.State := SysFile;
  chkArchive.State := Archive;
  chkFileAttr.Checked := False;
  btnFollowAgeOriginal.Enabled := AgeOriginalValid;
  datOriginal.Enabled := AgeOriginalValid;
  timOriginal.Enabled := AgeOriginalValid;
  difOriginal.Enabled := AgeOriginalValid;
  if AgeOriginalValid then
  begin
    datOriginal.DateTime := TDateTime(AgeOriginal);
    timOriginal.DateTime := TDateTime(AgeOriginal);
  end else begin
    datOriginal.DateTime := 0;
    timOriginal.DateTime := 0;
  end;
  difOriginal.Reset;
  chkOriginal.Enabled := AgeOriginalValid;
  chkOriginal.Checked := False;
  datDigitized.Enabled := AgeDigitizedValid;
  timDigitized.Enabled := AgeDigitizedValid;
  difDigitized.Enabled := AgeDigitizedValid;
  if AgeDigitizedValid then
  begin
    datDigitized.DateTime := TDateTime(AgeDigitized);
    timDigitized.DateTime := TDateTime(AgeDigitized);
  end else begin
    datDigitized.DateTime := 0;
    timDigitized.DateTime := 0;
  end;
  difDigitized.Reset;
  chkDigitized.Enabled := AgeDigitizedValid;
  chkDigitized.Checked := False;
  chkDigitizedFollowOriginal.Enabled := AgeDigitizedValid;
  chkDigitizedFollowOriginal.Checked := False;
  datUpdated.Enabled := AgeUpdatedValid;
  timUpdated.Enabled := AgeUpdatedValid;
  difUpdated.Enabled := AgeUpdatedValid;
  if AgeUpdatedValid then
  begin
    datUpdated.DateTime := TDateTime(AgeUpdated);
    timUpdated.DateTime := TDateTime(AgeUpdated);
  end else begin
    datUpdated.DateTime := 0;
    timUpdated.DateTime := 0;
  end;
  difUpdated.Reset;
  chkUpdated.Enabled := AgeUpdatedValid;
  chkUpdated.Checked := False;
  chkUpdatedFollowOriginal.Enabled := AgeUpdatedValid;
  chkUpdatedFollowOriginal.Checked := False;
  datCreated.Enabled := AgeCreatedValid;
  timCreated.Enabled := AgeCreatedValid;
  difCreated.Enabled := AgeCreatedValid;
  if AgeCreatedValid then
  begin
    datCreated.DateTime := TDateTime(AgeCreated);
    timCreated.DateTime := TDateTime(AgeCreated);
  end else begin
    datCreated.DateTime := 0;
    timCreated.DateTime := 0;
  end;
  difCreated.Reset;
  chkCreated.Enabled := AgeCreatedValid;
  chkCreated.Checked := False;
  chkCreatedFollow.Enabled := AgeCreatedValid;
  chkCreatedFollow.Checked := False;
  chkFollowCreated.Enabled := AgeCreatedValid;
  chkFollowCreated.Checked := False;
  datSaved.Enabled := AgeSavedValid;
  timSaved.Enabled := AgeSavedValid;
  difSaved.Enabled := AgeSavedValid;
  difSaved.Enabled := AgeSavedValid;
  if AgeSavedValid then
  begin
    datSaved.DateTime := TDateTime(AgeSaved);
    timSaved.DateTime := TDateTime(AgeSaved);
  end else begin
    datSaved.DateTime := 0;
    timSaved.DateTime := 0;
  end;
  difSaved.Reset;
  chkSaved.Enabled := AgeSavedValid;
  chkSaved.Checked := False;
  chkSavedFollow.Enabled := AgeSavedValid;
  chkSavedFollow.Checked := False;
  chkFollowSaved.Enabled := AgeSavedValid;
  chkFollowSaved.Checked := False;
  datCreation.Enabled := CreationAgeValid;
  timCreation.Enabled := CreationAgeValid;
  difCreation.Enabled := CreationAgeValid;
  if CreationAgeValid then
  begin
    datCreation.DateTime := TDateTime(CreationAge);
    timCreation.DateTime := TDateTime(CreationAge);
  end else begin
    datCreation.DateTime := 0;
    timCreation.DateTime := 0;
  end;
  difCreation.Reset;
  chkCreation.Enabled := CreationAgeValid;
  chkCreation.Checked := False;
  chkFollowCreation.Enabled := CreationValid;
  chkFollowCreation.Checked := False;
  datMod.Enabled := ModAgeValid;
  timMod.Enabled := ModAgeValid;
  difMod.Enabled := ModAgeValid;
  if ModAgeValid then
  begin
    datMod.DateTime := TDateTime(ModAge);
    timMod.DateTime := TDateTime(ModAge);
  end else begin
    datMod.DateTime := 0;
    timMod.DateTime := 0;
  end;
  difMod.Reset;
  chkMod.Enabled := ModAgeValid;
  chkMod.Checked := False;
  chkFollowMod.Enabled := ModAgeValid;
  chkFollowMod.Checked := False;
  { 複数のファイル/フォルダが選択、あるいはフォルダが選択されていれば }
  if (FSelected.Count > 1) or Directories then
  begin
  { radAll.Enabled := True; }
    radEach.Enabled := True;
  end else begin
  { radAll.Enabled := False; }
    radEach.Enabled := False;
  end;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
  { オプション指定を設定ファイルから取得あるいは初期値を設定 }
  chkCreate.Checked := MainForm.IniFile.ReadBool('FileAge', 'Create', False);
  chkCreateFollowWrite.Checked := MainForm.IniFile.ReadBool('FileAge', 'CreateFollowWrite', False);
  chkLastWrite.Checked := MainForm.IniFile.ReadBool('FileAge', 'LastWrite', False);
  chkFollowCreateAge.Checked := MainForm.IniFile.ReadBool('FileAge', 'FollowCreateAge', False);
  chkLastAccess.Checked := MainForm.IniFile.ReadBool('FileAge', 'LastAccess', False);
  chkAccessFollowWrite.Checked := MainForm.IniFile.ReadBool('FileAge', 'AccessFollowWrite', False);
  FForce := SameText(MainForm.IniFile.ReadStr('FileAge', 'Force', 'No'), 'yes');
  FForce := FindCmdLineSwitch('force', FForce);
  radAll.Checked := True;
end;

function TFileAgeDlg.Modified: Boolean;
begin
  Result := (chkCreate.Checked or chkLastWrite.Checked or chkLastAccess.Checked or
    chkFileAttr.Checked or
    chkOriginal.Checked or chkDigitized.Checked or chkUpdated.Checked or
    chkCreated.Checked or chkSaved.Checked or
    chkCreation.Checked or chkMod.Checked or
    chkName.Checked);
end;

function TFileAgeDlg.ChangeFileAgeAttr: Boolean;
begin
  if radDiff.Checked then
    Result := DiffFileAge
  else if radAll.Checked then
    Result := ChangeSameAgeAttr
  else
    Result := ChangeEachFileAge;
end;

function TFileAgeDlg.ChangeSameAgeAttr: Boolean;
var
  n: Integer;
  Path: String;
  CreateAge, LastAccessAge, LastWriteAge: TDateTime;
  Attr: Integer;
  AgeUpdated, AgeOriginal, AgeDigitized: TDateTime;
  AgeCreated, AgeSaved: TDateTime;
  CreationAge, ModAge: TDateTime;
begin
  Result := False;
  { 指定した日付が1980/01/01以前の場合 }
  ReplaceDate(CreateAge, datCreate.Date);
  ReplaceTime(CreateAge, timCreate.Time);
  ReplaceDate(LastWriteAge, datLastWrite.Date);
  ReplaceTime(LastWriteAge, timLastWrite.Time);
  ReplaceDate(LastAccessAge, datLastAccess.Date);
  ReplaceTime(LastAccessAge, timLastAccess.Time);
  if (chkCreate.Checked and (CreateAge < EncodeDate(1980, 1, 1))) or
    (chkLastWrite.Checked and (LastWriteAge < EncodeDate(1980, 1, 1))) or
    (chkLastAccess.Checked and (LastAccessAge < EncodeDate(1980, 1, 1))) then
  begin
    MessageDlg('ごめんなさい。1980/01/01 以前には変更できません', mtError, [mbOK], 0);
    Exit;
  end;
  { ... }
  if (chkCreate.Checked or chkLastWrite.Checked or chkLastAccess.Checked) and
    chkDirectories.Checked then
    for n := 0 to FSelected.Count - 1 do
    begin
      Path := FSelected.Strings[n];
      { ネットワーク上のフォルダなら }
      if DirectoryExists(Path) and PathIsUNC(PChar(ExpandUNCFileName(Path))) then
      begin
        if FForce and OsIsWinNt then
          { 何もしない }
        else
        begin
          MessageDlg(QuotedStr(Path) + ' はネットワーク上のフォルダです。'
            + '日時は変更できません。', mtError, [mbOK], 0);
          chkDirectories.Checked := False;
        end;
        Break;
      end;
  end;
  { 隠し＋ｼｽﾃﾑ ﾌｧｲﾙ属性を指定した場合 }
  if chkFileAttr.Checked
    and (chkHidden.Checked or (chkHidden.State = cbGrayed))
    and (chkSysFile.Checked or (chkSysFile.State = cbGrayed)) then
  begin
    if MessageDlg('隠し属性とシステム属性を同時に設定するとエクスプローラでﾌｧｲﾙ/ﾌｫﾙﾀﾞがみられなくなります'
      + #13#10#13#10 + '属性を変更しますか', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
  end;
  { 隠し属性を指定した場合 }
  if chkFileAttr.Checked
    and chkHidden.Checked then
    if MessageDlg('隠し属性を設定するとエクスプローラでﾌｧｲﾙ/ﾌｫﾙﾀﾞがみられなくなる可能性があります'
      + #13#10#13#10 + '属性を変更しますか', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
  { 対象となるファイル/フォルダを検索 }
  FindTarget;
  { 日時/属性を変更 }
  for n := 0 to FTarget.Count - 1 do
  begin
    Path := FTarget.Strings[n];
    { 日時を変更 }
    if chkCreate.Checked or
      chkLastWrite.Checked or
      chkLastAccess.Checked then
    begin
      ReplaceDate(CreateAge, datCreate.Date);
      ReplaceTime(CreateAge, timCreate.Time);
      ReplaceDate(LastAccessAge, datLastAccess.Date);
      ReplaceTime(LastAccessAge, timLastAccess.Time);
      ReplaceDate(LastWriteAge, datLastWrite.Date);
      ReplaceTime(LastWriteAge, timLastWrite.Time);
      if not FileSetAge(Path, CreateAge, chkCreate.Checked, LastAccessAge, chkLastAccess.Checked, LastWriteAge, chkLastWrite.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    end;
    { 属性を変更 }
    if chkFileAttr.Checked then
    begin
      Attr := FileGetAttr(Path);
      if chkReadOnly.State = cbChecked then
        Attr := Attr or faReadOnly;
      if chkReadOnly.State = cbUnchecked then
        Attr := Attr and not faReadOnly;
      if chkHidden.State = cbChecked then
        Attr := Attr or faHidden;
      if chkHidden.State = cbUnchecked then
        Attr := Attr and not faHidden;
      if chkSysFile.State = cbChecked then
        Attr := Attr or faSysFile;
      if chkSysFile.State = cbUnchecked then
        Attr := Attr and not faSysFile;
      if chkArchive.State = cbChecked then
        Attr := Attr or faArchive;
      if chkArchive.State = cbUnchecked then
        Attr := Attr and not faArchive;
      if FileSetAttr(Path, Attr) <> 0 then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の属性は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の属性は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end;
      end;
    end;
    { Exif 日時を変更 }
    if chkOriginal.Checked
      or chkDigitized.Checked
      or chkUpdated.Checked then
    try
      ReplaceDate(AgeUpdated, datUpdated.Date);
      ReplaceTime(AgeUpdated, timUpdated.Time);
      ReplaceDate(AgeOriginal, datOriginal.Date);
      ReplaceTime(AgeOriginal, timOriginal.Time);
      ReplaceDate(AgeDigitized, datDigitized.Date);
      ReplaceTime(AgeDigitized, timDigitized.Time);
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      if not ExifSetAge(Path, AgeUpdated, chkUpdated.Checked, AgeOriginal, chkOriginal.Checked, AgeDigitized, chkDigitized.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
    { 概要情報を変更 }
    if chkCreated.Checked
      or chkSaved.Checked then
    try
      ReplaceDate(AgeCreated, datCreated.Date);
      ReplaceTime(AgeCreated, timCreated.Time);
      ReplaceDate(AgeSaved, datSaved.Date);
      ReplaceTime(AgeSaved, timSaved.Time);
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      if not DocSetAge(Path, AgeCreated, chkCreated.Checked, AgeSaved, chkSaved.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
    { PDF 日時を変更 }
    if chkCreation.Checked
      or chkMod.Checked then
    try
      ReplaceDate(CreationAge, datCreation.Date);
      ReplaceTime(CreationAge, timCreation.Time);
      ReplaceDate(ModAge, datMod.Date);
      ReplaceTime(ModAge, timMod.Time);
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      if not PdfSetAge(Path, CreationAge, chkCreation.Checked, ModAge, chkMod.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
  end;
  { ファイル名を変更 }
  if chkName.Checked then
    if not RenameFile(FSelected.Strings[0], ExtractFilePath(FSelected.Strings[0]) + edtName.Text) then
      MessageDlg(QuotedStr(FSelected.Strings[0]) + ' の名前は変更できませんでした。', mtError, [mbOK], 0)
    else
      FSelected.Strings[0] := ExtractFilePath(FSelected.Strings[0]) + edtName.Text;
  { エクスプローラを強制的に再表示 }
  SHChangeNotify(SHCNE_UPDATEDIR, SHCNF_PATH, PChar(ExtractFileDir(Path)), nil);
  SHChangeNotify(SHCNE_UPDATEDIR, SHCNF_FLUSH, nil, nil);
  { ... }
  chkCreate.Checked := False;
  chkLastWrite.Checked := False;
  chkLastAccess.Checked := False;
  chkFileAttr.Checked := False;
  chkOriginal.Checked := False;
  chkDigitized.Checked := False;
  chkUpdated.Checked := False;
  chkCreated.Checked := False;
  chkSaved.Checked := False;
  chkCreation.Checked := False;
  chkMod.Checked := False;
  chkName.Checked := False;
  Result := True;
end;

procedure TFileAgeDlg.FindTarget;
var
  n: Integer;
  Path: String;
begin
  FTarget.Clear;
  for n := 0 to FSelected.Count - 1 do
  begin
    Path := FSelected.Strings[n];
    { フォルダ内のファイルの日時/属性を変更する指定、あるいは }
    { 下層のフォルダも対象とするする指定があれば }
    if chkFiles.Checked
      or chkSubdirectories.Checked then
      with TSearchFile.Create(Self) do
      try
        Directory := Path;
        SearchName := '*.*';
        { 下層のフォルダも対象とする指定があれば }
        Recursive := chkSubdirectories.Checked;
        OnFind := FoundTarget;
        Search;
      finally
        Free;
      end;
    { フォルダの日時/属性を変更する指定がなくて }
    { フォルダが選択されていれば }
    if not chkDirectories.Checked then
      if DirectoryExists(Path) then
        Continue;
    { 対象となるファイル/フォルダに追加 }
    FTarget.Add(Path);
  end;
end;

procedure TFileAgeDlg.FoundTarget(Sender: TObject; Name: String;
  Data: TSearchFileData; var Continue: Boolean);
begin
  { フォルダ内のファイルの日時/属性を変更する指定がなくて }
  { ファイルが選択されていれば }
  if not chkFiles.Checked then
    if not Data.IsDirectory then
      Exit;
  { フォルダの日時/属性を変更する指定がなくて }
  { フォルダが選択されていれば }
  if not chkDirectories.Checked then
    if Data.IsDirectory then
      Exit;
  { 下層のフォルダも対象とする指定がなくて }
  { フォルダが選択されていれば }
  if not chkSubdirectories.Checked then
    if Data.IsDirectory then
      Exit;
  { 対象となるファイル/フォルダに追加 }
  FTarget.Add(Name);
end;

procedure TFileAgeDlg.btnOkClick(Sender: TObject);
begin
  btnOk.SetFocus;
  { 日時/属性を変更 }
  if not ChangeFileAgeAttr then
    Exit;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
  { ダイアログボックスを閉じる }
  Close;
end;

procedure TFileAgeDlg.btnCancelClick(Sender: TObject);
begin
  { ダイアログボックスを閉じる }
  Close;
end;

procedure TFileAgeDlg.btnApplyClick(Sender: TObject);
begin
  if not Modified then
    Exit;
  { 日時/属性を変更 }
  if not ChangeFileAgeAttr then
    Exit;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimLastWriteChange(Sender: TObject);
begin
  chkLastWrite.Checked := True;
  if chkCreateFollowWrite.Checked then
  begin
    datCreate.Date := datLastWrite.Date;
    timCreate.Time := timLastWrite.Time;
    chkCreate.Checked := True;
  end;
  if chkAccessFollowWrite.Checked then
  begin
    datLastAccess.Date := datLastWrite.Date;
    timLastAccess.Time := timLastWrite.Time;
    chkLastAccess.Checked := True;
  end;
  if chkSaved.Checked and chkSavedFollow.Checked then
  begin
    datSaved.Date := datLastWrite.Date;
    timSaved.Time := timLastWrite.Time;
    chkSaved.Checked := True;
  end;
  chkFollowCreateAge.Checked := False;
  chkFollowSaved.Checked := False;
  chkFollowMod.Checked := False;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkLastWriteClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.btnResetTimeClick(Sender: TObject);
begin
  timLastWrite.Time := 0;
  chkLastWrite.Checked := True;
  if chkCreateFollowWrite.Checked then
  begin
    timCreate.Time := 0;
    chkCreate.Checked := True;
  end;
  if chkAccessFollowWrite.Checked then
  begin
    timLastAccess.Time := 0;
    chkLastAccess.Checked := True;
  end;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimCreateChange(Sender: TObject);
begin
  chkCreate.Checked := True;
  if chkFollowCreateAge.Checked then
  begin
    datLastWrite.Date := datCreate.Date;
    timLastWrite.Time := timCreate.Time;
    chkLastWrite.Checked := True;
    if chkAccessFollowWrite.Checked then
    begin
      datLastAccess.Date := datLastWrite.Date;
      timLastAccess.Time := timLastWrite.Time;
      chkLastAccess.Checked := True;
    end;
  end;
  if chkCreated.Checked and chkCreatedFollow.Checked then
  begin
    datCreated.Date := datCreate.Date;
    timCreated.Time := timCreate.Time;
    chkCreated.Checked := True;
  end;
  chkCreateFollowWrite.Checked := False;
  chkFollowCreated.Checked := False;
  chkFollowCreation.Checked := False;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkCreateClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkCreateFollowWriteClick(Sender: TObject);
begin
  if chkCreateFollowWrite.Checked then
  begin
    datCreate.Date := datLastWrite.Date;
    timCreate.Time := timLastWrite.Time;
    chkCreate.Checked := True;
  end;
  if chkCreateFollowWrite.Checked then
    chkFollowCreateAge.Checked := False;
  if radEach.Checked then
    chkCreate.Checked := chkCreateFollowWrite.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimLastAccessChange(Sender: TObject);
begin
  chkLastAccess.Checked := True;
  chkAccessFollowWrite.Checked := False;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkLastAccessClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkAccessFollowWriteClick(Sender: TObject);
begin
  if chkAccessFollowWrite.Checked then
  begin
    datLastAccess.Date := datLastWrite.Date;
    timLastAccess.Time := timLastWrite.Time;
    chkLastAccess.Checked := True;
  end;
  if radEach.Checked then
    chkLastAccess.Checked := chkAccessFollowWrite.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkDirectoriesClick(Sender: TObject);
var
  n: Integer;
  Path: String;
begin
  if chkDirectories.Checked or chkFiles.Checked then
    chkSubdirectories.Enabled := True;
  if not chkDirectories.Checked and not chkFiles.Checked then
  begin
    chkSubdirectories.Checked := False;
    chkSubdirectories.Enabled := False;
  end;
  if (chkCreate.Checked or chkLastWrite.Checked or chkLastAccess.Checked) and
    chkDirectories.Checked then
  begin
    for n := 0 to FSelected.Count - 1 do
    begin
      Path := FSelected.Strings[n];
      { ネットワーク上のフォルダなら }
      if DirectoryExists(Path) and PathIsUNC(PChar(ExpandUNCFileName(Path))) then
      begin
        if FForce and OsIsWinNt then
          { 何もしない }
        else
        begin
          MessageDlg(QuotedStr(Path) + ' はネットワーク上のフォルダです。'
            + '日時は変更できません。', mtError, [mbOK], 0);
          chkCreate.Checked := False;
          chkLastWrite.Checked := False;
          chkLastAccess.Checked := False;
        end;
        Break;
      end;
    end;
  end;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkFilesClick(Sender: TObject);
begin
  if chkDirectories.Checked or chkFiles.Checked then
    chkSubdirectories.Enabled := True;
  if not chkDirectories.Checked and not chkFiles.Checked then
  begin
    chkSubdirectories.Checked := False;
    chkSubdirectories.Enabled := False;
  end;
end;

procedure TFileAgeDlg.chkAttrClick(Sender: TObject);
begin
  chkFileAttr.Checked := True;
end;

procedure TFileAgeDlg.chkFileAttrClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.btnSaveOptionClick(Sender: TObject);
begin
  if chkCreate.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'Create', chkCreate.Checked);
  if chkCreateFollowWrite.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'CreateFollowWrite', chkCreateFollowWrite.Checked);
  if chkLastWrite.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'LastWrite', chkLastWrite.Checked);
  if chkFollowCreateAge.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'FollowCreateAge', chkFollowCreateAge.Checked);
  if chkLastAccess.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'LastAccess', chkCreate.Checked);
  if chkAccessFollowWrite.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'AccessFollowWrite', chkAccessFollowWrite.Checked);
  if chkDirectories.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'Directories', chkDirectories.Checked);
  if chkFiles.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'Files', chkFiles.Checked);
  if chkSubdirectories.Enabled then
    MainForm.IniFile.WriteBool('FileAge', 'Subdirectories', chkSubdirectories.Checked);
end;

procedure TFileAgeDlg.btnFollowAgeOriginalClick(Sender: TObject);
begin
  datLastWrite.Date := datOriginal.Date;
  timLastWrite.Time := timOriginal.Time;
  chkLastWrite.Checked := True;
  if chkCreateFollowWrite.Checked then
  begin
    datCreate.Date := datLastWrite.Date;
    timCreate.Time := timLastWrite.Time;
    chkCreate.Checked := True;
  end;
  if chkAccessFollowWrite.Checked then
  begin
    datLastAccess.Date := datLastWrite.Date;
    timLastAccess.Time := timLastWrite.Time;
    chkLastAccess.Checked := True;
  end;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimOriginalChange(Sender: TObject);
begin
  chkOriginal.Checked := True;
  if chkDigitizedFollowOriginal.Checked then
  begin
    datDigitized.DateTime := datOriginal.DateTime;
    timDigitized.DateTime := timOriginal.DateTime;
    chkDigitized.Checked := True;
  end;
  if chkUpdatedFollowOriginal.Checked then
  begin
    datUpdated.DateTime := datOriginal.DateTime;
    timUpdated.DateTime := timOriginal.DateTime;
    chkUpdated.Checked := True;
  end;
end;

procedure TFileAgeDlg.chkOriginalClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimDigitizedChange(Sender: TObject);
begin
  chkDigitized.Checked := True;
  chkDigitizedFollowOriginal.Checked := False;
end;

procedure TFileAgeDlg.chkDigitizedClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkDigitizedFollowOriginalClick(Sender: TObject);
begin
  if chkDigitizedFollowOriginal.Checked then
  begin
    datDigitized.DateTime := datOriginal.DateTime;
    timDigitized.DateTime := timOriginal.DateTime;
    chkDigitized.Checked := True;
  end;
  if radEach.Checked then
    chkDigitized.Checked := chkDigitizedFollowOriginal.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimUpdatedChange(Sender: TObject);
begin
  chkUpdated.Checked := True;
  chkUpdatedFollowOriginal.Checked := False;
end;

procedure TFileAgeDlg.chkUpdatedClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkUpdatedFollowOriginalClick(Sender: TObject);
begin
  if chkUpdatedFollowOriginal.Checked then
  begin
    datUpdated.DateTime := datOriginal.DateTime;
    timUpdated.DateTime := timOriginal.DateTime;
    chkUpdated.Checked := True;
  end;
  if radEach.Checked then
    chkDigitized.Checked := chkUpdatedFollowOriginal.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.radTargetSelect(Sender: TObject);
begin
  datCreate.Enabled := radAll.Checked;
  timCreate.Enabled := radAll.Checked;
  datLastWrite.Enabled := radAll.Checked;
  timLastWrite.Enabled := radAll.Checked;
  datLastAccess.Enabled := radAll.Checked;
  timLastAccess.Enabled := radAll.Checked;
  chkReadOnly.Enabled := radAll.Checked;
  chkHidden.Enabled := radAll.Checked;
  chkSysFile.Enabled := radAll.Checked;
  chkFileAttr.Enabled := radAll.Checked;
  chkArchive.Enabled := radAll.Checked;
  datOriginal.Enabled := radAll.Checked and AgeOriginalValid;
  timOriginal.Enabled := radAll.Checked and AgeOriginalValid;
  datDigitized.Enabled := radAll.Checked and AgeDigitizedValid;
  timDigitized.Enabled := radAll.Checked and AgeDigitizedValid;
  datUpdated.Enabled := radAll.Checked and AgeUpdatedValid;
  timUpdated.Enabled := radAll.Checked and AgeUpdatedValid;
  datCreated.Enabled := radAll.Checked and AgeCreatedValid;
  timCreated.Enabled := radAll.Checked and AgeCreatedValid;
  datSaved.Enabled := radAll.Checked and AgeCreatedValid;
  timSaved.Enabled := radAll.Checked and AgeSavedValid;
  datCreation.Enabled := radAll.Checked and CreationAgeValid;
  timCreation.Enabled := radAll.Checked and CreationAgeValid;
  btnResetTime.Visible := not radEach.Checked;
  chkResetTime.Visible := not btnResetTime.Visible;
  btnFollowAgeOriginal.Visible := not radEach.Checked;
  chkFollowAgeOriginal.Visible := not btnFollowAgeOriginal.Visible;
  btnSetNow.Visible := not radEach.Checked;

  difCreate.Visible := radDiff.Checked;
  datCreate.Visible := not difCreate.Visible;
  timCreate.Visible := not difCreate.Visible;
  chkCreateFollowWrite.Enabled := not radDiff.Checked;
  difLastWrite.Visible := radDiff.Checked;
  datLastWrite.Visible := not difLastWrite.Visible;
  timLastWrite.Visible := not difLastWrite.Visible;
  chkFollowCreateAge.Enabled := not radDiff.Checked;
  btnResetTime.Enabled := not radDiff.Checked;
  btnFollowAgeOriginal.Enabled := not radDiff.Checked;
  btnSetNow.Enabled := not radDiff.Checked;
  chkResetTime.Enabled := not radDiff.Checked;
  chkFollowAgeOriginal.Enabled := not radDiff.Checked;
  difLastAccess.Visible := radDiff.Checked;
  datLastAccess.Visible := not difLastAccess.Visible;
  timLastAccess.Visible := not difLastAccess.Visible;
  chkAccessFollowWrite.Enabled := not radDiff.Checked;
  difOriginal.Visible := radDiff.Checked;
  datOriginal.Visible := not difOriginal.Visible;
  timOriginal.Visible := not difOriginal.Visible;
  difDigitized.Visible := radDiff.Checked;
  datDigitized.Visible := not difDigitized.Visible;
  timDigitized.Visible := not difDigitized.Visible;
  chkDigitizedFollowOriginal.Enabled := not radDiff.Visible;
  difUpdated.Visible := radDiff.Checked;
  datUpdated.Visible := not difUpdated.Visible;
  timUpdated.Visible := not difUpdated.Visible;
  chkUpdatedFollowOriginal.Enabled := not radDiff.Visible;
  difCreated.Visible := radDiff.Checked;
  datCreated.Visible := not difCreated.Visible;
  timCreated.Visible := not difCreated.Visible;
  chkCreatedFollow.Enabled := not radDiff.Checked;
  chkFollowCreated.Enabled := not radDiff.Checked;
  difSaved.Visible := radDiff.Checked;
  datSaved.Visible := not difSaved.Visible;
  timSaved.Visible := not difSaved.Visible;
  chkSavedFollow.Enabled := not radDiff.Checked;
  chkFollowSaved.Enabled := not radDiff.Checked;
  difCreation.Visible := radDiff.Checked;
  datCreation.Visible := not difCreation.Visible;
  timCreation.Visible := not difCreation.Visible;
  chkFollowCreation.Enabled := not radDiff.Checked;
  difMod.Visible := radDiff.Checked;
  datMod.Visible := not difMod.Visible;
  timMod.Visible := not difMod.Visible;
  chkFollowMod.Enabled := not radDiff.Checked;
  edtName.Enabled := not radDiff.Checked;
end;

procedure TFileAgeDlg.chkResetTimeClick(Sender: TObject);
begin
  if radEach.Checked then
    chkLastWrite.Checked := chkResetTime.Checked;
end;

procedure TFileAgeDlg.chkFollowCreateAgeClick(Sender: TObject);
begin
  if chkFollowCreateAge.Checked then
  begin
    datLastWrite.Date := datCreate.Date;
    timLastWrite.Time := timCreate.Time;
    chkLastWrite.Checked := True;
    chkCreateFollowWrite.Checked := False;
    if chkLastAccess.Checked and chkAccessFollowWrite.Checked then
    begin
      datLastAccess.Date := datLastWrite.Date;
      timLastAccess.Time := timLastWrite.Time;
    end;
  end;
  if chkFollowCreateAge.Checked then
  begin
    chkCreateFollowWrite.Checked := False;
    chkFollowAgeOriginal.Checked := False;
  end;
  if radEach.Checked then
    chkLastWrite.Checked := chkFollowCreateAge.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkFollowAgeOriginalClick(Sender: TObject);
begin
  if chkFollowAgeOriginal.Checked then
    chkFollowCreateAge.Checked := False;
  if radEach.Checked then
    chkLastWrite.Checked := chkFollowAgeOriginal.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

function TFileAgeDlg.ChangeEachFileAge: Boolean;
var
  n: Integer;
  Path: String;
  CreateAge, LastAccessAge, LastWriteAge: TDateTime;
  AgeUpdated, AgeOriginal, AgeDigitized: TDateTime;
  AgeCreated, AgeSaved: TDateTime;
  CreationAge, ModAge: TDateTime;
begin
  Result := False;
  { 対象となるファイル/フォルダを検索 }
  FindTarget;
  { 日時を変更 }
  for n := 0 to FTarget.Count - 1 do
  begin
    Path := FTarget.Strings[n];
    { 日時を変更 }
    if chkCreate.Checked or
      chkLastWrite.Checked or
      chkLastAccess.Checked then
    begin
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      if chkResetTime.Checked then
        ReplaceTime(LastWriteAge, 0);
      if chkFollowCreateAge.Checked then
        LastWriteAge := CreateAge;
      if chkFollowAgeOriginal.Checked and
        AgeOriginalValid then
      begin
        ExifGetAge(Path, AgeUpdated, AgeUpdatedValid, AgeOriginal, AgeOriginalValid, AgeDigitized, AgeDigitizedValid);
        LastWriteAge := AgeOriginal;
      end;
      if chkCreateFollowWrite.Checked then
        CreateAge := LastWriteAge;
      if not FileSetAge(Path, CreateAge, chkCreate.Checked, LastAccessAge, chkLastAccess.Checked, LastWriteAge, chkLastWrite.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    end;
    { Exif 日時を変更 }
    if chkOriginal.Checked
      or chkDigitized.Checked
      or chkUpdated.Checked then
    try
      ExifGetAge(Path, AgeUpdated, AgeUpdatedValid, AgeOriginal, AgeOriginalValid, AgeDigitized, AgeDigitizedValid);
      if chkDigitizedFollowOriginal.Checked then
        AgeDigitized := AgeOriginal;
      if chkUpdatedFollowOriginal.Checked then
        AgeUpdated := AgeOriginal;
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      if not ExifSetAge(Path, AgeUpdated, chkUpdated.Checked, AgeOriginal, chkOriginal.Checked, AgeDigitized, chkDigitized.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
    { 概要情報を変更 }
    if chkCreated.Checked
      or chkSaved.Checked then
    try
      DocGetAge(Path, AgeCreated, AgeCreatedValid, AgeSaved, AgeSavedValid);
      if chkCreatedFollow.Checked then
        AgeCreated := CreateAge;
      if chkFollowCreated.Checked then
        CreateAge := AgeCreated;
      if chkSavedFollow.Checked then
        AgeSaved := LastWriteAge;
      if chkFollowSaved.Checked then
        LastWriteAge := AgeSaved;
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      if not DocSetAge(Path, AgeCreated, chkCreated.Checked, AgeSaved, chkSaved.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
    { PDF 日時を変更 }
    if chkCreation.Checked
      or chkMod.Checked then
    try
      PdfGetAge(Path, CreationAge, CreationAgeValid, ModAge, ModAgeValid);
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      if not PdfSetAge(Path, CreationAge, chkCreation.Checked, ModAge, chkMod.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
  end;
  { ファイル名を変更 }
  if chkName.Checked then
    if not RenameFile(FSelected.Strings[0], ExtractFilePath(FSelected.Strings[0]) + edtName.Text) then
      MessageDlg(QuotedStr(FSelected.Strings[0]) + ' の名前は変更できませんでした。', mtError, [mbOK], 0)
    else
      FSelected.Strings[0] := ExtractFilePath(FSelected.Strings[0]) + edtName.Text;
  { エクスプローラを強制的に再表示 }
  SHChangeNotify(SHCNE_UPDATEDIR, SHCNF_PATH, PChar(ExtractFileDir(Path)), nil);
  SHChangeNotify(SHCNE_UPDATEDIR, SHCNF_FLUSH, nil, nil);
  { ... }
  chkCreate.Checked := False;
  chkLastWrite.Checked := False;
  chkLastAccess.Checked := False;
  chkFileAttr.Checked := False;
  chkUpdated.Checked := False;
  chkOriginal.Checked := False;
  chkDigitized.Checked := False;
  chkName.Checked := False;
  Result := True;
end;

procedure TFileAgeDlg.btnItemsUpClick(Sender: TObject);
var
  item: TListItem;
begin
  if not Assigned(ExportItemList.Selected) then
    Exit;
  if ExportItemList.Selected.Index - 1 < 0 then
    Exit;
  with ExportItemList do
  begin
    Items.BeginUpdate;
    item := Items.Insert(Selected.Index - 1);
    item.Assign(Selected);
    Selected.Delete;
    item.Selected := True;
    Items.EndUpdate;
  end;
end;

procedure TFileAgeDlg.btnItemsDownClick(Sender: TObject);
var
  item: TListItem;
begin
  if not Assigned(ExportItemList.Selected) then
    Exit;
  if ExportItemList.Selected.Index + 1 > ExportItemList.Items.Count - 1 then
    Exit;
  with ExportItemList do
  begin
    Items.BeginUpdate;
    if Selected.Index + 2 > Items.Count - 1 then
      item := Items.Add
    else
      item := Items.Insert(ExportItemList.ItemIndex + 2);
    item.Assign(Selected);
    Selected.Delete;
    item.Selected := True;
    Items.EndUpdate;
  end;
end;

procedure TFileAgeDlg.btnExportFileAgeAttrClick(Sender: TObject);
begin
  { 書出する内容を設定 }
  SetExportBuf;
  { ファイルに書出 }
  ExportFileAgeAttrDlg.InitialDir := ExtractFileDir(FSelected.Strings[0]);
  if not ExportFileAgeAttrDlg.Execute then
    Exit;
  FExportBuf.SaveToFile(ExportFileAgeAttrDlg.FileName);
end;

procedure TFileAgeDlg.btnCopyFileAgeAttrClick(Sender: TObject);
begin
  { 書出する内容を設定 }
  SetExportBuf;
  { クリップボードにコピー }
  Clipboard.SetTextBuf(FExportBuf.GetText);
end;

procedure TFileAgeDlg.SetExportBuf;
var
  n, i: Integer;
  Path: String;
  CreateAge, LastAccessAge, LastWriteAge: TDateTime;
  Attr: Integer;
  ReadOnly, Hidden, SysFile, Archive: Boolean;
  AgeUpdated, AgeOriginal, AgeDigitized: TDateTime;
  UpdatedValid, OriginalValid, DigitizedValid: Boolean;
  AgeCreated, AgeSaved: TDateTime;
  CreatedValid, SavedValid: Boolean;
  CreationAge, ModAge: TDateTime;
  CreationValid, ModValid: Boolean;
  buf: TStringList;
begin
  buf := TStringList.Create;
  { 対象となるファイル/フォルダを検索 }
  FindTarget;
  { 書出する内容を設定 }
  FExportBuf.Clear;
  buf.Clear;
  if chkItemName.Checked then
  begin
    for n := 0 to ExportItemList.Items.Count - 1 do
      if ExportItemList.Items[n].Checked then
        buf.Add(ExportItemList.Items[n].Caption);
    FExportBuf.Add(buf.CommaText);
  end;
  for i := 0 to FTarget.Count - 1 do
  begin
    Path := FTarget.Strings[i];
    FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
    Attr := FileGetAttr(Path);
    ReadOnly := (Attr and faReadOnly) = faReadOnly;
    Hidden := (Attr and faHidden) = faHidden;
    SysFile := (Attr and faSysFile) = faSysFile;
    Archive := (Attr and faArchive) = faArchive;
    ExifGetAge(Path, AgeUpdated, UpdatedValid, AgeOriginal, OriginalValid, AgeDigitized, DigitizedValid);
    DocGetAge(Path, AgeCreated, CreatedValid, AgeSaved, SavedValid);
    PdfGetAge(Path, CreationAge, CreationValid, ModAge, ModValid);
    { ... } 
    buf.Clear;
    for n := 0 to ExportItemList.Items.Count - 1 do
      if ExportItemList.Items[n].Checked then
      begin
        if String(ExportItemList.Items[n].Data^) = 'FileName' then buf.Add(ExtractFileName(Path));
        if String(ExportItemList.Items[n].Data^) = 'Folder' then buf.Add(ExtractFilePath(Path));
        if String(ExportItemList.Items[n].Data^) = 'FullPath' then buf.Add(Path);
        if String(ExportItemList.Items[n].Data^) = 'CreateAge' then buf.Add(DateTimeToStr(CreateAge));
        if String(ExportItemList.Items[n].Data^) = 'LastWriteAge' then buf.Add(DateTimeToStr(LastWriteAge));
        if String(ExportItemList.Items[n].Data^) = 'LastAccessAge' then buf.Add(DateTimeToStr(LastAccessAge));
        if String(ExportItemList.Items[n].Data^) = 'ReadOnly' then buf.Add(BoolToStr(ReadOnly));
        if String(ExportItemList.Items[n].Data^) = 'Hidden' then buf.Add(BoolToStr(Hidden));
        if String(ExportItemList.Items[n].Data^) = 'SysFile' then buf.Add(BoolToStr(SysFile));
        if String(ExportItemList.Items[n].Data^) = 'Archive' then buf.Add(BoolToStr(Archive));
        if String(ExportItemList.Items[n].Data^) = 'AgeOriginal' then buf.Add(IfThen(OriginalValid, DateTimeToStr(AgeOriginal), 'N/A'));
        if String(ExportItemList.Items[n].Data^) = 'AgeDigitized' then buf.Add(IfThen(DigitizedValid, DateTimeToStr(AgeDigitized), 'N/A'));
        if String(ExportItemList.Items[n].Data^) = 'AgeUpdated' then buf.Add(IfThen(UpdatedValid, DateTimeToStr(AgeUpdated),'N/A'));
        if String(ExportItemList.Items[n].Data^) = 'AgeCreated' then buf.Add(IfThen(CreatedValid, DateTimeToStr(AgeCreated), 'N/A'));
        if String(ExportItemList.Items[n].Data^) = 'AgeSaved' then buf.Add(IfThen(SavedValid, DateTimeToStr(AgeSaved),'N/A'));
        if String(ExportItemList.Items[n].Data^) = 'PdfCreateAge' then buf.Add(IfThen(CreationAgeValid, DateTimeToStr(CreationAge), 'N/A'));
        if String(ExportItemList.Items[n].Data^) = 'PdfModAte' then buf.Add(IfThen(ModAgeValid, DateTimeToStr(ModAge),'N/A'));
      end;
    FExportBuf.Add(buf.CommaText);
  end;
  buf.Free;
end;

procedure TFileAgeDlg.btnSaveItemsClick(Sender: TObject);
var
  item: TListItem;
  list: TStringList;
  n: Integer;
begin
  { ... }
  list := TStringList.Create;
  for n := 0 to ExportItemList.Items.Count - 1 do
  begin
    item := ExportItemList.Items[n];
    list.Add(String(item.Data^));
    list.Add(item.Caption);
    list.Add(BoolToStr(item.Checked));
  end;
  MainForm.IniFile.WriteStr('FileAgeDlg', 'ExportItemList', list.CommaText);
  list.Free;
  MainForm.IniFile.WriteBool('FileAgeDlg', 'ExportItemName', chkItemName.Checked);
end;

procedure TFileAgeDlg.ExportItemListDeletion(Sender: TObject;
  Item: TListItem);
begin
  Dispose(Item.Data);
end;

procedure TFileAgeDlg.PageControlMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PageControl.BeginDrag(False);
end;

procedure TFileAgeDlg.PageControlDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Sender = Source);
end;

procedure TFileAgeDlg.PageControlDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  n: Integer;
begin
  n := PageControl.IndexOfTabAt(X, Y);
  if n = PageControl.TabIndex then Exit;
  PageControl.ActivePage.PageIndex := n;
end;

procedure TFileAgeDlg.dattimCreatedChange(Sender: TObject);
begin
  chkCreated.Checked := True;
  if chkFollowCreated.Checked then
  begin
    datCreate.Date := datCreated.Date;
    timCreate.Time := timCreated.Time;
    chkCreate.Checked := True;
  end;
  chkCreatedFollow.Checked := False;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkCreatedClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkCreatedFollowClick(Sender: TObject);
begin
  if chkCreatedFollow.Checked then
  begin
    datCreated.Date := datCreate.Date;
    timCreated.Time := timCreate.Time;
    chkCreated.Checked := True;
    chkFollowCreated.Checked := False;
  end;
  if radEach.Checked then
    chkCreated.Checked := chkCreatedFollow.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkFollowCreatedClick(Sender: TObject);
begin
  if chkFollowCreated.Checked then
  begin
    datCreate.Date := datCreated.Date;
    timCreate.Time := timCreated.Time;
    chkCreate.Checked := True;
    chkCreatedFollow.Checked := False;
  end;
  if radEach.Checked then
    chkCreate.Checked := chkFollowCreated.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimSavedChange(Sender: TObject);
begin
  chkSaved.Checked := True;
  if chkFollowSaved.Checked then
  begin
    datLastWrite.Date := datSaved.Date;
    timLastWrite.Time := timSaved.Time;
    chkLastWrite.Checked := True;
  end;
  chkSavedFollow.Checked := False;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkSavedClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkSavedFollowClick(Sender: TObject);
begin
  if chkSavedFollow.Checked then
  begin
    datSaved.Date := datLastWrite.Date;
    timSaved.Time := timLastWrite.Time;
    chkSaved.Checked := True;
    chkFollowSaved.Checked := False;
  end;
  if radEach.Checked then
    chkSaved.Checked := chkSavedFollow.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkFollowSavedClick(Sender: TObject);
begin
  if chkFollowSaved.Checked then
  begin
    datLastWrite.Date := datSaved.Date;
    timLastWrite.Time := timSaved.Time;
    chkLastWrite.Checked := True;
    chkSavedFollow.Checked := False;
  end;
  if radEach.Checked then
    chkLastWrite.Checked := chkFollowSaved.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimCreationChange(Sender: TObject);
begin
  chkCreation.Checked := True;
  if chkFollowCreation.Checked then
  begin
    datCreate.Date := datCreation.Date;
    timCreate.Time := timCreation.Time;
    chkCreate.Checked := True;
  end;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkCreationClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkFollowCreationClick(Sender: TObject);
begin
  if chkFollowCreation.Checked then
  begin
    datCreate.Date := datCreation.Date;
    timCreate.Time := timCreation.Time;
    chkCreate.Checked := True;
  end;
  if radEach.Checked then
    chkCreate.Checked := chkFollowCreation.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.dattimModChange(Sender: TObject);
begin
  chkMod.Checked := True;
  if chkFollowCreation.Checked then
  begin
    datLastWrite.Date := datMod.Date;
    timLastWrite.Time := timMod.Time;
    chkLastWrite.Checked := True;
  end;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkModClick(Sender: TObject);
begin
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.chkFollowModClick(Sender: TObject);
begin
  if chkFollowMod.Checked then
  begin
    datLastWrite.Date := datMod.Date;
    timLastWrite.Time := timMod.Time;
    chkLastWrite.Checked := True;
  end;
  if radEach.Checked then
    chkLastWrite.Checked := chkFollowMod.Checked;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.edtNameChange(Sender: TObject);
begin
  chkName.Checked := True;
{ btnOK.Enabled := Modified; }
 btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.btnSetNowClick(Sender: TObject);
begin
  datLastWrite.Date := Now;
  timLastWrite.Time := Now;
  chkLastWrite.Checked := True;
  if chkCreateFollowWrite.Checked then
  begin
    datCreate.Date := Now;
    timCreate.Time := Now;
    chkCreate.Checked := True;
  end;
  if chkAccessFollowWrite.Checked then
  begin
    datLastAccess.Date := Now;
    timLastAccess.Time := Now;
    chkLastAccess.Checked := True;
  end;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difCreateChange(Sender: TObject);
begin
  chkCreate.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difLastWriteChange(Sender: TObject);
begin
  chkLastWrite.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difLastAccessChange(Sender: TObject);
begin
  chkLastAccess.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difOriginalChange(Sender: TObject);
begin
  chkOriginal.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difDigitizedChange(Sender: TObject);
begin
  chkDigitized.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difUpdatedChange(Sender: TObject);
begin
  chkUpdated.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difCreatedChange(Sender: TObject);
begin
  chkCreated.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difSavedChange(Sender: TObject);
begin
  chkSaved.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difCreationChange(Sender: TObject);
begin
  chkCreation.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

procedure TFileAgeDlg.difModChange(Sender: TObject);
begin
  chkMod.Checked := True;
{ btnOK.Enabled := Modified; }
  btnApply.Enabled := Modified;
end;

function TFileAgeDlg.DiffFileAge: Boolean;

  function IncDate(const Value: TDate; const NumberOfYears: Integer; const NumberOfMonths: Integer; const NumberOfDays: Integer): TDate;
  begin
    Result := IncYear(IncMonth(IncDay(Value, NumberOfDays), NumberOfMonths), NumberOfYears);
  end;

  function IncTime(const Value: TTime; const NumberOfHours: Integer; const NumberOfMinutes: Integer; const NumberOfSeconds: Integer): TTime;
  begin
    Result := IncHour(IncMinute(IncSecond(Value, NumberOfSeconds), NumberOfMinutes), NumberOfHours);
  end;

var
  n: Integer;
  Path: String;
  CreateAge, LastAccessAge, LastWriteAge: TDateTime;
  AgeUpdated, AgeOriginal, AgeDigitized: TDateTime;
  AgeCreated, AgeSaved: TDateTime;
  CreationAge, ModAge: TDateTime;
begin
  Result := False;
  { 対象となるファイル/フォルダを検索 }
  FindTarget;
  { 日時を変更 }
  for n := 0 to FTarget.Count - 1 do
  begin
    Path := FTarget.Strings[n];
    { 日時を変更 }
    if chkCreate.Checked or
      chkLastWrite.Checked or
      chkLastAccess.Checked then
    begin
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      ReplaceDate(CreateAge, IncDate(CreateAge, difCreate.YY, difCreate.MM, difCreate.DD)); ReplaceTime(CreateAge, IncTime(CreateAge, difCreate.HH, difCreate.NN, difCreate.SS));
      ReplaceDate(LastWriteAge, IncDate(LastWriteAge, difLastWrite.YY, difLastWrite.MM, difLastWrite.DD)); ReplaceTime(LastWriteAge, IncTime(LastWriteAge, difLastWrite.HH, difLastWrite.NN, difLastWrite.SS));
      ReplaceDate(LastAccessAge, IncDate(LastAccessAge, difLastAccess.YY, difLastAccess.MM, difLastAccess.DD)); ReplaceTime(LastAccessAge, IncTime(LastAccessAge, difLastAccess.HH, difLastAccess.NN, difLastAccess.SS));
      if not FileSetAge(Path, CreateAge, chkCreate.Checked, LastAccessAge, chkLastAccess.Checked, LastWriteAge, chkLastWrite.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    end;
    { Exif 日時を変更 }
    if chkOriginal.Checked
      or chkDigitized.Checked
      or chkUpdated.Checked then
    try
      ExifGetAge(Path, AgeUpdated, AgeUpdatedValid, AgeOriginal, AgeOriginalValid, AgeDigitized, AgeDigitizedValid);
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      ReplaceDate(AgeOriginal, IncDate(AgeOriginal, difOriginal.YY, difOriginal.MM, difOriginal.DD)); ReplaceTime(AgeOriginal, IncTime(AgeOriginal, difOriginal.HH, difOriginal.NN, difOriginal.SS));
      ReplaceDate(AgeUpdated, IncDate(AgeUpdated, difUpdated.YY, difUpdated.MM, difUpdated.DD)); ReplaceTime(AgeUpdated, IncTime(AgeUpdated, difUpdated.HH, difUpdated.NN, difUpdated.SS));
      ReplaceDate(AgeDigitized, IncDate(AgeDigitized, difDigitized.YY, difDigitized.MM, difDigitized.DD)); ReplaceTime(AgeDigitized, IncTime(AgeDigitized, difDigitized.HH, difDigitized.NN, difDigitized.SS));
      if not ExifSetAge(Path, AgeUpdated, chkUpdated.Checked, AgeOriginal, chkOriginal.Checked, AgeDigitized, chkDigitized.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
    { 概要情報を変更 }
    if chkCreated.Checked
      or chkSaved.Checked then
    try
      DocGetAge(Path, AgeCreated, AgeCreatedValid, AgeSaved, AgeSavedValid);
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      ReplaceDate(AgeCreated, IncDate(AgeCreated, difCreated.YY, difCreated.MM, difCreated.DD)); ReplaceTime(AgeCreated, IncTime(AgeCreated, difCreated.HH, difCreated.NN, difCreated.SS));
      ReplaceDate(AgeSaved, IncDate(AgeSaved, difSaved.YY, difSaved.MM, difSaved.DD)); ReplaceTime(AgeSaved, IncTime(AgeSaved, difSaved.HH, difSaved.NN, difSaved.SS));
      if not DocSetAge(Path, AgeCreated, chkCreated.Checked, AgeSaved, chkSaved.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
    { PDF 日時を変更 }
    if chkCreation.Checked
      or chkMod.Checked then
    try
      PdfGetAge(Path, CreationAge, CreationAgeValid, ModAge, ModAgeValid);
      FileGetAge(Path, CreateAge, LastAccessAge, LastWriteAge);
      ReplaceDate(CreationAge, IncDate(CreationAge, difCreation.YY, difCreation.MM, difCreation.DD)); ReplaceTime(CreationAge, IncTime(CreationAge, difCreation.HH, difCreation.NN, difCreation.SS));
      ReplaceDate(ModAge, IncDate(ModAge, difMod.YY, difMod.MM, difMod.DD)); ReplaceTime(ModAge, IncTime(ModAge, difMod.HH, difMod.NN, difMod.SS));
      if not PdfSetAge(Path, CreationAge, chkCreation.Checked, ModAge, chkMod.Checked) then
      begin
        if n < FTarget.Count - 1 then
        begin
          if MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。'
            + #13#10#13#10 + '処理を中断しますか', mtError, [mbYes, mbNo], 0) = mrYes then
            Exit;
        end
        else
        begin
          MessageDlg(QuotedStr(Path) + ' の日時は変更できませんでした。', mtError, [mbOK], 0);
          Exit;
        end
      end;
    finally
      if not FileSetAge(Path, CreateAge, True, LastAccessAge, True, LastWriteAge, True) then
        MessageDlg(QuotedStr(Path) + ' の日時を戻せませんでした。', mtError, [mbOK], 0);
    end;
  end;
  { エクスプローラを強制的に再表示 }
  SHChangeNotify(SHCNE_UPDATEDIR, SHCNF_PATH, PChar(ExtractFileDir(Path)), nil);
  SHChangeNotify(SHCNE_UPDATEDIR, SHCNF_FLUSH, nil, nil);
  { ... }
  chkCreate.Checked := False;
  chkLastWrite.Checked := False;
  chkLastAccess.Checked := False;
  chkUpdated.Checked := False;
  chkOriginal.Checked := False;
  chkDigitized.Checked := False;
  Result := True;
end;

end.

