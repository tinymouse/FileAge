unit Utils;

interface

uses
  Windows, SysUtils, Classes, FileCtrl, ShlObj, ShellIDFunc, StrUtils, ActiveX, ComObj;

function FileTimeToDateTime(FileTime: TFileTime): TDateTime;
function DateTimeToFileTime(DateTime: TDateTime): TFileTime;

function FileGetAge(Path: String; var CreateAge: TDateTime; var LastAccessAge: TDateTime; var LastWriteAge: TDateTime): Boolean;
function FileSetAge(Path: String; CreateAge: TDateTime; CreateValid: Boolean; LastAccessAge: TDateTime; LastAccessValid: Boolean; LastWriteAge: TDateTime; LastWriteValid: Boolean): Boolean;

function ExifGetAge(Path: String; var AgeUpdated: TDateTime; var UpdatedValid: Boolean; var AgeOriginal: TDateTime; var OriginalValid: Boolean; var AgeDigitized: TDateTime; var DigitizedValid: Boolean): Boolean;
function ExifSetAge(Path: String; AgeUpdated: TDateTime; UpdatedValid: Boolean; AgeOriginal: TDateTime; OriginalValid: Boolean; AgeDigitized: TDateTime; DigitizedValid:Boolean): Boolean;

function OsIsWinNt: Boolean;
function GetLongFileName(const Value: String): String;

function PathIsRoot(lpszPath: PChar): BOOL; stdcall; external 'SHLWAPI.DLL' name 'PathIsRootA';
function PathIsUNC(lpszPath: PChar): BOOL; stdcall; external 'SHLWAPI.DLL' name 'PathIsUNCA';

function DocGetAge(Path: String; var CreatedAge: TDateTime; var CreatedValid: Boolean; var LastSavedAge: TDateTime; var LastSavedValid: Boolean): Boolean;
function DocSetAge(Path: String; CreatedAge: TDateTime; CreatedValid: Boolean; LastSavedAge: TDateTime; LastSavedValid: Boolean): Boolean;

function PdfGetAge(Path: String; var CreationAge: TDateTime; var CreationValid: Boolean; var ModAge: TDateTime; var ModValid: Boolean): Boolean;
function PdfSetAge(Path: String; CreationAge: TDateTime; CreationValid: Boolean; ModAge: TDateTime; ModValid: Boolean): Boolean;

implementation

{ TFileTime型からTDateTime型へ }

function FileTimeToDateTime(FileTime: TFileTime): TDateTime;
var
  LocalFileTime: TFileTime;
  SystemTime: TSystemTime;
begin
  FileTimeToLocalFileTime(FileTime, LocalFileTime);
  FileTimeToSystemTime(LocalFileTime, SystemTime);
  Result := SystemTimeToDateTime(SystemTime);
end;

{ TDateTime型からTFileTime型へ }

function DateTimeToFileTime(DateTime: TDateTime): TFileTime;
var
  SystemTime: TSystemTime;
  LocalFileTime: TFileTime;
begin
  DateTimeToSystemTime(DateTime, SystemTime);
  SystemTimeToFileTime(SystemTime, LocalFileTime);
  LocalFileTimeToFileTime(LocalFileTime, Result);
end;

{ ファイル/ディレクトリのタイムスタンプを取得する }

function FileGetAge(Path: String; var CreateAge: TDateTime; var LastAccessAge: TDateTime; var LastWriteAge: TDateTime): Boolean;
var
  sr: TSearchRec;
begin
  Result := False;
  if FindFirst(Path, faAnyFile, sr) <> 0 then
    Exit;
  CreateAge := FileTimeToDateTime(sr.FindData.ftCreationTime);
  LastAccessAge := FileTimeToDateTime(sr.FindData.ftLastAccessTime);
  LastWriteAge := FileTimeToDateTime(sr.FindData.ftLastWriteTime);
  FindClose(sr);
  Result := True;
end;

{ ファイル/ディレクトリのタイムスタンプを設定する }

