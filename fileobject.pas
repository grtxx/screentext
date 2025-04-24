unit FileObject;

interface

uses Windows, SysUtils;

Type
  TFileError=procedure(errorcode: integer) of object;

  PFileObject=^TFileObject;
  TFileObject=object
  private
    f: file;
    Stte: Byte;
    blcks: Integer;
    Nme: String;
    ErrStr: String;
  public
    LastError: Integer;
    Language: Byte;
    { 0: angol  }
    { 1: magyar }
    constructor Create(aname: String; ablocksize: Integer);
    Destructor Destroy;
    procedure Error(errorcode: integer); virtual;
    procedure OpenForRead;  virtual;
    procedure OpenForWrite; virtual;
    procedure BlockRead (var Buf; count: Integer); virtual;
    procedure BlockWrite(var Buf; count: Integer); virtual;

    procedure WriteBool(b: boolean); virtual;
    function  ReadBool: Boolean; virtual;
    procedure WriteInteger(i: Integer); virtual;
    function  ReadInteger: Integer; virtual;
    procedure WriteReal(r: Real); virtual;
    function  ReadReal: Real; virtual;
    procedure WriteString(s: String); virtual;
    function  ReadString: String; virtual;

    procedure Close; virtual;
    procedure Erase; virtual;
    function EOF: Boolean;
    function FileSize: LongInt;
    function FilePos : LongInt;
    property state: byte          read stte;
    property BlockSize: integer   read Blcks;
    property Name: String         read Nme;
    property ErrorString: String  read ErrStr;
  end;

Const
  fstClosed = 1;
  fstOpened = 2;
  fstError  = 255;

  lgEnglish   = 0;
  lgHungarian = 1;

  Errors: Array[1..3,0..1] of String[30]=
  (('OK',                  'OK'                ),
   ('File access error',   'Fájl elérési hiba' ),
   ('Invalid String entry','Érvénytelen string'));

implementation

Constructor TFileObject.Create;
begin
  nme:=aname;
  Blcks:=aBlockSize;
  Assign(f,name);
  stte:=fstClosed;
  Language:=lgHungarian;
end;

Destructor TFileObject.Destroy;
begin
  Close;
end;

procedure TFileObject.Error;
begin
  stte:=fstError;
  Case LastError of
  0:      ErrStr:=Errors[1,Language];
  1..255: ErrStr:=Errors[2,Language];
  256:    ErrStr:=Errors[3,Language];
  end;
end;

procedure TFileObject.OpenForRead;
begin
  if state=fstClosed then
  begin
    {$I-}
    Reset(f,BlockSize);
    {$I+}
    LastError:=IOResult;
    if LastError<>0 then Error(LastError);
    stte:=fstOpened;
  end;
end;

procedure TFileObject.OpenForWrite;
begin
  if state=fstClosed then
  begin
    {$I-}
    ReWrite(f,BlockSize);
    {$I+}
    LastError:=IOResult;
    if LastError<>0 then Error(LastError);
    stte:=fstOpened;
  end;
end;

procedure TFileObject.WriteBool(b: boolean);
begin
  BlockWrite(b,SizeOf(Boolean));
end;
function TFileObject.ReadBool;
var
  b: boolean;
begin
  BlockRead(b,SizeOf(Boolean));
  ReadBool:=b;
end;

procedure TFileObject.WriteInteger(i: Integer);
begin
  BlockWrite(i,SizeOf(Integer));
end;

function  TFileObject.ReadInteger: Integer; 
var i: integer;
begin
  BlockRead(i,SizeOf(Integer));
  ReadInteger:=i;
end;

procedure TFileObject.WriteReal(r: Real);
begin
  BlockWrite(r,SizeOf(Real));
end;

function  TFileObject.ReadReal: Real;
var r: Real;
begin
  BlockRead(r,SizeOf(Real));
  ReadReal:=r;
end;

procedure TFileObject.WriteString(s: String);
var
  i: integer;
  a: Array[1..32768] of char;
begin
  WriteInteger(Length(s));
  for i:=1 to Length(s) do a[i]:=s[i];
  BlockWrite(a,Length(s));
end;

function  TFileObject.ReadString: String;
var
  i: Integer;
  a: Array[1..32768] of char;
  s: String;
begin
  i:=ReadInteger;
  BlockRead(a,i); s:='';
  if i<32768 then
  begin
    for i:=1 to i do s:=s+a[i];
    ReadString:=s;
  end
  else
  begin
    ReadString:='';
    Error(256);
  end;
end;

procedure TFileObject.BlockRead;
begin
  if state=fstOpened then
  begin
    {$I-}
    System.BlockRead(f,Buf,count);
    {$I+}
    LastError:=IOResult;
    if LastError<>0 then Error(LastError);
  end;
end;

procedure TFileObject.BlockWrite;
begin
  if state=fstOpened then
  begin
    {$I-}
    System.BlockWrite(f,Buf,count);
    {$I+}
    LastError:=IOResult;
    if LastError<>0 then Error(LastError);
  end;
end;

function TFileObject.EOF;
begin
  EOF:=true;
  if state=fstOpened then EOF:=System.EOF(f);
end;

function TFileObject.FileSize; begin FileSize:=System.FileSize(f); end;
function TFileObject.FilePos ; begin FilePos :=System.FilePos (f); end;

procedure TFileObject.Close;
begin
  if state=fstOpened then
  begin
    {$I-}
    System.Close(f);
    {$I+}
    LastError:=IOResult;
    if LastError<>0 then Error(LastError);
    Stte:=fstClosed;
  end;
end;

procedure TFileObject.Erase;
begin
  if state=fstClosed then
  begin
    {$I-}
    System.Erase(f);
    {$I+}
    LastError:=IOResult;
    if LastError<>0 then Error(LastError);
  end;
end;

end.
