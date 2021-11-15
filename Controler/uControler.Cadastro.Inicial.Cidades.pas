unit uControler.Cadastro.Inicial.Cidades;

interface

uses
  uControler.Cidade;

type
  TCadastroInicialCidades = class
  private
    FCidade : TCidade;
    procedure Cadastrar;
    procedure CadastrarCuritiba;
    procedure CadastrarFlorianopolis;
    procedure CadastrarItupeva;
    procedure CadastrarPatoBranco;
    procedure CadastrarPortoAlegre;
    procedure CadastrarSaoPaulo;
    procedure CadastrarUruguaiana;
    procedure CadastrarXanxere;
  public
    constructor Create;
    destructor Destroy; override;

    procedure VerificarRegistros;
  end;


implementation

uses
  FireDAC.Comp.Client, uModel.Rotinas, uControler.UF;

{ TCadastroInicialCidades }

procedure TCadastroInicialCidades.Cadastrar;
begin
  CadastrarCuritiba;
  CadastrarFlorianopolis;
  CadastrarItupeva;
  CadastrarPatoBranco;
  CadastrarPortoAlegre;
  CadastrarSaoPaulo;
  CadastrarUruguaiana;
  CadastrarXanxere;
end;

procedure TCadastroInicialCidades.CadastrarPatoBranco;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Paraná');
  FCidade.UF.Carregar;
  FCidade.Nome := 'Pato Branco';
  FCidade.Salvar;
end;

procedure TCadastroInicialCidades.CadastrarXanxere;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FCidade.UF.Carregar;
  FCidade.Nome := 'Xanxerê';
  FCidade.Salvar;
end;

procedure TCadastroInicialCidades.CadastrarItupeva;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Rio Grande do Sul');
  FCidade.UF.Carregar;
  FCidade.Nome := 'Itupeva';
  FCidade.Salvar;
end;

procedure TCadastroInicialCidades.CadastrarUruguaiana;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Rio Grande do Sul');
  FCidade.UF.Carregar;
  FCidade.Nome := 'Uruguaiana';
  FCidade.Salvar;
end;

procedure TCadastroInicialCidades.CadastrarCuritiba;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Paraná');
  FCidade.UF.Carregar;
  FCidade.Nome := 'Curitiba';
  FCidade.Salvar;
end;

procedure TCadastroInicialCidades.CadastrarFlorianopolis;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Santa Catarina');
  FCidade.UF.Carregar;
  FCidade.Nome := 'Florianópolis';
  FCidade.Salvar;
end;

procedure TCadastroInicialCidades.CadastrarSaoPaulo;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Sao Paulo');
  FCidade.UF.Carregar;
  FCidade.Nome := 'São Paulo';
  FCidade.Salvar;
end;

procedure TCadastroInicialCidades.CadastrarPortoAlegre;
begin
  FCidade.Clear;
  FCidade.UF.Codigo := TUF.ConsultarIDUF('Rio Grande do Sul');
  FCidade.UF.Carregar;
  FCidade.Nome := 'Porto Alegre';
  FCidade.Salvar;
end;

constructor TCadastroInicialCidades.Create;
begin
  FCidade := TCidade.Create;
end;

destructor TCadastroInicialCidades.Destroy;
begin
  FCidade.Free;
  inherited;
end;

procedure TCadastroInicialCidades.VerificarRegistros;
const
  cCOMANDO = 'select * from Cidades';
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
