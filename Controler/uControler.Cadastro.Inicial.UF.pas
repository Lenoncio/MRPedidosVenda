unit uControler.Cadastro.Inicial.UF;

interface

uses
  uControler.UF;

type
  TCadastroInicialUF = class
  private
    FUF : TUF;
    procedure Cadastrar;
    procedure CadastrarParana;
    procedure CadastrarRioGrandeDoSul;
    procedure CadastrarSantaCatarina;
    procedure CadastrarSaoPaulo;
  public
    constructor Create;
    destructor Destroy; override;

    procedure VerificarRegistros;
  end;

implementation

uses
  uModel.Rotinas,
  FireDAC.Comp.Client;

{ TCadastroInicialUF }

procedure TCadastroInicialUF.Cadastrar;
begin
  CadastrarParana;
  CadastrarSantaCatarina;
  CadastrarRioGrandeDoSul;
  CadastrarSaoPaulo;
end;

procedure TCadastroInicialUF.CadastrarParana;
begin
  FUF.Clear;
  FUF.Nome := 'Paraná';
  FUF.Sigla := 'PR';
  FUF.Salvar;
end;

procedure TCadastroInicialUF.CadastrarSantaCatarina;
begin
  FUF.Clear;
  FUF.Nome := 'Santa Catarina';
  FUF.Sigla := 'SC';
  FUF.Salvar;
end;

procedure TCadastroInicialUF.CadastrarRioGrandeDoSul;
begin
  FUF.Clear;
  FUF.Nome := 'Rio Grande do Sul';
  FUF.Sigla := 'RS';
  FUF.Salvar;
end;

procedure TCadastroInicialUF.CadastrarSaoPaulo;
begin
  FUF.Clear;
  FUF.Nome := 'São Paulo';
  FUF.Sigla := 'SP';
  FUF.Salvar;
end;

constructor TCadastroInicialUF.Create;
begin
  FUF := TUF.Create;
end;

destructor TCadastroInicialUF.Destroy;
begin
  FUF.Free;
  inherited;
end;

procedure TCadastroInicialUF.VerificarRegistros;
const
  cCOMANDO = 'select * from UF';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Open;
    if qry.RecordCount > 0 then
      Exit;
    Cadastrar;
  finally
    qry.Free;
  end;
end;

end.
