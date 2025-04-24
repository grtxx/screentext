program sugo;

uses
  Forms,
  feltolto in 'feltolto.pas' {OptionsWin},
  dumagep in 'dumagep.pas',
  futtato in 'futtato.pas' {RunWin},
  FileObject in '..\diagram\fileobject.pas',
  brdiag in '..\diagram\brdiag.pas',
  timecontrol in '..\diagram\timecontrol.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TOptionsWin, OptionsWin);
  Application.Run;
end.