function FileSetAge(Path: String; CreateAge: TDateTime; CreateValid: Boolean; LastAccessAge: TDateTime; LastAccessValid: Boolean; LastWriteAge: TDateTime; LastWriteValid: Boolean): Boolean;

  function SetFileAge(Path: String; CreateAge: TDateTime; CreateValid: Boolean; LastAccessAge: TDateTime; LastAccessValid: Boolean; LastWriteAge: TDateTime): Boolean;
  var
    fh: Integer;
    t1, t2, t3: TFileTime;
    p1, p2, p3: PFileTime;
  begin
    Result := False;
    fh := FileOpen(Path, fmOpenWrite);
    if fh = 0 then
      Exit;
    if CreateValid then t1 := DateTimeToFileTime(CreateAge);
    if LastAccessValid then t2 := DateTimeToFileTime(LastAccessAge);
    if LastWriteValid then t3 := DateTimeToFileTime(LastWriteAge);
    if CreateValid then p1 := @t1
    else p1 := nil;
    if LastAccessValid then p2 := @t2
    else p2 := nil;
    if LastWriteValid then p3 := @t3
    else p3 := nil;
    Result := SetFileTime(fh, p1, p2, p3);
    FileClose(fh);
  end;

  function SetDirAgeOnNT(Path: String; CreateAge: TDateTime; CreateValid: Boolean; LastAccessAge: TDateTime; LastAccessValid: Boolean; LastWriteAge: TDateTime): Boolean;
  var
    fh: Integer;
    t1, t2, t3: TFileTime;
    p1, p2, p3: PFileTime;
  begin
    Result := False;
    Path := ExcludeTrailingBackslash(Path);
    fh := CreateFile(PChar(Path),
      GENERIC_WRITE,
      FILE_SHARE_READ,
      nil,
      OPEN_EXISTING,
      FILE_FLAG_BACKUP_SEMANTICS,
      0);
    if fh = 0 then
      Exit;
    if CreateValid then t1 := DateTimeToFileTime(CreateAge);
    if LastAccessValid then t2 := DateTimeToFileTime(LastAccessAge);
    if LastWriteValid then t3 := DateTimeToFileTime(LastWriteAge);
    if CreateValid then p1 := @t1
    else p1 := nil;
    if LastAccessValid then p2 := @t2
    else p2 := nil;
    if LastWriteValid then p3 := @t3
    else p3 := nil;
    Result := SetFileTime(fh, p1, p2, p3);
    CloseHandle(fh);
  end;

  function SetDirAgeByWfut(Path: String; CreateAge: TDateTime; CreateValid: Boolean; LastAccessAge: TDateTime; LastAccessValid: Boolean; LastWriteAge: TDateTime): Boolean;
  type
    TSetDosFileTime = function(lpPathName: PChar; lpCreateTime, lpLastAccessTime, lpLastWriteTime: PFileTime): BOOL; stdcall;
  var
    hLib: THandle;
    SetDosFileTime: TSetDosFileTime;
    t1, t2, t3: TFileTime;
    p1, p2, p3: PFileTime;
  begin
    Result := False;
    Path := ExcludeTrailingBackslash(Path);
    hLib := LoadLibrary('wfut32.dll');
    if hLib = 0 then
      Exit;
    @SetDosFileTime := GetProcAddress(hLib, 'SetDosFileTime');
    if @SetDosFileTime = nil then
      Exit;
    if CreateValid then t1 := DateTimeToFileTime(CreateAge);
    if LastAccessValid then t2 := DateTimeToFileTime(LastAccessAge);
    if LastWriteValid then t3 := DateTimeToFileTime(LastWriteAge);
    if CreateValid then p1 := @t1
    else p1 := nil;
    if LastAccessValid then p2 := @t2
    else p2 := nil;
    if LastWriteValid then p3 := @t3
    else p3 := nil;
    Result := SetDosFileTime(PChar(Path), p1, p2, p3);
    FreeLibrary(hLib);
  end;

  function SetDirAgeOn95(Path: String; Age: TDateTime): Boolean;
  var
    NowTime, SystemTime: TSystemTime;
    TempPath: String;
    SearchRec: TSearchRec;
  begin
    Result := False;
    Path := ExcludeTrailingBackslash(Path);
    try
      { PC の時計を一時的に変更 }
      GetLocalTime(NowTime);
      DateTimeToSystemTime(Age, SystemTime);
      if not SetLocalTime(SystemTime) then
        raise Exception.Create('PC の時計を変更できませんでした');
      { 一時ディレクトリを作成 }
      TempPath := Path + '.tmp';
      if not ForceDirectories(TempPath) then
        raise Exception.Create('一時ﾃﾞｨﾚｸﾄﾘを作成できませんでした');
    finally
      { PC の時計を元に戻す }
      SetLocalTime(NowTime);
    end;
    { 指定されたディレクトリ内の全てのファイルを一時ディレクトリへ移動 }
    if FindFirst(Path + '\*.*', faAnyFile, SearchRec) = 0 then
    begin
      repeat
        RenameFile(Path + '\' + SearchRec.Name, TempPath + '\' + SearchRec.Name);
      until FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;
    { 元のディレクトリを削除し一時ディレクトリを元のディレクトリにリネーム }
    if not RemoveDir(Path) then
      raise Exception.Create('一時ﾃﾞｨﾚｸﾄﾘ ' + QuotedStr(TempPath) + ' を確認して下さい');
    if not RenameFile(TempPath, Path) then
      raise Exception.Create('一時ﾃﾞｨﾚｸﾄﾘ ' + QuotedStr(TempPath) + ' を確認して下さい');
    Result := True;
  end;

var
  OldAttr: Integer;
begin
  try
    { 属性を保存 }
    OldAttr := FileGetAttr(Path);
    FileSetAttr(Path, 0);
    { ファイルなら }
    if not DirectoryExists(Path) then
      Result := SetFileAge(Path, CreateAge, CreateValid, LastAccessAge, LastAccessValid, LastWriteAge)
    { ディレクトリなら }
    else
      { NT 系 Windows なら }
      if OsIsWinNt then
        Result :=  SetDirAgeOnNT(Path, CreateAge, CreateValid, LastAccessAge, LastAccessValid, LastWriteAge)
      { そうでなければ }
      else
        if SetDirAgeByWfut(Path, CreateAge, CreateValid, LastAccessAge, LastAccessValid, LastWriteAge) then
          Result := True
        else
          Result := SetDirAgeOn95(Path, LastWriteAge);
  finally
    { 属性を戻す }
    FileSetAttr(Path, OldAttr);
  end;
end;

{ Exif データの日時を取得/設定する }

function GetWORD(Value: WORD; BigEndian: Boolean): WORD;
begin
  if BigEndian then
    Result := ((Value shl 8) and $ff00) or ((Value shr 8) and $ff)
  else
    Result := Value;
end;

function GetDWORD(Value: DWORD; BigEndian: Boolean): DWORD;
var
  n: Integer;
  Dst, Src: PChar;
begin
  if BigEndian then
  begin
    Dst := @Result;
    Src := @Value;
    for n := 0 to SizeOf(DWORD) - 1 do
      Dst[n] := Src[SizeOf(DWORD) - 1 - n];
  end
  else
    Result := Value;
end;

type
  TTiffHeader = packed record
    ByteOrder: WORD;
    Tag: WORD;
    Offset: DWORD;
  end;
  TIFD = packed record
    Tag: WORD;
    DataType: WORD;
    Count: DWORD;
    Data: DWORD;
  end;

function ReadHeader(Data: TStream;
  var TiffHeaderPos: Int64; var Offset: DWORD; var BigEndian: Boolean; var IFDNum: Word): Boolean;
var
  wBuf: Word;
  ExifHeader: array[0..5] of Char;
  TiffHeader: TTiffHeader;
begin
  Result := False;
  { JPEG ヘッダを確認 }
  if Data.Read(wBuf, SizeOf(wBuf)) <> SizeOf(wBuf) then Exit;
  if wBuf <> $D8FF then Exit;
  { APP1 マーカーを確認 }
  if Data.Read(wBuf, SizeOf(wBuf)) <> SizeOf(wBuf) then Exit;
  if wBuf <> $E1FF then Exit;
  { Exif ヘッダを確認 }
  Data.Seek(2, soCurrent);
  if Data.Read(ExifHeader, SizeOf(ExifHeader)) <> SizeOf(ExifHeader) then Exit;
  if not SameText(ExifHeader, 'exif') then Exit;
  { TIFF ヘッダを読取 }
  TiffHeaderPos := Data.Position;
  if Data.Read(TiffHeader, SizeOf(TiffHeader)) <> SizeOf(TiffHeader) then Exit;
  if (TiffHeader.ByteOrder <> $4949) and (TiffHeader.ByteOrder <> $4D4D) then Exit;
  BigEndian := (TiffHeader.ByteOrder = $4D4D);
  if GetWORD(TiffHeader.Tag, BigEndian) <> $002A then Exit;
  if Data.Read(wBuf, SizeOf(wBuf)) <> SizeOf(wBuf) then Exit;
  { IFD 数を取得 }
  Offset := GetDWORD(TiffHeader.Offset, BigEndian);
  Data.Position := TiffHeaderPos + Offset;
  Data.Read(wBuf, SizeOf(wBuf));
  IFDNum := GetWORD(wBuf, BigEndian);
  Result := True;
end;

function GetAgeFromIFD(Data: TStream;
  TiffHeaderPos: Int64; Offset: DWORD; Count: DWORD; DataType: WORD; var Age: TDateTime): Boolean;
var
  n: Integer;
  cBuf: Char;
  sBuf: String;
  OldDateSep, OldTimeSep: Char;
begin
  Result := False;
  if DataType <> 2 then
    Exit;
  OldDateSep := DateSeparator; OldTimeSep := TimeSeparator;
  try
    Data.Position := TiffHeaderPos + Offset;
    sBuf := '';
    for n := 1 to Count do
    begin
      Data.Read(cBuf, SizeOf(cBuf));
      if cBuf = #0 then break;
      sBuf := sBuf + cBuf;
    end;
    if SameText(sBuf, StringOfChar(' ', Length(sBuf))) then
      Exit;
    DateSeparator := ':'; TimeSeparator := ':';
    Age := StrToDateTimeDef(sBuf, 0);
    Result := True;
  finally
    DateSeparator := OldDateSep; TimeSeparator := OldTimeSep;
  end;
end;

function ExifGetAge(Path: String; var AgeUpdated: TDateTime; var UpdatedValid: Boolean; var AgeOriginal: TDateTime; var OriginalValid: Boolean; var AgeDigitized: TDateTime; var DigitizedValid: Boolean): Boolean;
var
  fs: TFileStream;
  TiffHeaderPos: Int64;
  Offset: DWORD;
  BigEndian: Boolean;
  IFDNum: Word;
  IFD: TIFD;
  wBuf: Word;
  EntryNum: DWord;
  n, i: Integer;
  pos: Int64;
begin
  Result := False;
  UpdatedValid := False;
  OriginalValid := False;
  DigitizedValid := False;
  if not FileExists(Path) then
    Exit;
  try
    fs := TFileStream.Create(Path, fmOpenRead or fmShareDenyNone);
    try
      { ヘッダ情報を読取 }
      if not ReadHeader(fs, TiffHeaderPos, Offset, BigEndian, IFDNum) then
        Exit;
      { IFD を読取 }
      for n := 0 to IFDNum - 1 do
      begin
        fs.Position := TiffHeaderPos + Offset + SizeOf(Word) + n * SizeOf(TIFD);
        fs.Read(IFD, SizeOf(IFD));
        case GetWORD(IFD.Tag, BigEndian) of
          { 最後に変更された日時 }
          $0132:
            if GetAgeFromIFD(fs, TiffHeaderPos, GetDWORD(IFD.Data, BigEndian), GetDWORD(IFD.Count, BigEndian), GetWORD(IFD.DataType, BigEndian), AgeUpdated) then
            begin
              Result := True;
              UpdatedValid := True;
            end;
          { Exif データがみつかった }
          $8769:
          begin
            fs.Position := TiffHeaderPos + GetDWORD(IFD.Data, BigEndian);
            { エントリ数を取得 }
            fs.Read(wBuf, SizeOf(wBuf));
            EntryNum := GetWORD(wBuf, BigEndian);
            pos := fs.Position;
            for i := 0 to EntryNum - 1 do
            begin
              { エントリを取得 }
              fs.Position := pos + i * SizeOf(IFD);
              fs.Read(IFD, SizeOf(IFD));
              case GetWORD(IFD.Tag, BigEndian) of
                { 撮影された日時 }
                $9003:
                  if GetAgeFromIFD(fs, TiffHeaderPos, GetDWORD(IFD.Data, BigEndian), GetDWORD(IFD.Count, BigEndian), GetWORD(IFD.DataType, BigEndian), AgeOriginal) then
                  begin
                    Result := True;
                    OriginalValid := True;
                  end;
                { デジタル化された日時 }
                $9004:
                  if GetAgeFromIFD(fs, TiffHeaderPos, GetDWORD(IFD.Data, BigEndian), GetDWORD(IFD.Count, BigEndian), GetWORD(IFD.DataType, BigEndian), AgeDigitized) then
                  begin
                    Result := True;
                    DigitizedValid := True;
                  end;
              end;
            end;
          end;
        end;
      end;
    finally
      fs.Free;
    end;
  except
    { ... }
  end;
end;

function SetAgeToIFD(Data: TStream;
  TiffHeaderPos: Int64; Offset: DWORD; Count: DWORD; DataType: WORD; Age: TDateTime): Boolean;
var
  n: Integer;
  cBuf: Char;
  sBuf: String;
  OldDateSep, OldTimeSep: Char;
begin
  Result := False;
  if DataType <> 2 then
    Exit;
  OldDateSep := DateSeparator; OldTimeSep := TimeSeparator;
  try
    Data.Position := TiffHeaderPos + Offset;
    DateSeparator := ':'; TimeSeparator := ':';
    sBuf := FormatDateTime('yyyy/mm/dd hh:nn:ss', Age);
    for n := 1 to Count do
    begin
      cBuf := sBuf[n];
      Data.Write(cBuf, SizeOf(cBuf));
    end;
    Result := True;
  finally
    DateSeparator := OldDateSep; TimeSeparator := OldTimeSep;
  end;
end;

function ExifSetAge(Path: String; AgeUpdated: TDateTime; UpdatedValid: Boolean; AgeOriginal: TDateTime; OriginalValid: Boolean; AgeDigitized: TDateTime; DigitizedValid:Boolean): Boolean;
var
  fs: TFileStream;
  TiffHeaderPos: Int64;
  Offset: DWORD;
  BigEndian: Boolean;
  IFDNum: Word;
  IFD: TIFD;
  wBuf: Word;
  EntryNum: Word;
  n, i: Integer;
  pos: Int64;
begin
  Result := False;
  if not FileExists(Path) then
    Exit;
  try
    fs := TFileStream.Create(Path, fmOpenReadWrite or fmShareDenyWrite);
    try
      { ヘッダ情報を読取 }
      if not ReadHeader(fs, TiffHeaderPos, Offset, BigEndian, IFDNum) then
        Exit;
      { IFD を読取 }
      for n := 0 to IFDNum - 1 do
      begin
        fs.Position := TiffHeaderPos + Offset + SizeOf(Word) + n * SizeOf(TIFD);
        fs.Read(IFD, SizeOf(IFD));
        case GetWORD(IFD.Tag, BigEndian) of
          { 最後に変更された日時 }
          $0132:
          begin
            if not UpdatedValid then
              Continue;
            Result := SetAgeToIFD(fs, TiffHeaderPos, GetDWORD(IFD.Data, BigEndian),
              GetDWORD(IFD.Count, BigEndian), GetWORD(IFD.DataType, BigEndian), AgeUpdated);
          end;
          { Exif データがみつかった }
          $8769:
          begin
            fs.Position := TiffHeaderPos + GetDWORD(IFD.Data, BigEndian);
            { エントリ数を取得 }
            fs.Read(wBuf, SizeOf(wBuf));
            EntryNum := GetWORD(wBuf, BigEndian);
            pos := fs.Position;
            for i := 0 to EntryNum - 1 do
            begin
              { エントリを取得 }
              fs.Position := pos + i * SizeOf(IFD);
              fs.Read(IFD, SizeOf(IFD));
              case GetWORD(IFD.Tag, BigEndian) of
                { 撮影された日時 }
                $9003:
                begin
                  if not OriginalValid then
                    Continue;
                  Result := SetAgeToIFD(fs, TiffHeaderPos, GetDWORD(IFD.Data, BigEndian),
                    GetDWORD(IFD.Count, BigEndian), GetWORD(IFD.DataType, BigEndian), AgeOriginal);
                end;
                { デジタル化された日時 }
                $9004:
                begin
                  if not DigitizedValid then
                    Continue;
                  Result := SetAgeToIFD(fs, TiffHeaderPos, GetDWORD(IFD.Data, BigEndian),
                    GetDWORD(IFD.Count, BigEndian), GetWORD(IFD.DataType, BigEndian), AgeDigitized);
                end;
              end;
            end;
          end;
        end;
      end;
    finally
      fs.Free;
    end;
  except
    { ... }
  end;
end;

{ 稼動している OS が NT 系かどうか }

function OsIsWinNt: Boolean;
var
  osvi: TOSVersionInfo;
begin
  osvi.dwOSVersionInfoSize := sizeof(TOSVersionInfo);
  GetVersionEx(osvi);
  if osvi.dwPlatformId = VER_PLATFORM_WIN32_NT then
    Result := True
  else
    Result := False;
end;

{ ロングファイル名を取得する }

function GetLongFileName(const Value: String): String;
var
  ItemIDList: PItemIDList;
  LongPath: String;
begin
  Result := Value;
  if PathIsUNC(PChar(Value)) then
    Exit;
  if GetIDListFromPath(Value, ItemIDList) then
  try
    if GetPathFromItemIDList(ItemIDList, LongPath) then
      Result := LongPath;
  finally
    FreeItemID(ItemIDList);
  end;
end;

{ ファイルの概要の日時を取得/設定する }

const
  FmtID_SummaryInformation: TGUID = '{F29F85E0-4FF9-1068-AB91-08002B27B3D9}';
  IID_IPropertySetStorage : TGUID = '{0000013A-0000-0000-C000-000000000046}';
  STGFMT_ANY = 4;

function DocGetAge(Path: String; var CreatedAge: TDateTime; var CreatedValid: Boolean; var LastSavedAge: TDateTime; var LastSavedValid: Boolean): Boolean;
var
  Stg: IStorage;
  PropSetStg: IPropertySetStorage;
  PropStg: IPropertyStorage;
  PropSpec: array[12..13] of TPropSpec;
  PropVariant: array[12..13] of TPropVariant;
  hr: HResult;
begin
  CreatedValid := False;
  LastSavedValid := False;
  Result := False;
  if not FileExists(Path) then
    Exit;
  try
    OleCheck(StgOpenStorage(PWideChar(WideString(Path)), nil, STGM_READ or STGM_SHARE_EXCLUSIVE,
      nil, 0, Stg));
    PropSetStg := Stg as IPropertySetStorage;
    OleCheck(PropSetStg.Open(FmtID_SummaryInformation, STGM_READ or STGM_SHARE_EXCLUSIVE,
      PropStg));
    PropSpec[12].ulKind := PRSPEC_PROPID;
    PropSpec[12].PropID := 12;
    PropSpec[13].ulKind := PRSPEC_PROPID;
    PropSpec[13].PropID := 13;
    hr := PropStg.ReadMultiple(2, @PropSpec, @PropVariant);
    OleCheck(hr);
    if Failed(hr) then
      Exit;
    CreatedAge := FileTimeToDateTime(PropVariant[12].FileTime);
    LastSavedAge := FileTimeToDateTime(PropVariant[13].FileTime);
    CreatedValid := True;
    LastSavedValid := True;
    Result := True;
  except
  end;
end;

function StgOpenStorageEx(
  const pwcsName : POleStr;  { Pointer to the path of the file containing storage object }
  grfMode : LongInt;         { Specifies the access mode for the object }
  stgfmt : DWORD;            { Specifies the storage file format }
  grfAttrs : DWORD;          { Reserved; must be zero }
  pStgOptions : Pointer;     { Address of STGOPTIONS pointer }
  reserved2 : Pointer;       { Reserved; must be zero }
  riid : PGUID;              { Specifies the GUID of the interface pointer }
  out stgOpen :              { Address of an interface pointer }
  IStorage) : HResult; stdcall; external 'ole32.dll';

function DocSetAge(Path: String; CreatedAge: TDateTime; CreatedValid: Boolean; LastSavedAge: TDateTime; LastSavedValid: Boolean): Boolean;
var
  Stg: IStorage;
  PropSetStg: IPropertySetStorage;
  PropStg: IPropertyStorage;
  PropSpec: array[12..13] of TPropSpec;
  PropVariant: array[12..13] of TPropVariant;
  hr: HResult;
begin
  Result := False;
  if not FileExists(Path) then
    Exit;
  try
    OleCheck(StgOpenStorageEx(PWideChar(WideString(Path)), STGM_READWRITE or STGM_SHARE_EXCLUSIVE, STGFMT_ANY,
      0, nil,  nil, @IID_IPropertySetStorage, Stg));
    PropSetStg := Stg as IPropertySetStorage;
    { 一旦日時を読込 }
    OleCheck(PropSetStg.Open(FmtID_SummaryInformation, STGM_READ or STGM_SHARE_EXCLUSIVE,
      PropStg));
    PropSpec[12].ulKind := PRSPEC_PROPID;
    PropSpec[12].PropID := 12;
    PropSpec[13].ulKind := PRSPEC_PROPID;
    PropSpec[13].PropID := 13;
    hr := PropStg.ReadMultiple(2, @PropSpec, @PropVariant);
    OleCheck(hr);
    if Failed(hr) then
      Exit;
    { 続いて日時を書込 }
    OleCheck(PropSetStg.Create(FmtID_SummaryInformation, FmtID_SummaryInformation,
      PROPSETFLAG_DEFAULT, STGM_CREATE or STGM_READWRITE or STGM_SHARE_EXCLUSIVE, PropStg));
    if CreatedValid then
    begin
      PropSpec[12].ulKind := PRSPEC_PROPID;
      PropSpec[12].PropID := 12;
      PropVariant[12].vt := VT_FILETIME;
      PropVariant[12].FileTime := DateTimeToFileTime(CreatedAge);
    end;
    if LastSavedValid then
    begin
      PropSpec[13].ulKind := PRSPEC_PROPID;
      PropSpec[13].PropID := 13;
      PropVariant[13].vt := VT_FILETIME;
      PropVariant[13].FileTime := DateTimeToFileTime(LastSavedAge);
    end;
    hr := PropStg.WriteMultiple(2, @PropSpec, @PropVariant, 0);
    OleCheck(hr);
    if Failed(hr) then
      Exit;
    PropStg.Commit(STGC_DEFAULT);
    Result := True;
  except
  end;
end;

function PdfGetAge(Path: String; var CreationAge: TDateTime; var CreationValid: Boolean; var ModAge: TDateTime; var ModValid: Boolean): Boolean;
var
  fs: TFileStream;
  buf: array [0..128] of Char;
  ms: TMemoryStream;
  p1, p2, p3: PChar;
  s: String;
  yy, mm, dd, hh, nn, ss: Word;
  dt: TDateTime;
begin
  CreationValid := False;
  ModValid := False;
  Result := False;
  if not FileExists(Path) then
    Exit;
  if not SameText(ExtractFileExt(Path), '.pdf') then
    Exit;
  try
	  fs := TFileStream.Create(path, fmOpenRead or fmShareDenyNone);
	  try
	    { PDF ファイルか確認 }
	    fs.Read(buf, 5);
	    if StrlComp(buf, PChar('%PDF-'), 5) <> 0 then
	      Exit;
	  finally
	    fs.Free;
	  end;
	  ms := TMemoryStream.Create;
	  try
	    ms.LoadFromFile(path);
	    { 作成日時を取得 }
	    p1 := ms.Memory;
	    p3 := p1 + ms.Size;
	    while p1 <= p3 do
	    begin
	      if CompareMem(p1, PChar('/CreationDate'), 13) then break;
	      Inc(p1);
	    end;
	    while p1 <= p3 do
	    begin
	      if CompareMem(p1, PChar('(D:'), 3) then break;
	      Inc(p1);
	    end;
	    if p1 <= p3 then
	    begin
	  	  Inc(p1, 3);
		    yy := StrToInt(Copy(p1,  1, 4));
		    mm := StrToInt(Copy(p1,  5, 2));
	  	  dd := StrToInt(Copy(p1,  7, 2));
		    hh := StrToInt(Copy(p1,  9, 2));
		    nn := StrToInt(Copy(p1, 11, 2));
	  	  ss := StrToInt(Copy(p1, 13, 2));
		    CreationAge := EncodeDate(yy, mm, dd) + EncodeTime(hh, nn, ss, 0);
	      CreationValid := True;
	    end;
	    { 更新日時を取得 }
	    p1 := ms.Memory;
		  p3 := p1 + ms.Size;
		  while p1 <= p3 do
		  begin
		    if CompareMem(p1, PChar('/ModDate'), 8) then break;
		    Inc(p1);
		  end;
		  while p1 <= p3 do
		  begin
		    if CompareMem(p1, PChar('(D:'), 3) then break;
		    Inc(p1);
		  end;
		  if p1 <= p3 then
	    begin
	     Inc(p1, 3);
		    yy := StrToInt(Copy(p1,  1, 4));
		    mm := StrToInt(Copy(p1,  5, 2));
	      dd := StrToInt(Copy(p1,  7, 2));
		    hh := StrToInt(Copy(p1,  9, 2));
		    nn := StrToInt(Copy(p1, 11, 2));
	  	  ss := StrToInt(Copy(p1, 13, 2));
		    ModAge := EncodeDate(yy, mm, dd) + EncodeTime(hh, nn, ss, 0);
	      ModValid := True;
	    end;
	    Result := True;
	  finally
	    ms.Free;
	  end;
  except
  end;
end;

function PdfSetAge(Path: String; CreationAge: TDateTime; CreationValid: Boolean; ModAge: TDateTime; ModValid: Boolean): Boolean;
var
  fs: TFileStream;
  buf: array [0..128] of Char;
  ms: TMemoryStream;
  p1, p2, p3: PChar;
  s: String;
begin
  Result := False;
  if not FileExists(Path) then
    Exit;
  try
	  fs := TFileStream.Create(path, fmOpenRead or fmShareDenyNone);
	  try
	    { PDF ファイルか確認 }
	    fs.Read(buf, 5);
	    if StrlComp(buf, PChar('%PDF-'), 5) <> 0 then
	      Exit;
	  finally
	    fs.Free;
	  end;
	  ms := TMemoryStream.Create;
	  try
	    ms.LoadFromFile(path);
	    { 作成日時を更新 }
	    if CreationValid then
	    begin
		    p1 := ms.Memory;
		    p3 := p1 + ms.Size;
		    while p1 <= p3 do
		    begin
		      if CompareMem(p1, PChar('/CreationDate'), 13) then break;
		      Inc(p1);
		    end;
		    while p1 <= p3 do
		    begin
		      if CompareMem(p1, PChar('(D:'), 3) then break;
		      Inc(p1);
		    end;
		    if p1 <= p3 then
	      begin
	  	    Inc(p1, 3);
		      s := FormatDateTime('yyyymmddhhnnss', CreationAge);
		      CopyMemory(p1, PChar(s), Length(s));
	      end;
	    end;
	    { 更新日時を更新 }
	    if ModValid then
	    begin
		    p1 := ms.Memory;
		    p3 := p1 + ms.Size;
		    while p1 <= p3 do
		    begin
		      if CompareMem(p1, PChar('/ModDate'), 8) then break;
		      Inc(p1);
		    end;
		    while p1 <= p3 do
		    begin
		      if CompareMem(p1, PChar('(D:'), 3) then break;
		      Inc(p1);
		    end;
		    if p1 <= p3 then
	      begin
	  	    Inc(p1, 3);
		      s := FormatDateTime('yyyymmddhhnnss', ModAge);
		      CopyMemory(p1, PChar(s), Length(s));
	      end;
	    end;
	    ms.SaveToFile(path);
	    Result := True;
	  finally
	    ms.Free;
	  end;
  except
  end;
end;

end.
