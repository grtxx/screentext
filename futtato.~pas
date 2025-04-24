unit futtato;

interface

uses
  Windows, Classes, Controls, dumagep, Forms, Dialogs, SysUtils, ComCtrls,
  StdCtrls;

type
  TRunWin = class(TForm)
    Roll1: TRoll;
    procedure FormCreate(Sender: TObject);
    procedure Roll1PositionChange(Sender: TObject); virtual;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Roll1StatusChange(Sender: TObject; status: Byte);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RunWin: TRunWin;

implementation

uses feltolto;

{$R *.DFM}

procedure TRunWin.FormCreate(Sender: TObject);
var
  monitors: byte;
begin
  monitors:=1;
  width:=640;
  height:=480;
  if Screen.MonitorCount>monitors then
  begin
    OptionsWin.InitDisplay(monitors);
    left:=Screen.Monitors[monitors].Left;
    top:=Screen.Monitors[monitors].top;
  end;
  Roll1.Memo:=OptionsWin.Memo1;
  Roll1.CalibrateJoy;
end;

procedure TRunWin.Roll1PositionChange(Sender: TObject);
begin
  OptionsWin.Roll1.Position:=Roll1.Position;
end;

procedure TRunWin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer;
begin
  if ((key=27) and (Screen.MonitorCount=1)) then
  begin
    OptionsWin.DoneDisplay;
    RunWin.Hide;
    OptionsWin.Show;
  end;
  Case key of
  40: for i:=1 to 10 do Roll1.Position:=Roll1.Position+5;
  38: for i:=1 to 10 do Roll1.Position:=Roll1.Position-5;
  end;
end;

procedure TRunWin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=OptionsWin.SystemClose;
end;

procedure TRunWin.Roll1StatusChange(Sender: TObject; status: Byte);
begin
  Case Status of
  0: OptionsWin.StaticText3.Caption:='D. GOMBVEZÉRLÉS';
  1: OptionsWin.StaticText3.Caption:='MEGÁLLÍTVA';
  2: OptionsWin.StaticText3.Caption:='ELINDÍTVA';
  3: OptionsWin.StaticText3.Caption:='ANALOG GOMBVEZÉRLÉS';
  4: OptionsWin.StaticText3.Caption:='ÜZENET MÓD';
  end;
end;

end.
