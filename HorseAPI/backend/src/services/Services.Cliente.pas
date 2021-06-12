unit Services.Cliente;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, System.JSON, DataSet.Serialize, Vcl.Dialogs;

type
  TServiceCliente = class(TDataModule)
    Connection: TFDConnection;
    qryCadastro: TFDQuery;
    qryPesquisa: TFDQuery;
    qryCadastroid: TFDAutoIncField;
    qryCadastronome: TStringField;
    qryCadastrosobrenome: TStringField;
    qryCadastroemail: TStringField;
    qryPesquisaid: TFDAutoIncField;
    qryPesquisanome: TStringField;
    qryPesquisasobrenome: TStringField;
    qryPesquisaemail: TStringField;
    private
      { Private declarations }
    public
      function ListAll: TFDQuery;
      function Append(const AJson: TJSONObject): Boolean;
      procedure Delete(AId: integer);
      function Update(const AJson: TJSONObject; AId: integer): Boolean;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}
{ TServiceCliente }

function TServiceCliente.Append(const AJson: TJSONObject): Boolean;
  begin
  qryCadastro.SQL.Add('where 1<>1');
  qryCadastro.Open();
  qryCadastro.LoadFromJSON(AJson, False);
  Result := qryCadastro.ApplyUpdates(0) = 0;
  end;

procedure TServiceCliente.Delete(AId: integer);
  begin
  qryCadastro.SQL.Clear;
  qryCadastro.SQL.Add('DELETE FROM CLIENTES WHERE ID = :ID');
  qryCadastro.ParamByName('ID').Value := AId;
  qryCadastro.ExecSQL;
  end;

function TServiceCliente.ListAll: TFDQuery;
  begin
  qryPesquisa.Open();
  Result := qryPesquisa;
  end;

function TServiceCliente.Update(const AJson: TJSONObject; AId: integer): Boolean;
  begin
  qryCadastro.Close;
  qryCadastro.SQL.Add('where id = :id');
  qryCadastro.ParamByName('ID').Value := AId;
  qryCadastro.Open();
  qryCadastro.MergeFromJSONObject(AJson, False);
  Result := qryCadastro.ApplyUpdates(0) = 0;
  end;

end.
