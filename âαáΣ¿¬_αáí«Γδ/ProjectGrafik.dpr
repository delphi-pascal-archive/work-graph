program ProjectGrafik;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  Unit_About in 'Unit_About.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'График работы';
  Application.CreateForm(TFormMain, FormMain);
  Calc_Schedule := TCalc_Schedule.Create;
  Application.Run;
end.
