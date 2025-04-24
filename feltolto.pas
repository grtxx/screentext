unit feltolto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dumagep, mmsystem, ExtCtrls, ComCtrls, registry, fileobject, brdiag, DateUtils;

type
  TOptionsWin = class(TForm)
    Memo1: TMemo;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Timer2: TTimer;
    Button5: TButton;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Roll1: TRoll;
    Button9: TButton;
    Button10: TButton;
    OpenDialog2: TOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button1: TButton;
    TrackBar1: TTrackBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StaticText2: TStaticText;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Button7: TButton;
    Button8: TButton;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Runbutton: TButton;
    StaticText1: TStaticText;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    TabSheet5: TTabSheet;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Button11: TButton;
    Bevel1: TBevel;
    ShowMessage: TCheckBox;
    CheckBox5: TCheckBox;
    Timer4: TTimer;
    StaticText4: TStaticText;
    Bevel2: TBevel;
    Panel1: TPanel;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    Label1: TLabel;
    Edit1: TEdit;
    StaticText3: TStaticText;
    stopper_running: TCheckBox;
    stopper_autostop: TCheckBox;
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RunbuttonClick(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Checkbox4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure Button5Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure ShowMessageClick(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Roll1PositionChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Edit2Change(Sender: TObject);
    procedure stopper_runningClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    INI: TRegIniFile;
    SystemClose: Boolean;
    BaseTime: int64;
    LastBState: Boolean;
    ow,oh: word;
    currenttime: int64;
    Procedure GetDefaults; virtual;
    procedure InitDisplay(mn: byte); virtual;
    procedure DoneDisplay; virtual;
  end;

var
  OptionsWin: TOptionsWin;

implementation

uses futtato;

{$R *.DFM}

procedure TOptionsWin.InitDisplay;
var
  a: DevMode;
begin
  if mn=0 then
  begin
    a.dmSize:=SizeOf(a);
    a.dmFields:=dm_PelsWidth or dm_PelsHeight;
    a.dmPelsWidth:=640;
    a.dmPelsHeight:=480;
    ChangeDisplaySettings(a,0);
  end;
end;

procedure TOptionsWin.DoneDisplay;
var
  a: DevMode;
begin
  if ow<>Screen.monitors[0].width then
  begin
    FillChar(a,SizeOf(a),0);
    a.dmSize:=SizeOf(a);
    a.dmFields:=dm_PelsWidth or dm_PelsHeight;
    a.dmPelsWidth:=ow;
    a.dmPelsHeight:=oh;
    ChangeDisplaySettings(a,0);
  end;
  Width:=800;
  Height:=523;
end;

procedure TOptionsWin.CheckBox1Click(Sender: TObject);
begin
  Case (Sender=Checkbox1) of
  true: begin
          RunWin.Roll1.MirrorX:=CheckBox1.Checked;
          INI.WriteBool('Show','XMirror',CheckBox1.Checked);
        end;
  false: begin
          RunWin.Roll1.MirrorY:=CheckBox2.Checked;
          INI.WriteBool('Show','YMirror',CheckBox2.Checked);
         end;
  end;
end;

procedure TOptionsWin.Button1Click(Sender: TObject);
begin
  RunWin.Roll1.CalibrateJoy;
  INI.WriteInteger('Controls','JoyCenter',RunWin.Roll1.JoyCenter);
end;

Procedure TOptionswin.GetDefaults;
var
  name1,name2: string;
  size1,size2: byte;
  color1,color2,color3,color4: TColor;
begin
  name1:='Arial CE';
  name2:='Tahoma';
  size1:=34;
  size2:=48;
  color1:=$ffffff;
  color2:=$000000;
  color3:=$000000;
  color4:=$ffffff;
  Roll1.Font.Name:=name1;    RunWin.Roll1.Font.Name:=name1;
  Roll1.Font.Size:=size1;    RunWin.Roll1.Font.Size:=size1;
  Roll1.Font.Color:=color1;  RunWin.Roll1.Font.Color:=color1;

  Roll1.Font2.Name:=name2;   RunWin.Roll1.Font2.Name:=name2;
  Roll1.Font2.Size:=size2;   RunWin.Roll1.Font2.Size:=size2;
  Roll1.Font2.Color:=color2; RunWin.Roll1.Font2.Color:=color2;

  Roll1.BackColor:=color3;   RunWin.Roll1.BackColor:=color3;
  Roll1.BackColor2:=color4;  RunWin.Roll1.BackColor2:=color4;
end;

procedure TOptionsWin.FormCreate(Sender: TObject);
begin
  ow:=Screen.monitors[0].width;
  oh:=Screen.monitors[0].height;
  BaseTime:=DateTimeToUnix(Now);
  SystemClose:=false;
//
//
//    VISSZAÍRNI
//
//
  if Screen.MonitorCount>1 then
  begin
    Statictext1.caption:='Futási mód:'+#13#10+'KÉT MONITOROS RENDSZER';
    RunButton.enabled:=false;
  end else Statictext1.caption:='Futási mód:'+#13#10+'EGY MONITOROS RENDSZER';
  RunWin:=TRunWin.Create(Nil);
  Roll1.Style:=true;
  Roll1.WorkWidth:=640;
  GetDefaults;
  INI:=TRegIniFile.Create('ScreenText2');
  Checkbox3.Checked:=INI.ReadBool('Controls','Joy',false);
  RunWin.Roll1.EnableJoyControl:=CheckBox3.Checked;
  Checkbox1.Checked:=INI.ReadBool('Show','XMirror',false);
  Checkbox2.Checked:=INI.ReadBool('Show','YMirror',true);
  Edit1.Text:=Ini.ReadString('Message','MsgText','');

  roll1.BackColor:=ini.ReadInteger('Actualsettings','backcolor1',$000000);
  roll1.BackColor2:=ini.ReadInteger('Actualsettings','backcolor2',$ffffff);

  roll1.Font.Name:=ini.ReadString('Actualsettings','font1name','');
  roll1.Font.Size:=ini.ReadInteger('Actualsettings','font1size',50);
  roll1.Font.Color:=ini.ReadInteger('Actualsettings','font1color',$ffffff);
  roll1.Font.Style:=[];
  if ini.ReadBool('Actualsettings','font1bold',false) then roll1.Font.Style:=roll1.Font.Style+[fsBold];
  if ini.ReadBool('Actualsettings','font1italic',false) then roll1.Font.Style:=roll1.Font.Style+[fsItalic];

  roll1.Font2.Name:=ini.ReadString('Actualsettings','font2name','');
  roll1.Font2.Size:=ini.ReadInteger('Actualsettings','font2size',50);
  roll1.Font2.Color:=ini.ReadInteger('Actualsettings','font2color',$000000);
  roll1.Font2.Style:=[];
  if ini.ReadBool('Actualsettings','font2bold',false) then roll1.Font2.Style:=roll1.Font2.Style+[fsBold];
  if ini.ReadBool('Actualsettings','font2italic',false) then roll1.Font2.Style:=roll1.Font2.Style+[fsItalic];

  runwin.Roll1.font.Assign(roll1.font);
  runwin.Roll1.font2.Assign(roll1.font2);
  runwin.Roll1.BackColor:=roll1.BackColor;
  runwin.Roll1.BackColor2:=roll1.BackColor2;

  RadioButton3.Checked:=INI.ReadBool('Message','Mode1',false);
  RadioButton4.Checked:=INI.ReadBool('Message','Mode2',true);
  RadioButton5.Checked:=INI.ReadBool('Message','Mode3',false);
  CheckBox5.Checked:=   INI.ReadBool('Message','WithController',true);
  RadioButton6.Checked:=INI.ReadBool('Message','Mode4',true);
  RadioButton7.Checked:=INI.ReadBool('Message','Mode5',false);
  UpDown1.Position:=    INI.ReadInteger('Message','CounterPos',0);
  RunWin.Roll1.JoyMode:=INI.ReadInteger('Controls','JoyMode',0);
  Case RunWin.Roll1.JoyMode of
  0: begin
       Checkbox4.Checked:=false;
     end;
  1: begin
       Checkbox4.Checked:=true;
       RadioButton1.Checked:=true;
     end;
  2: begin
       Checkbox4.Checked:=true;
       RadioButton2.Checked:=true;
     end;
  end;
  RunWin.Roll1.MirrorX:=CheckBox1.Checked;
  RunWin.Roll1.MirrorY:=CheckBox2.Checked;
  TrackBar1.Position:=INI.ReadInteger('Controls','JoySensitivity',1000);
  RunWin.Roll1.JoyCenter:=INI.ReadInteger('Controls','JoyCenter',32000);
//
//
//    VISSZAÍRNI
//
//
  if Screen.MonitorCount>1 then RunWin.Show;
end;

procedure TOptionsWin.RunbuttonClick(Sender: TObject);
begin
  InitDisplay(0);
  OptionsWin.Hide;
  RunWin.Show;
end;

procedure TOptionsWin.CheckBox3Click(Sender: TObject);
begin
  INI.WriteBool('Controls','Joy',Checkbox3.Checked);
  RunWin.Roll1.EnableJoyControl:=CheckBox3.Checked;
end;

procedure TOptionsWin.Checkbox4Click(Sender: TObject);
begin
  radiobutton1.enabled:=Checkbox4.checked;
  radiobutton2.enabled:=Checkbox4.checked;
  if not CheckBox4.Checked then RunWin.Roll1.JoyMode:=0 else
    radiobutton1click(nil);
  INI.WriteInteger('Controls','JoyMode',RunWin.Roll1.JoyMode);
end;

procedure TOptionsWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DoneDisplay;
  Systemclose:=true;
  Ini.Free;
end;

procedure TOptionsWin.FormActivate(Sender: TObject);
begin
  Left:=Screen.Monitors[0].Left+Screen.Monitors[0].Width div 2-width div 2;
  Top:=Screen.Monitors[0].Top+Screen.Monitors[0].Height div 2-height div 2;
  Button9Click(nil);
end;

procedure TOptionsWin.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  RunWin.Roll1.Position:=ScrollBar1.Position;
  ScrollBar2.Position:=0;
end;

procedure TOptionsWin.Button5Click(Sender: TObject);
begin
  ScrollBar2.Position:=0;
end;

procedure TOptionsWin.Timer2Timer(Sender: TObject);
var
  i: integer;
begin
  if ScrollBar2.Position<>0 then
  begin
    for i:=1 to abs(ScrollBar2.Position) do
    RunWin.Roll1.Position:=RunWin.Roll1.Position+ScrollBar2.Position;
  end;
end;

procedure TOptionsWin.Button4Click(Sender: TObject);
begin
  if Sender=Button4 then ColorDialog1.Color:=Roll1.BackColor else ColorDialog1.Color:=Roll1.BackColor2;
  if ColorDialog1.Execute then
  begin
    if Sender=Button4 then
    begin
      Roll1.BackColor:=ColorDialog1.Color;
      RunWin.Roll1.BackColor:=ColorDialog1.Color;
    end;
    if Sender=Button6 then
    begin
      Roll1.BackColor2:=ColorDialog1.Color;
      RunWin.Roll1.BackColor2:=ColorDialog1.Color;
    end;
    Button9Click(nil);
    ini.WriteInteger('ActualSettings','BackColor1',roll1.BackColor);
    ini.WriteInteger('ActualSettings','BackColor2',roll1.BackColor2);
  end;
end;

procedure TOptionsWin.Button2Click(Sender: TObject);
begin
  if Sender=Button2 then FontDialog1.Font.Assign(Roll1.Font) else FontDialog1.Font.Assign(Roll1.Font2);
  if FontDialog1.Execute then
  begin
    if Sender=Button2 then
    begin
      RunWin.Roll1.Font.Assign(FontDialog1.Font);
      Roll1.Font.Assign(FontDialog1.Font);
    end;
    if Sender=Button3 then
    begin
      RunWin.Roll1.Font2.Assign(FontDialog1.Font);
      Roll1.Font2.Assign(FontDialog1.Font);
    end;
    Button9Click(nil);

    ini.WriteString('ActualSettings','font1name',roll1.font.name);
    ini.WriteInteger('ActualSettings','font1size',roll1.font.size);
    ini.WriteInteger('ActualSettings','font1color',roll1.font.color);
    ini.WriteBool('ActualSettings','font1italic',fsItalic in roll1.font.style);
    ini.WriteBool('ActualSettings','font1Bold',fsBold in roll1.font.style);


    ini.WriteString('ActualSettings','font2name',roll1.font2.name);
    ini.WriteInteger('ActualSettings','font2size',roll1.font2.size);
    ini.WriteInteger('ActualSettings','font2color',roll1.font2.color);
    ini.WriteBool('ActualSettings','font2italic',fsItalic in roll1.font2.style);
    ini.WriteBool('ActualSettings','font2Bold',fsBold in roll1.font2.style);

    ini.WriteInteger('ActualSettings','BackColor1',roll1.BackColor);
    ini.WriteInteger('ActualSettings','BackColor2',roll1.BackColor2);
  end;
end;

procedure TOptionsWin.Button7Click(Sender: TObject);
var
  F: TFileObject;
begin
  Opendialog1.filename:='';
  if Opendialog1.Execute then
  begin
    F.Create(OpenDialog1.filename,1);
    F.OpenForRead;
    if F.ReadString='SUGOGEP_PRESET_FILE' then
    begin
      F.ReadString;
      Roll1.BackColor:=F.ReadInteger;
      Roll1.BackColor2:=F.ReadInteger;
      FontLoad(Roll1.Font,F);
      FontLoad(Roll1.Font2,F);
      F.WriteString('EOF');
    end else beep;
    F.Close;
    RunWin.Roll1.BackColor:=Roll1.BackColor;
    RunWin.Roll1.BackColor2:=Roll1.BackColor2;
    RunWin.Roll1.Font.Assign(Roll1.Font);
    RunWin.Roll1.Font2.Assign(Roll1.Font2);
    Button9Click(nil);
  end;
end;

procedure TOptionsWin.Button8Click(Sender: TObject);
var
  F: TFileObject;
begin
  Savedialog1.filename:=Opendialog1.filename;
  if Savedialog1.Execute then
  begin
    F.Create(SaveDialog1.filename,1);
    F.OpenForWrite;
    F.WriteString('SUGOGEP_PRESET_FILE');
    F.WriteString('V1.00');
    F.WriteInteger(Roll1.BackColor);
    F.WriteInteger(Roll1.BackColor2);
    FontSave(Roll1.Font,F);
    FontSave(Roll1.Font2,F);
    F.WriteString('EOF');
    F.Close;
  end;
end;

procedure TOptionsWin.TrackBar1Change(Sender: TObject);
begin
  runwin.roll1.joysensitivity:=TrackBar1.Position;
  INI.WriteInteger('Controls','JoySensitivity',TrackBar1.Position);
end;

procedure TOptionsWin.Button9Click(Sender: TObject);
begin
  Roll1.Render;
  RunWin.Roll1.Render;
  if RunWin.Roll1.GetMaxPos>0 then
    ScrollBar1.Max:=RunWin.Roll1.GetMaxPos else
    ScrollBar1.Max:=0;
  ProgressBar1.Max:=RunWin.Roll1.maxbufheight*31;
  ProgressBar1.Position:=RunWin.Roll1.GetMaxPos;
  RunWin.Roll1.ReFresh;
  Roll1.ReFresh;
end;

procedure TOptionsWin.RadioButton1Click(Sender: TObject);
begin
  if checkbox4.enabled then
  begin
    if radiobutton1.checked then RunWin.Roll1.JoyMode:=1 else RunWin.Roll1.JoyMode:=2;
  end;
  INI.WriteInteger('Controls','JoyMode',RunWin.Roll1.JoyMode);
end;

procedure TOptionsWin.Button10Click(Sender: TObject);
var
  f: system.text;
  s: string;
begin
  Opendialog2.filename:='';
  if Opendialog2.Execute then
  begin
    Memo1.Clear;
    system.Assign(f,Opendialog2.filename);
    Reset(f);
    While not eof(f) do
    begin
      ReadLn(f,s);
      Memo1.Lines.Add(s);
    end;
    system.close(f);
    Button9Click(nil);
  end;
end;

procedure TOptionsWin.CheckBox5Click(Sender: TObject);
begin
  ShowMessage.Enabled:=not CheckBox5.Checked;
  INI.WriteBool('Message','WithController',CheckBox5.Checked);
end;

procedure TOptionsWin.RadioButton3Click(Sender: TObject);
begin
  edit1.Enabled:=radiobutton3.checked;
  edit2.Enabled:=radiobutton5.checked;
  UpDown1.Enabled:=radiobutton5.checked;
  INI.WriteBool('Message','Mode1',RadioButton3.Checked);
  INI.WriteBool('Message','Mode2',RadioButton4.Checked);
  INI.WriteBool('Message','Mode3',RadioButton5.Checked);
end;

procedure TOptionsWin.ShowMessageClick(Sender: TObject);
begin
  if ShowMessage.Checked then
  begin
    if Runwin.Roll1.JoyStatus=2 then RunWin.Roll1.JoyStatus:=1;
    Runwin.Roll1.MsgMode:=true;
    Roll1.MsgMode:=true;
    Roll1.Msg:=' ';
    RunWin.Roll1.Msg:=' ';
  end else
  begin
    Runwin.Roll1.MsgMode:=false;
    Roll1.MsgMode:=false;
    Roll1.ReFresh;
    RunWin.Roll1.ReFresh;
  end;
end;

function Apnd(s: string;ac: char; ml: integer): string;
begin
  while length(s)<ml do s:=ac+s;
  Apnd:=s;
end;

procedure TOptionsWin.Timer4Timer(Sender: TObject);
var
  a: TJoyInfo;
  st: TSystemTime;
  hh,mm,ss: int64;
begin
  if not stopper_running.checked then
  begin
    BaseTime:=DateTimeToUnix(Now)+currenttime;
  end;
  if (stopper_autostop.checked) and (basetime=dateTimeToUnix(now)) then
  begin
    stopper_running.checked:=false;
  end;
  Case JoyGetPos(RunWin.Roll1.JoyNum,@a) of
  JOYERR_NOERROR:      StaticText2.Caption:='Hardver OK';
  MMSYSERR_NODRIVER:   StaticText2.Caption:='Nincs driver installálva';
  MMSYSERR_INVALPARAM: StaticText2.Caption:='Rossz installálás';
  JOYERR_UNPLUGGED:    StaticText2.Caption:='Nincs hardver!';
  else
    StaticText2.Caption:='Nincs hardver installálva';
  end;
  if JoyGetPos(RunWin.Roll1.JoyNum,@a)=JOYERR_NOERROR then
  begin
    if CheckBox5.Checked then
    begin
      Case Radiobutton6.checked of
      true: ShowMessage.Checked:=(a.wButtons and 4<>0);
      false: begin
               if (a.wButtons and 4=0) and LastBState=true then
               begin
                 if CheckBox3.Checked then ShowMessage.Checked:= not ShowMessage.Checked;
               end;
             end;
      end;
    end;
  end;
  LastBState:=(a.wButtons and 4<>0);
  hh:= abs(BaseTime-DateTimeToUnix(Now)) div 3600;
  mm:=(abs(BaseTime-DateTimeToUnix(Now)) div 60)-(hh*60);
  ss:= abs(BaseTime-DateTimeToUnix(Now)) - (mm*60) - (3600*hh);
  StaticText4.Caption:=Apnd(intToStr(hh),'0',2)+':'+
                       Apnd(intToStr(mm),'0',2)+':'+
                       Apnd(intToStr(ss),'0',2);
  if ShowMessage.Checked then
  begin
    if radiobutton3.checked then
    begin
      Roll1.Msg:=Edit1.Text;
      RunWin.Roll1.Msg:=Edit1.Text;
    end;
    if radiobutton4.checked then
    begin
      DateTimeToSystemTime(Now, St);
      Roll1.Msg:=Apnd(intToStr(St.wHour),'0',2)+':'+
                 Apnd(intToStr(St.wMinute),'0',2)+':'+
                 Apnd(intToStr(St.wSecond),'0',2);
      Runwin.Roll1.Msg:=Roll1.Msg;
    end;
    if radiobutton5.checked then
    begin
      Roll1.Msg:=StaticText4.Caption;
      Runwin.Roll1.Msg:=Roll1.Msg;
    end;
  end;
end;

procedure TOptionsWin.Button11Click(Sender: TObject);
begin
  BaseTime:=DateTimeToUnix(Now);
  BaseTime:=BaseTime+UpDown1.Position;
  currenttime:=updown1.position;
end;

procedure TOptionsWin.Roll1PositionChange(Sender: TObject);
begin
  ScrollBar1.Position:=round(Roll1.Position);
end;

procedure TOptionsWin.Edit1Change(Sender: TObject);
begin
  Ini.WriteString('Message','MsgText',Edit1.Text);
end;

procedure TOptionsWin.RadioButton6Click(Sender: TObject);
begin
  INI.WriteBool('Message','Mode4',RadioButton6.Checked);
  INI.WriteBool('Message','Mode5',RadioButton7.Checked);
end;

procedure TOptionsWin.UpDown1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  Ini.WriteInteger('Message','CounterPos',NewValue);
end;

procedure TOptionsWin.Edit2Change(Sender: TObject);
var
  i,c: integer;
begin
  val(edit2.text,i,c);
  if c=0 then Ini.WriteInteger('Message','CounterPos',i);
end;

procedure TOptionsWin.stopper_runningClick(Sender: TObject);
begin
  if stopper_running.checked=false then
  begin
    currenttime:=BaseTime-datetimeToUnix(Now);
  end;
end;

end.
