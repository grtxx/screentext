unit dumagep;

interface

uses windows,
     controls,
     Classes,
     Messages,
     Graphics,
     StdCtrls,
     SysUtils,
     ExtCtrls,
     MMSystem;

type
  TStatusChangeProc = procedure(Sender: TObject; status: byte) of object;
  PBufLine=^TBufLine;
  TBufLine=Array[0..1023] of Word;
  TRoll=Class(TWinControl)
    Canvas: TControlCanvas;
    Constructor Create(AP: TComponent); override;
    Destructor Destroy; override;
    Procedure WndProc(var Msg: TMessage); override;
    Procedure Paint;
    Procedure ReFresh; virtual;
    Function GetMaxPos: Integer; virtual;
    Procedure CalibrateJoy; virtual;
    Procedure Render; virtual;
    Procedure RenderMsg; virtual;
  Private
    Buffer: Array[0..31] of TBitmap;
    MsgBuffer: TBitmap;
    Buf: TBitmap;
    Mmo: TMemo;
    Timer: TTimer;
    BC, BC2: TColor;
    ActualPos: Single;
    MX,MY: Boolean;
    JoyControl: Boolean;
    JoyStat: Byte;
    { 0: nonanalog }
    { 1: stoped }
    { 2: started }
    { 3: buttoncontrol }
    { 4: messagemode }
    MJoy: Byte;
    { 0: digital button mode }
    { 1: start/stop mode }
    { 2: analog button mode }
    JN: Byte;
    JoyCntr: Integer;
    JoySens: Integer;
    OnPosChg: TNotifyEvent;
    OnStatChg: TStatusChangeProc;
    DMode: Boolean;
    WW, WH: Integer;
    Mesg: String;
    MsgM: Boolean;
    Function GetPos: Single;
    Procedure SetPos(AP: Single); virtual;
    Procedure SetMx(M: Boolean); virtual;
    Procedure SetMy(M: Boolean); virtual;
    Procedure SetMesg(M: String); virtual;
    Function GetMesg: String; virtual;
    Procedure SetJStat(J: Integer); virtual;
    Function GetJStat: integer; virtual;
    Procedure SetMsgM(mm: boolean); virtual;
    Function GetMsgM: boolean; virtual;
    Procedure SetMJoy(M: Byte); virtual;
    Function GetJoyControl: Boolean; virtual;
    Procedure SetJoyControl(j: Boolean); virtual;
    Procedure TimerProc(Sender: TObject); dynamic;
    Procedure SetJoySens(j: Integer); virtual;
    Procedure PosChg(Sender: TObject); virtual;
    Procedure StatChg(Sender: TObject; status: byte); virtual;
  Protected
  Public
    maxbuf, maxbufheight: integer;
    fullheight: integer;
  Published
    Font: TFont;
    Font2: TFont;
    Property Memo: TMemo read MMo write MMo;
    Property BackColor: TColor read BC write BC default $000000;
    Property BackColor2: TColor read BC2 write BC2 default $000000;
    Property Position: Single read GetPos write SetPos;
    Property MirrorX: Boolean read mx write Setmx;
    Property MirrorY: Boolean read my write Setmy;
    Property EnableJoyControl: Boolean read GetJoyControl write SetJoyControl default true;
    Property JoyNum: Byte read JN write JN default 0;
    Property JoySensitivity: Integer read JoySens write SetJoySens default 1000;
    Property JoyMode: Byte read MJoy write SetMJoy default 0;
    Property OnPositionChange: TNotifyEvent read OnPosChg write OnPosChg;
    Property OnStatusChange: TStatusChangeProc read OnStatChg write OnStatChg;
    Property JoyCenter: Integer read JoyCntr write JoyCntr;
    Property Style: Boolean read DMode write DMode;
    Property WorkWidth: Integer read WW write WW;
    Property WorkHeight: Integer read WH write WH;
    Property Msg: String read GetMesg write SetMesg;
    Property JoyStatus: integer read GetJStat write SetJStat;
    Property MsgMode: Boolean read GetMsgM write SetMsgM;
  end;


Procedure Register;

implementation

Procedure Register;
begin
  RegisterComponents('GRT Components', [TRoll]);
end;

Constructor TRoll.Create;
var
  i: integer;
