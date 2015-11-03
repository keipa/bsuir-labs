program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UFormule in 'UFormule.pas',
  MathFunction in 'MathFunction.pas',
  MathGraph in 'MathGraph.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
