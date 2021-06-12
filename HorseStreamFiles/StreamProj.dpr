program StreamProj;

{$APPTYPE CONSOLE}
{$R *.res}

uses Horse, Horse.OctetStream, System.Classes, System.SysUtils, Horse.Logger, Horse.Logger.Provider.LogFile,
  Horse.Logger.Provider.Console;

var
  App: Thorse;
  LoggerConfig: THorseLoggerLogFileConfig;
  LConsoleConfig: THorseLoggerConsoleConfig;

begin
Thorse.Use(OctetStream);

THorseLoggerManager.RegisterProvider(THorseLoggerProviderLogFile.New());
Thorse.Use(THorseLoggerManager.HorseCallback());

Thorse.Get('/arquivos',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LStream: TFileStream;
    begin
    LStream := TFileStream.Create('C:\Users\Lindson França\Desktop\HorseStreamFiles\assets\birdseclipse.jpg',
      fmOpenRead);
    Res.Send<TStream>(LStream);
    end);

Thorse.Post('/arquivos',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LStream: TMemoryStream;
    begin
    LStream := Req.Body<TMemoryStream>;
    LStream.SaveToFile('C:\Users\Lindson França\Desktop\HorseStreamFiles\assets\copia.jpg');
    Res.Send('All done!').Status(201);
    end);

Thorse.Listen(9000);

end.