begin
  Inherited Create(AP);
  Parent:=TWinControl(AP);

  Canvas:=TControlCanvas.Create;
  Canvas.Control:=Self;

  maxbuf:=0;
  maxbufheight:=30000;

  for i:=0 to 31 do
  begin
    Buffer[i]:=TBitmap.Create;
    Buffer[i].Pixelformat:=pf16bit;
  end;
  MsgBuffer:=TBitmap.Create;
  MsgBuffer.Pixelformat:=pf16bit;

  Buf:=TBitmap.Create;

  Font:=TFont.Create;
  Font2:=TFont.Create;

  Timer:=TTimer.Create(Self);
  Timer.Interval:=1;
  Timer.OnTimer:=TimerProc;
  JoySensitivity:=1000;
  OnPositionChange:=PosChg;
  OnStatusChange:=StatChg;
  JoyMode:=0;
  JoyStat:=0;
  Style:=false;
  MMo:=nil;
end;

Procedure TRoll.RenderMsg;
var
  i,j: integer;
  th: integer;
  P1,P2: PBufLine;
  R1,R2: TRect;
begin
  MsgBuffer.width:=Workwidth;
  MsgBuffer.height:=round(WorkWidth*0.75);
  MsgBuffer.Canvas.Brush.Color:=$000000;
  MsgBuffer.Canvas.Brush.Style:=bsSolid;
  MsgBuffer.Canvas.Rectangle(0,0,WorkWidth,MsgBuffer.Height);
  MsgBuffer.Canvas.Brush.Color:=$0000ff;
  MsgBuffer.Canvas.Rectangle(10,10,30,30);
  MsgBuffer.Canvas.Brush.Color:=BC;
  MsgBuffer.Canvas.Font:=Font;
  MsgBuffer.Canvas.Font.Color:=$ffffff;
  MsgBuffer.Canvas.TextOut(MsgBuffer.width  div 2-MsgBuffer.Canvas.TextWidth(Msg) div 2,
                           MsgBuffer.height div 2-MsgBuffer.Canvas.TextHeight(Msg) div 2, Msg);
  if MirrorX then
  begin
    for i:=0 to MsgBuffer.Height-1 do
    begin
      P1:=MsgBuffer.Scanline[i];
      for j:=0 to (width div 2)-1 do
      begin
        th:=P1[j];
        P1[j]:=P1[width-j-1];
        P1[width-j-1]:=th;
      end;
    end;
  end;
  if MirrorY then
  begin
    for i:=0 to ((MsgBuffer.Height div 2)-1) do
    begin
      P1:=MsgBuffer.Scanline[i];
      P2:=MsgBuffer.Scanline[MsgBuffer.Height-i-1];
      for j:=0 to width-1 do
      begin
        th:=P1[j];
        P1[j]:=P2[j];
        P2[j]:=th;
      end;
    end;
  end;
  if Style then
  begin
    R1.Top:=0; R1.Left:=0; R2.Top:=0; R2.Left:=0;
    R1.Right:=MsgBuffer.Width;  R1.bottom:=MsgBuffer.Height;
    R2.Right:=width; R2.Bottom:=round(R1.Bottom*(R2.Right/R1.Right));
    SetStretchBltMode(MsgBuffer.Canvas.Handle, HALFTONE);
    MsgBuffer.Canvas.CopyRect(R2,MsgBuffer.Canvas,R1);
    MsgBuffer.Height:=R2.Bottom;
    MsgBuffer.Width:=R2.Right;
  end;
end;

Procedure TRoll.SetMsgM(mm: boolean);
begin
  if mm<>MsgM then
  begin
    MsgM:=mm;
    Case MsgM of
    false: OnStatusChange(Self,JoyStat);
    true:  OnStatusChange(Self,4);
    end;
  end;
end;

Function TRoll.GetMsgM: boolean;
begin
  GetMsgM:=MsgM;
end;

Procedure TRoll.SetJStat(J: Integer);
begin
  if j<>JoyStat then
  begin
    JoyStat:=j;
    OnStatusChange(Self,j);
  end;
end;

Function TRoll.GetJStat: integer;
begin
  GetJStat:=JoyStat;
end;

Procedure TRoll.SetMesg(M: String);
begin
  if Mesg<>M then
  begin
    if MsgMode then
    begin
      Mesg:=M;
      RenderMsg;
      ReFresh;
    end;
  end;
end;

Function TRoll.GetMesg: String;
begin
  GetMesg:=Mesg;
end;

