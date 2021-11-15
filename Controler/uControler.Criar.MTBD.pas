unit uControler.Criar.MTBD;

interface

uses
  FireDAC.Comp.Client;

type
  TCriarMTBD = class
  private
    FConexao: TFDConnection;
    FSenha: String;
    FUsuario: String;
    FServidor: String;
    procedure CriarMTBD;
    procedure CriarTabelaUF;
    procedure CriarTabelaCidade;
    procedure CriarTabelaClientes;
    procedure CriarTabelaProdutos;
    procedure CriarTabelaPedidos;
    procedure CriarTabelaProdutosPedidos;
    procedure TrocarBase;
  public
    property Senha: String read FSenha write FSenha;
    property Usuario: String read FUsuario write FUsuario;
    property Servidor: String read FServidor write FServidor;
    property Conexao: TFDConnection read FConexao write FConexao;

    destructor Destroy; override;
    constructor Create;

    procedure CriarBase;
  end;

implementation

uses
  FireDAC.Stan.Async;
{ TCriarMTBD }

constructor TCriarMTBD.Create;
begin
end;

procedure TCriarMTBD.CriarBase;
begin
  CriarMTBD;
  TrocarBase;
  CriarTabelaUF;
  CriarTabelaCidade;
  CriarTabelaClientes;
  CriarTabelaProdutos;
  CriarTabelaPedidos;
  CriarTabelaProdutosPedidos;
end;

procedure TCriarMTBD.TrocarBase;
begin
  FConexao.Connected := False;
  FConexao.Params.Clear;
  FConexao.Params.Add('Database=MTBD');
  FConexao.Params.Add('Password=' + FSenha + '');
  FConexao.Params.Add('User_Name=' + FUsuario + '');
  FConexao.Params.Add('Server=' + FServidor + '');
  FConexao.Params.Add('DriverID=MySQL');
  FConexao.Connected := True;
end;

procedure TCriarMTBD.CriarMTBD;
const
  cCOMANDO = 'CREATE DATABASE IF NOT EXISTS MTBD;';
var
  qry : TFDCommand;
begin
  qry := TFDCommand.Create(nil);
  try
    qry.Connection := FConexao;
    qry.Execute(cCOMANDO);
  finally
    qry.Free;
  end;
end;

procedure TCriarMTBD.CriarTabelaCidade;
const
  cCOMANDO = 'CREATE TABLE IF NOT EXISTS CIDADES ( ' +
             '   	CODIGO INTEGER NOT NULL AUTO_INCREMENT, ' +
             '    ID_UF INTEGER NOT NULL, ' +
             '    NOME VARCHAR(75), ' +
             '    PRIMARY KEY (CODIGO), ' +
             '    FOREIGN KEY (ID_UF) REFERENCES UF (CODIGO));';
var
  qry : TFDCommand;
begin
  qry := TFDCommand.Create(nil);
  try
    qry.Connection := FConexao;
    qry.Execute(cCOMANDO);
  finally
    qry.Free;
  end;
end;

procedure TCriarMTBD.CriarTabelaClientes;
const
  cCOMANDO = 'CREATE TABLE IF NOT EXISTS CLIENTES ( ' +
             '  	CODIGO INTEGER NOT NULL AUTO_INCREMENT, ' +
             '    ID_UF INTEGER NOT NULL, ' +
             '    ID_CIDADE INTEGER NOT NULL, ' +
             '    NOME VARCHAR(150) NOT NULL, ' +
             '  	PRIMARY KEY (CODIGO) );';
var
  qry : TFDCommand;
begin
  qry := TFDCommand.Create(nil);
  try
    qry.Connection := FConexao;
    qry.Execute(cCOMANDO);
  finally
    qry.Free;
  end;
end;

procedure TCriarMTBD.CriarTabelaPedidos;
const
  cCOMANDO = 'CREATE TABLE IF NOT EXISTS PEDIDOS ( ' +
             '    CODIGO INTEGER NOT NULL AUTO_INCREMENT, ' +
             '    ID_ENTIDADE INTEGER NOT NULL, ' +
             '    DATA_EMISSAO DATETIME NOT NULL, ' +
             '    VALOR_TOTAL FLOAT NOT NULL, ' +
             '    PRIMARY KEY(CODIGO), ' +
             '    FOREIGN KEY (ID_ENTIDADE) REFERENCES CLIENTES (CODIGO) );';
var
  qry : TFDCommand;
begin
  qry := TFDCommand.Create(nil);
  try
    qry.Connection := FConexao;
    qry.Execute(cCOMANDO);
  finally
    qry.Free;
  end;
end;

procedure TCriarMTBD.CriarTabelaProdutos;
const
  cCOMANDO = 'CREATE TABLE IF NOT EXISTS PRODUTOS ( ' +
             '   	CODIGO INTEGER NOT NULL AUTO_INCREMENT, ' +
             '    DESCRICAO VARCHAR(150) NOT NULL, ' +
             '    PRECO_VENDA FLOAT NOT NULL, ' +
             '    PRIMARY KEY(CODIGO) );';
var
  qry : TFDCommand;
begin
  qry := TFDCommand.Create(nil);
  try
    qry.Connection := FConexao;
    qry.Execute(cCOMANDO);
  finally
    qry.Free;
  end;
end;

procedure TCriarMTBD.CriarTabelaProdutosPedidos;
const
  cCOMANDO = 'CREATE TABLE IF NOT EXISTS PRODUTOS_PEDIDO ( ' +
             '  	CODIGO INTEGER NOT NULL AUTO_INCREMENT, ' +
             '    ID_PEDIDO INTEGER NOT NULL, ' +
             '    ID_PRODUTO INTEGER NOT NULL, ' +
             '    QTDE FLOAT NOT NULL, ' +
             '    VLR_UNITARIO FLOAT NOT NULL, ' +
             '    VLR_TOTAL FLOAT NOT NULL, ' +
             '    PRIMARY KEY(CODIGO), ' +
             '    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDOS (CODIGO), ' +
             '    FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTOS (CODIGO) );';
var
  qry : TFDCommand;
begin
  qry := TFDCommand.Create(nil);
  try
    qry.Connection := FConexao;
    qry.Execute(cCOMANDO);
  finally
    qry.Free;
  end;
end;

procedure TCriarMTBD.CriarTabelaUF;
const
  cCOMANDO = 'CREATE TABLE IF NOT EXISTS UF ( '+
             '	     CODIGO INTEGER NOT NULL AUTO_INCREMENT, '+
             '       NOME VARCHAR(75) NOT NULL, '+
             '       SIGLA VARCHAR(2) NOT NULL, '+
             '       PRIMARY KEY (CODIGO) );';
var
  qry : TFDCommand;
begin
  qry := TFDCommand.Create(nil);
  try
    qry.Connection := FConexao;
    qry.Execute(cCOMANDO);
  finally
    qry.Free;
  end;
end;

destructor TCriarMTBD.Destroy;
begin

  inherited;
end;

end.
