program HorseProj;

{$APPTYPE CONSOLE}
{$R *.res}

uses Horse, System.JSON, Horse.Commons, Horse.Jhonson, System.SysUtils, Horse.BasicAuthentication, Horse.Compression, Horse.HandleException;

var
  App: THorse;
  Users: TJSONArray;

begin
App := THorse.Create;

App.Use(Compression());
App.Use(Jhonson);
App.Use(HandleException);

App.Use(HorseBasicAuthentication(
      function(const AUsername, APassword: string): Boolean
    begin
    Result := AUsername.Equals('user') and APassword.Equals('password');
    end));

App.Get('/erro',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LConteudo: TJSONObject;
    begin

      raise EHorseException.Create('Erro na falha');
      LConteudo := TJSONObject.Create;
      LConteudo.AddPair('nome', 'Lindson');
      Res.Send(LConteudo);

    end);

App.Get('/ping',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      I: Integer;
      LPong: TJSONArray;
    begin
    LPong := TJSONArray.Create;
    for I := 0 to 1000 do
      LPong.Add(TJSONObject.Create(TJSONPair.Create('ping', 'pong')));
    Res.Send(LPong);
    end);

Users := TJSONArray.Create;
THorse.Get('/users',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
    Res.Send<TJSONArray>(Users);
    end);

THorse.Post('/users',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      User: TJSONObject;
    begin
    User := Req.Body<TJSONObject>.Clone as TJSONObject;
    Users.AddElement(User);
    Res.Send<TJSONAncestor>(User.Clone).Status(THTTPStatus.Created);
    end);

THorse.Delete('/users/:id',
  procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      Id: Integer;
    begin
    Id := Req.Params.Items['id'].ToInteger;
    Users.Remove(Pred(Id)).Free;
    Res.Send<TJSONAncestor>(Users).Status(THTTPStatus.NoContent);
    end);

App.Listen(9000);

end.