Procedure TRoll.SetMJoy;
begin
  if M in [0..2] then
  begin
    MJoy:=M;
    Case MJoy of
    0: begin OnStatusChange(@Self,0); JoyStat:=0; end;
    1: begin OnStatusChange(@Self,1); JoyStat:=1; end;
    2: begin OnStatusChange(@Self,3); JoyStat:=3; end;
    end;
  end;
end;

Procedure TRoll.StatChg;
begin
end;

Procedure TRoll.PosChg;
begin
end;

Destructor TRoll.Destroy;
var
  i: integer;
begin
  Timer.Free;
  for i:=0 to 31 do Buffer[i].Free;
  Font.Free;
  Canvas.Free;
  Buf.Free;
  MsgBuffer.Free;
  Inherited Destroy;
end;

Procedure TRoll.CalibrateJoy;
var
  a: TJoyInfo;
begin
  JoyGetPos(JoyNum,@a);
  JoyCntr:=a.wXpos;
end;

Procedure TRoll.TimerProc(Sender: TObject);
var
  a: TJoyInfo;
  j: longInt;
  i: Single;
  r: single;
begin
  if not MsgMode then
  begin
    if JoyGetPos(JoyNum,@a)=JOYERR_NOERROR then
    begin;
      i:=a.wXpos;
      Case MJoy of
      0: begin
           if ((a.wButtons and 1)<>0) then for j:=1 to 3 do Position:=Position+3;
           if ((a.wButtons and 2)<>0) then for j:=1 to 3 do Position:=Position-3;
         end;
      1: begin
           if ((a.wButtons and 1)<>0) then JoyStat:=1;
           if ((a.wButtons and 2)<>0) then JoyStat:=2;
           if ((a.wButtons and 3)<>0) then OnStatusChange(@Self,JoyStat);
           if JoyStat=2 then
           begin
             r:=(i/JoySens-(JoyCenter/JoySens))/3;
             i:=Position;
             for j:=1 to 3 do Position:=i+r*j;
           end;
         end;
      2: begin
           if ((a.wButtons and 1)<>0) then
           begin
             r:=(i/JoySens-(JoyCenter/JoySens))/3;
             i:=Position;
             for j:=1 to 3 do Position:=i+abs(r*j);
           end;
           if ((a.wButtons and 2)<>0) then
           begin
             r:=(i/JoySens-(JoyCenter/JoySens))/3;
             i:=Position;
             for j:=1 to 3 do Position:=i-abs(r*j);
           end;
         end;
      end;
    end;
  end;
end;

Procedure TRoll.SetJoySens;
begin
  if ((J>0) and (j<3000)) then JoySens:=j;
end;

Function TRoll.GetJoyControl: Boolean;
begin
  GetJoyControl:=JoyControl;
end;

Procedure TRoll.SetJoyControl(j: Boolean);
begin
  Timer.Enabled:=j;
  JoyControl:=j;
end;

Function TRoll.GetPos; begin GetPos:=ActualPos; end;

Procedure TRoll.SetPos(AP: Single);
begin
  if not (csDesigning in ComponentState) then
  begin
    if (AP<>ActualPos) and not MsgMode then
    begin
      if (AP>GetMaxPos) then AP:=GetMaxPos;
      if AP<0 then AP:=0;
      ActualPos:=AP;
      Paint;
      OnPositionChange(Self);
    end;
  end;
end;

Procedure TRoll.SetMx(M: Boolean);
begin
  Mx:=m; RenderMsg; Render; refresh;
end;

Procedure TRoll.SetMy(M: Boolean);
begin
  My:=m; RenderMsg; Render; refresh;
end;

Function GetPart(var Source: String; MaxWidth: Integer; Canvas: TCanvas): String;
var
  i,j: integer;
  s,ss: String;
begin
  s:='';
  ss:='';
  i:=0;
  j:=0;
  if Source<>'' then
  begin
    repeat
      inc(i);
      if (Source[i]=' ') or (source[i]='-') then
      begin
        if (Canvas.TextWidth(ss+s+Source[i])<MaxWidth) then
        begin
          if s<>'' then
          begin
            ss:=ss+s+source[i];
            inc(j,Length(s)+1);
            s:='';
          end else inc(j);
        end else break;
      end
      else s:=s+Source[i];
    until (Canvas.TextWidth(ss+s)>MaxWidth) or (i=Length(Source));
    if (Canvas.TextWidth(ss+s)<MaxWidth) then
    begin
      ss:=ss+s;
      inc(j,Length(s));
    end;
    if ss='' then
    begin
      ss:=copy(s,1,length(s)-1);
      j:=Length(ss);
    end;
    GetPart:=ss;
    Source:=Copy(Source,j+1,65536);
  end else GetPart:='';
