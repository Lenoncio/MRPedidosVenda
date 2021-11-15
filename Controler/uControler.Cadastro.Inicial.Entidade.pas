unit uControler.Cadastro.Inicial.Entidade;

interface

uses
  uControler.Entidade;

type
  TCadastroInicialEntidades = class
  private
    FEntidade : TEntidade;
    procedure Cadastrar;
    procedure CadastrarClientesParana;
    procedure CadastrarClientesRioGrandeDoSul;
    procedure CadastrarClientesSantaCatarina;
    procedure CadastrarClientesSaoPaulo;
    procedure CadastrarClientesRioGrandeDoSul1;
    procedure CadastrarClientesRioGrandeDoSul2;
    procedure CadastrarClientesRioGrandeDoSul3;
    procedure CadastrarClientesParana1;
    procedure CadastrarClientesParana2;
    procedure CadastrarClientesParana3;
    procedure CadastrarClientesParana4;
    procedure CadastrarClientesParana5;
    procedure CadastrarClientesParana6;
    procedure CadastrarClientesSantaCatarina1;
    procedure CadastrarClientesSantaCatarina2;
    procedure CadastrarClientesSantaCatarina3;
    procedure CadastrarClientesSantaCatarina4;
    procedure CadastrarClientesSantaCatarina5;
    procedure CadastrarClientesSantaCatarina6;
    procedure CadastrarClientesSantaCatarina7;
    procedure CadastrarClientesSaoPaulo1;
    procedure CadastrarClientesSaoPaulo2;
    procedure CadastrarClientesSaoPaulo3;
    procedure CadastrarClientesSaoPaulo4;
  public
    constructor Create;
    destructor Destroy; override;

    procedure VerificarRegistros;
  end;

implementation

uses
  FireDAC.Comp.Client,
  uModel.Rotinas, uControler.Cidade, uControler.UF;

{ TCadastroInicialCidades }

procedure TCadastroInicialEntidades.Cadastrar;
begin
  CadastrarClientesParana;
  CadastrarClientesSaoPaulo;
  CadastrarClientesSantaCatarina;
  CadastrarClientesRioGrandeDoSul;
end;

procedure TCadastroInicialEntidades.CadastrarClientesParana;
begin
  CadastrarClientesParana1;
  CadastrarClientesParana2;
  CadastrarClientesParana3;
  CadastrarClientesParana4;
  CadastrarClientesParana5;
  CadastrarClientesParana6;
end;

procedure TCadastroInicialEntidades.CadastrarClientesParana1;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Pato Branco');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Paran�');
  FEntidade.Nome := 'Leonardo Paran�';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesParana2;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Pato Branco');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Paran�');
  FEntidade.Nome := 'Ricardo Paran�';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesParana3;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Curitiba');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Paran�');
  FEntidade.Nome := 'Jo�o Paran�';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesParana4;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Curitiba');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Paran�');
  FEntidade.Nome := 'Jos� Paran�';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesParana5;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Curitiba');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Paran�');
  FEntidade.Nome := 'Marcos Paran�';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesParana6;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Curitiba');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Paran�');
  FEntidade.Nome := 'Marcelo Paran�';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSaoPaulo;
begin
  CadastrarClientesSaoPaulo1;
  CadastrarClientesSaoPaulo2;
  CadastrarClientesSaoPaulo3;
  CadastrarClientesSaoPaulo4;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSaoPaulo1;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('S�o Paulo');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('S�o Paulo');
  FEntidade.Nome := 'Leonardo S�o Paulo';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSaoPaulo2;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Itupeva');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('S�o Paulo');
  FEntidade.Nome := 'Ricardo S�o Paulo';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSaoPaulo3;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('S�o Paulo');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('S�o Paulo');
  FEntidade.Nome := 'Jo�o S�o Paulo';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSaoPaulo4;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('S�o Paulo');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('S�o Paulo');
  FEntidade.Nome := 'Jos� S�o Paulo';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina;
begin
  CadastrarClientesSantaCatarina1;
  CadastrarClientesSantaCatarina2;
  CadastrarClientesSantaCatarina3;
  CadastrarClientesSantaCatarina4;
  CadastrarClientesSantaCatarina5;
  CadastrarClientesSantaCatarina6;
  CadastrarClientesSantaCatarina7;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina1;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Xanxer�');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FEntidade.Nome := 'Leonardo Santa Catarina';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina2;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Xanxer�');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FEntidade.Nome := 'Ricardo Santa Catarina';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina3;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Florian�polis');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FEntidade.Nome := 'Jo�o Santa Catarina';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina4;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Xanxer�');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FEntidade.Nome := 'Jos� Santa Catarina';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina5;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Xanxer�');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FEntidade.Nome := 'Marcos Santa Catarina';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina6;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Florian�polis');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FEntidade.Nome := 'Marcelo Santa Catarina';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesSantaCatarina7;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Florian�polis');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FEntidade.Nome := 'Andr� Santa Catarina';
  FEntidade.Salvar;

end;

procedure TCadastroInicialEntidades.CadastrarClientesRioGrandeDoSul;
begin
  CadastrarClientesRioGrandeDoSul1;
  CadastrarClientesRioGrandeDoSul2;
  CadastrarClientesRioGrandeDoSul3;
end;

procedure TCadastroInicialEntidades.CadastrarClientesRioGrandeDoSul1;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Uruguaiana');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Rio Grande do Sul');
  FEntidade.Nome := 'Leonardo Rio Grande do Sul';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesRioGrandeDoSul2;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Uruguaiana');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Rio Grande do Sul');
  FEntidade.Nome := 'Ricardo Rio Grande do Sul';
  FEntidade.Salvar;
end;

procedure TCadastroInicialEntidades.CadastrarClientesRioGrandeDoSul3;
begin
  FEntidade.Clear;
  FEntidade.Cidade.Codigo := TCidade.ConsultarIDCidade('Porto Alegre');
  FEntidade.Cidade.Carregar;
  FEntidade.UF.Codigo := TUF.ConsultarIDUF('Rio Grande do Sul');
  FEntidade.Nome := 'Jo�o Rio Grande do Sul';
  FEntidade.Salvar;
end;

constructor TCadastroInicialEntidades.Create;
begin
  FEntidade := TEntidade.Create;
end;

destructor TCadastroInicialEntidades.Destroy;
begin
  FEntidade.Free;
  inherited;
end;

procedure TCadastroInicialEntidades.VerificarRegistros;
const
  cCOMANDO = 'select * from Clientes';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Open;
    if qry.RecordCount > 0 then
      Exit;
    Cadastrar
  finally
    qry.Free;
  end;
end;

end.
