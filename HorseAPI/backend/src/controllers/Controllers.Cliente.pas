unit Controllers.Cliente;

interface

procedure Registry;

implementation

uses Horse, Services.Cliente, Dataset.Serialize, System.JSON, System.SysUtils, Vcl.Dialogs;

procedure DoList(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LService: TServiceCLiente;
  begin
  LService := TServiceCLiente.Create(nil);
  try
    Res.Send(LService.ListAll.ToJSONArray);
  finally
    LService.Free;
  end;
  end;

procedure DoPost(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LService: TServiceCLiente;
    LData: TJsonObject;
  begin
  LService := TServiceCLiente.Create(nil);
  try
    LData := Req.Body<TJsonObject>;
    if LService.Append(LData) then
      Res.Send(LService.qryCadastro.ToJSONObject).Status(201);
  finally
    LService.Free;
  end;
  end;

procedure DoUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    AID: Integer;
    LService: TServiceCLiente;
    LData: TJsonObject;
  begin
  LService := TServiceCLiente.Create(nil);
  try
    LData := Req.Body<TJsonObject>;
    AID := Req.Params.Items['id'].ToInteger;
    if LService.Update(LData, AID) then
      Res.Send(LService.qryCadastro.ToJSONObject).Status(200);
  finally
    LService.Free;
  end;
  end;

procedure DoDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    AID: Integer;
    LService: TServiceCLiente;
  begin
  LService := TServiceCLiente.Create(nil);
  try
    AID := Req.Params.Items['id'].ToInteger;
    LService.Delete(AID);
    Res.Send(LService.qryCadastro.ToJSONObject).Status(204);
  finally
    LService.Free;
  end;

  end;

procedure Registry;
  begin
  THorse.Get('/clientes', DoList);
  THorse.Post('/clientes', DoPost);
  THorse.Put('/clientes/:id', DoUpdate);
  THorse.Delete('/clientes/:id', DoDelete);
  end;

end.