end;

Function TRoll.GetMaxPos: Integer;
begin
  GetMaxPos:=FullHeight-height;
end;

Procedure TRoll.WndProc;
begin
  if Msg.Msg=WM_Paint then Refresh;
  Inherited WndProc(Msg);
end;

Procedure TRoll.ReFresh;
begin
  Paint;
end;

Procedure TRoll.Render;
var
  i,j,k: integer;
  sss: string;
  th: integer;
  ss: shortstring;
  apos: integer;
  P1,P2: PBufLine;
  R1,R2: TRect;
begin
  if trim(MMo.text)<>'' then
  begin
    maxbuf:=0;
    if not Style then WorkWidth:=width;
    if MMo<>nil then
    begin
      Buffer[maxbuf].Canvas.Brush.Color:=BC;
      Buffer[maxbuf].Canvas.Pen.Color:=  BC;
      apos:=0;
      for i:=0 to MMo.Lines.Count-1 do
      begin
        sss:=MMo.Lines[i];
        Buffer[maxbuf].Canvas.Font:=Font;
        Buffer[maxbuf].Canvas.Brush.Color:=BC;
        if sss<>'' then
        begin
          if sss[1]='*' then
          begin
            sss:=copy(sss,2,65536);
            Buffer[maxbuf].Canvas.Font:=Font2;
            Buffer[maxbuf].Canvas.Brush.Color:=BC2;
          end;
        end;
        th:=Buffer[maxbuf].Canvas.TextHeight('s');
        repeat
          ss:=GetPart(sss,WorkWidth-15,Buffer[maxbuf].Canvas);
          apos:=apos+th;
        until Trim(sss)='';
        Fullheight:=apos;
      end;
      for k:=0 to (apos div maxbufheight) do
      begin
        Buffer[k].Width:=WorkWidth;
        if k<>(apos div maxbufheight) then
          Buffer[k].Height:=maxbufheight+5
        else
          Buffer[k].Height:=apos-k*maxbufheight;
        for i:=0 to buffer[k].height-1 do
        begin
          P1:=Buffer[k].Scanline[i];
          for j:=0 to buffer[k].width-1 do p1[j]:=0;
        end;
      end;
      Buffer[maxbuf].Canvas.Brush.Color:=BC;
      Buffer[maxbuf].Canvas.Pen.Color:=  BC;
      apos:=0;
      for i:=0 to MMo.Lines.Count-1 do
      begin
        sss:=MMo.Lines[i];
        Buffer[maxbuf].Canvas.Font:=Font;
        Buffer[maxbuf].Canvas.Brush.Color:=BC;
        if sss<>'' then
        begin
          if sss[1]='*' then
          begin
            sss:=copy(sss,2,65536);
            Buffer[maxbuf].Canvas.Font:=Font2;
            Buffer[maxbuf].Canvas.Brush.Color:=BC2;
          end;
        end;
        th:=Buffer[maxbuf].Canvas.TextHeight('s');
        repeat
          ss:=GetPart(sss,WorkWidth-15,Buffer[maxbuf].Canvas);
          TextOut(Buffer[maxbuf].Canvas.Handle,5,apos-maxbuf*maxbufheight,pointer(longint(@ss)+1),Length(ss));
          apos:=apos+th;
          if apos-maxbuf*maxbufheight>=maxbufheight then
          begin
            inc(maxbuf);
            Buffer[maxbuf].canvas.font:=buffer[maxbuf-1].canvas.font;
            Buffer[maxbuf].canvas.brush:=buffer[maxbuf-1].canvas.brush;
            TextOut(Buffer[maxbuf].Canvas.Handle,5,apos-th-maxbuf*maxbufheight,pointer(longint(@ss)+1),Length(ss));
          end;
        until Trim(sss)='';
      end;
    end;
    if MirrorX then
    begin
      for k:=0 to maxbuf do
      begin
        for i:=0 to buffer[k].height-1 do
        begin
          P1:=Buffer[k].Scanline[i];
          for j:=0 to (width div 2)-1 do
          begin
            th:=P1[j];
            P1[j]:=P1[width-j-1];
            P1[width-j-1]:=th;
          end;
        end;
      end;
    end;
    if MirrorY then
    begin
      for i:=1 to (FullHeight div 2) do
      begin
        P1:=Buffer[(i-1) div maxbufheight].Scanline[(i-1) mod maxbufheight];
        P2:=Buffer[(FullHeight-i-1) div maxbufheight].Scanline[(FullHeight-i-1) mod maxbufheight];
        for j:=0 to width-1 do
        begin
          th:=P1[j];
          P1[j]:=P2[j];
          P2[j]:=th;
        end;
      end;
    end;
    if Style then
    begin
      for i:=0 to maxbuf do
      begin
        R1.Top:=0; R1.Left:=0; R2.Top:=0; R2.Left:=0;
        R1.Right:=Buffer[i].Width;  R1.bottom:=Buffer[i].Height;
        R2.Right:=width; R2.Bottom:=round(R1.Bottom*(R2.Right/R1.Right));
        SetStretchBltMode(buffer[i].Canvas.Handle, HALFTONE);
        Buffer[i].Canvas.CopyRect(R2,Buffer[i].Canvas,R1);
        Buffer[i].Height:=R2.Bottom;
        Buffer[I].Width:=R2.Right;
      end;
    end;
  end;
