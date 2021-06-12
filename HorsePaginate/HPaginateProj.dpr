program HPaginateProj;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Paginate,
  Horse.Jhonson,
  System.JSON,
  DBClient,
  DataSet.Serialize,
  Services.Bairro in 'src\services\Services.Bairro.pas' {ServiceBairro: TDataModule};

begin
THorse.Use(Paginate).Use(Jhonson);

THorse.Get('/bairros',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LService: TServiceBairro;
    begin
      LService := TServiceBairro.Create(nil);
      try
        Res.Send<TJSONArray>(LService.Listar.ToJSONArray());
      finally
        LService.Free;
      end;
    end);

THorse.Listen(9000);

end.
