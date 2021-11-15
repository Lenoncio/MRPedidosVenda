unit uControler.Cadastro.Inicial.Produtos;

interface

uses
  uControler.Produtos;

type

  TCadastroInicialProdutos = class
  private
    FProdutos : TProdutos;
    procedure Cadastrar;
    procedure CadastrarCadeira;
    procedure CadastrarFonte;
    procedure CadastrarGabinete;
    procedure CadastrarMemoria;
    procedure CadastrarMonitor;
    procedure CadastrarMonitorJaguara;
    procedure CadastrarMouse;
    procedure CadastrarPlacaDeVideo;
    procedure CadastrarPlacaMae;
    procedure CadastrarProcessador;
    procedure CadastrarTeclado;
    procedure CadastroProdutoJaguara;
    procedure CadastroProdutoNormal;
    procedure CadastrarCadeiraJaguara;
    procedure CadastrarFonteJaguara;
    procedure CadastrarGabineteJaguara;
    procedure CadastrarMemoriaJaguara;
    procedure CadastrarMouseJaguara;
    procedure CadastrarPlacaDeVideoJaguara;
    procedure CadastrarPlacaMaeJaguara;
    procedure CadastrarProcessadorJaguara;
    procedure CadastrarTecladoJaguara;
  public
    constructor Create;
    destructor Destroy; override;

    procedure VerificarRegistros;
  end;

implementation

uses
  FireDAC.Comp.Client, uModel.Rotinas;

{ TCadastroInicialProdutos }

procedure TCadastroInicialProdutos.Cadastrar;
begin
  CadastroProdutoNormal;
  CadastroProdutoJaguara;
end;

procedure TCadastroInicialProdutos.CadastroProdutoNormal;
begin
  CadastrarCadeira;
  CadastrarFonte;
  CadastrarGabinete;
  CadastrarMemoria;
  CadastrarMonitor;
  CadastrarMouse;
  CadastrarPlacaDeVideo;
  CadastrarPlacaMae;
  CadastrarProcessador;
  CadastrarTeclado;
end;

procedure TCadastroInicialProdutos.CadastroProdutoJaguara;
begin
  CadastrarCadeiraJaguara;
  CadastrarFonteJaguara;
  CadastrarGabineteJaguara;
  CadastrarMemoriaJaguara;
  CadastrarMouseJaguara;
  CadastrarPlacaDeVideoJaguara;
  CadastrarPlacaMaeJaguara;
  CadastrarProcessadorJaguara;
  CadastrarMonitorJaguara;
  CadastrarTecladoJaguara;
end;

procedure TCadastroInicialProdutos.CadastrarMonitor;
begin
  FProdutos := TProdutos.Create;
  FProdutos.Nome := 'Monitor';
  FProdutos.ValorVenda := 500;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarTeclado;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Teclado';
  FProdutos.ValorVenda := 50;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarMouse;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Mouse';
  FProdutos.ValorVenda := 75;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarGabinete;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Gabinete';
  FProdutos.ValorVenda := 90.50;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarFonte;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Fonte';
  FProdutos.ValorVenda := 49.99;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarPlacaMae;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Placa Mãe';
  FProdutos.ValorVenda := 800.45;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarPlacaDeVideo;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Placa de video';
  FProdutos.ValorVenda := 1500;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarMemoria;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Memória';
  FProdutos.ValorVenda := 100.35;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarProcessador;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Processador';
  FProdutos.ValorVenda := 1750.65;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarCadeira;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Cadeira';
  FProdutos.ValorVenda := 650.55;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarMonitorJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Monitor Jaguara';
  FProdutos.ValorVenda := 550;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarTecladoJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Teclado Jaguara';
  FProdutos.ValorVenda := 25;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarMouseJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Mouse Jaguara';
  FProdutos.ValorVenda := 75;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarGabineteJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Gabinete Jaguara';
  FProdutos.ValorVenda := 90.50;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarFonteJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Fonte Jaguara';
  FProdutos.ValorVenda := 9.53;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarPlacaMaeJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Placa Mãe Jaguara';
  FProdutos.ValorVenda := 200.99;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarPlacaDeVideoJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Placa de video Jaguara';
  FProdutos.ValorVenda := 500;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarMemoriaJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Memória Jaguara';
  FProdutos.ValorVenda := 10;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarProcessadorJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Processador Jaguara';
  FProdutos.ValorVenda := 500.52;
  FProdutos.Salvar;
end;

procedure TCadastroInicialProdutos.CadastrarCadeiraJaguara;
begin
  FProdutos.Clear;
  FProdutos.Nome := 'Cadeira Jaguara';
  FProdutos.ValorVenda := 250.12;
  FProdutos.Salvar;
end;

constructor TCadastroInicialProdutos.Create;
begin
  FProdutos := TProdutos.Create;
end;

destructor TCadastroInicialProdutos.Destroy;
begin
  FProdutos.Free;
  inherited;
end;

procedure TCadastroInicialProdutos.VerificarRegistros;
const
  cCOMANDO = 'select * from Produtos';
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