end;

Procedure TRoll.Paint;
var
  R,R2: TRect;
  rwiny: integer;
  i,j: integer;
begin
  if HasParent then
  begin
    if csDesigning in ComponentState then
    begin
      Canvas.Rectangle(0,0,width,height);
    end
    else
    begin
      Case Style of
      false: begin
               Case MsgMode of
               false: begin
                        r.top:=0; r.left:=0;
                        r.right:=width; r.bottom:=height;
                        r2.left:=0; r2.right:=width;
                        j:=0;
                        Case MirrorY of
                        false: j:=round(position);
                        true:  j:=round(FullHeight-height-position);
                        end;
                        for i:=0 to maxbuf do
                        begin
                          r2.top:=-1*i*maxbufheight+j;
                          r2.bottom:=r2.top+height;
                          Canvas.CopyRect(r,Buffer[i].Canvas,r2);
                        end;
                      end;
               true:  begin
                        Canvas.Draw(0,0,MsgBuffer);
                      end;
               end;
            end;
      true: begin
              Buf.width:=width; buf.height:=height;
              rwiny:=round(workwidth*0.75*((width)/workwidth));
              Case MsgMode of
              false: begin
                       for i:=0 to maxbuf do
                       begin
                         Buf.Canvas.Draw(0,-1*round(position*((width)/workwidth))+((height+i*maxbufheight) div 2)-(rwiny div 2),Buffer[i]);
                       end;
                       if -1*round(position*((width)/workwidth))+(height div 2)-(rwiny div 2)>0 then
                       begin
                         Buf.Canvas.Brush.Style:=bsSolid;
                         Buf.Canvas.Brush.Color:=$000000;
                         Buf.Canvas.Pen.Color:=$000000;
                         Buf.Canvas.Pen.Width:=1;
                         Buf.Canvas.Rectangle(0,0,width,-1*round(position*((width)/workwidth))+(height div 2)-(rwiny div 2));
                       end;
                       if -1*round(position*((width)/workwidth))+(height div 2)-(rwiny div 2)+round(FullHeight*(width)/workwidth)<height then
                       begin
                         Buf.Canvas.Brush.Style:=bsSolid;
                         Buf.Canvas.Brush.Color:=$000000;
                         Buf.Canvas.Pen.Color:=$000000;
                         Buf.Canvas.Pen.Width:=1;
                         Buf.Canvas.Rectangle(0,-1*round(position*((width)/workwidth))+(height div 2)-(rwiny div 2)+round(FullHeight*(width)/workwidth),width,height);
                       end;
                     end;
              true:  begin
                       Buf.Canvas.Draw(0,(height div 2)-(rwiny div 2),MsgBuffer);
                     end;
              end;
              Buf.Canvas.Brush.Style:=bsClear;
              Buf.Canvas.Pen.Color:=$0000ff;
              Buf.Canvas.Pen.Style:=psSolid;
              Buf.Canvas.Pen.Width:=3;
              Buf.Canvas.Rectangle(0,(height div 2)-(rwiny div 2),width,(height div 2)+(rwiny div 2));
              Canvas.Draw(0,0,Buf);
            end;
      end;
    end;
  end;
end;

end.
