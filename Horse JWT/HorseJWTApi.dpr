program HorseJWTApi;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  JOSE.Core.JWT,
  JOSE.Core.Builder,
  System.SysUtils;

begin
THorse.Get('/login',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LToken: TJWT;
      LCompactToken: string;
    begin
    LToken := TJWT.Create;
    try
      // Token claims
      LToken.Claims.Issuer := 'MiranteTech';
      LToken.Claims.Subject := 'Lindson#0220';
      LToken.Claims.Expiration := Now + 1;

      // Def Other Claims:
      LToken.Claims.SetClaimOfType<string>('nome', 'Lindson');
      LToken.Claims.SetClaimOfType<boolean>('mvp', False);

      // Signing and Compact format creation
      LCompactToken := TJOSE.SHA256CompactToken('rage', LToken);
      Res.Send(LCompactToken).Status(200);
    finally
      LToken.Free;
    end;
    end);

THorse.Listen(9000);

end.
