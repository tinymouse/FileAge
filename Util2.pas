unit Util2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Math;

type
  TEditEx = class(TEdit)
  protected
    procedure CreateParams(var params: TCreateParams); override;
  end;

  TDateTimeDiff = class(TFrame)
    edtYY: TEditEx;
    Label1: TLabel;
    edtMM: TEditEx;
    Label2: TLabel;
    edtDD: TEditEx;
    updnDate: TUpDown;
    edtHH: TEditEx;
    Label3: TLabel;
    edtNN: TEditEx;
    Label4: TLabel;
    edtSS: TEditEx;
    updnTime: TUpDown;
    procedure updnDateTimeChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditExit(Sender: TObject);
  private
    { Private êÈåæ }
    function GetYY: Integer;
    function GetMM: Integer;
    function GetDD: Integer;
    function GetHH: Integer;
    function GetNN: Integer;
    function GetSS: Integer;
  protected
    { Protected êÈåæ }
    procedure SetEnabled(Value: Boolean); override;
  public
    { Public êÈåæ }
    procedure Reset;
    property YY: Integer read GetYY;
    property MM: Integer read GetMM;
    property DD: Integer read GetDD;
    property HH: Integer read GetHH;
    property NN: Integer read GetNN;
    property SS: Integer read GetSS;
    property Enabled: Boolean write SetEnabled;
  end;

implementation

{$R *.dfm}

procedure TEditEx.CreateParams(var params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_RIGHT { or ES_NUMBER };
end;

procedure TDateTimeDiff.Reset;
begin
  edtYY.Text := '0';
  edtMM.Text := '0';
  edtDD.Text := '0';
  edtHH.Text := '0';
  edtNN.Text := '0';
  edtSS.Text := '0';
end;

procedure TDateTimeDiff.updnDateTimeChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
begin
  TEdit(Screen.ActiveControl).Text := IntToStr(StrToInt(TEdit(Screen.ActiveControl).Text) + IfThen(Direction = updUp, 1, -1));
end;

function TDateTimeDiff.GetYY: Integer;
begin
  Result := StrToInt(edtYY.Text);
end;

function TDateTimeDiff.GetMM: Integer;
begin
  Result := StrToInt(edtMM.Text);
end;

function TDateTimeDiff.GetDD: Integer;
begin
  Result := StrToInt(edtDD.Text);
end;

function TDateTimeDiff.GetHH: Integer;
begin
  Result := StrToInt(edtHH.Text);
end;

function TDateTimeDiff.GetNN: Integer;
begin
  Result := StrToInt(edtNN.Text);
end;

function TDateTimeDiff.GetSS: Integer;
begin
  Result := StrToInt(edtSS.Text);
end;

procedure TDateTimeDiff.SetEnabled(Value: Boolean);
begin
  edtYY.Enabled := Value;
  edtMM.Enabled := Value;
  edtDD.Enabled := Value;
  updnDate.Enabled := Value;
  edtHH.Enabled := Value;
  edtNN.Enabled := Value;
  edtSS.Enabled := Value;
  updnTime.Enabled := Value;
end;

procedure TDateTimeDiff.EditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', '-']) then
    Key := #0;
end;

procedure TDateTimeDiff.EditExit(Sender: TObject);

  function IsNumeric(Value: String ): Boolean;
  begin
    Result := True;
    try
      StrToInt(Value);
    except
      Result := False;
    end;
  end;

begin
  if not IsNumeric(TEdit(Sender).Text) then
  begin
    MessageDlg('êîéöÇì¸óÕÇµÇƒâ∫Ç≥Ç¢', mtError, [mbOK], 0);
    TWinControl(Sender).SetFocus;
  end;
end;

end.
