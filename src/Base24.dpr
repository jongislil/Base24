program Base24;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Base24Encoding in 'Base24Encoding.pas',
  Base24Tests in 'Base24Tests.pas';

begin
  try
   Test;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

 Readln;
end.
