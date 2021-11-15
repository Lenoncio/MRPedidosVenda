unit uControler.Pedido;

interface

uses
  uControler.ProdutosPedidos, uControler.Entidade;

type
  TPedido = class
  private
    FCodigo: Integer;
    FEntidades: TEntidade;
    FDataEmissao: TDateTime;
    FVlrTotal: Currency;
    FProdutos: TProdutosPedidosList;

    procedure Inserir;
    procedure Alterar;
    procedure CarregarProdutos;
    procedure DeletarProdutos;
    procedure BuscarUltimoID;
    procedure Validar;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Entidades: TEntidade read FEntidades write FEntidades;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property VlrTotal: Currency read FVlrTotal write FVlrTotal;
    property Produtos: TProdutosPedidosList read FProdutos write FProdutos;

    destructor Destroy; override;
    constructor Create;

    procedure Carregar;
    procedure Clear;
    procedure Salvar;
    procedure Deletar;
  end;

implementation

uses
  System.SysUtils, uModel.Rotinas, FireDAC.Comp.Client;

{ TPedido }

procedure TPedido.Carregar;
const
  cCOMANDO = 'select p.Codigo, p.ID_Entidade, p.Data_Emissao, ' +
             '       p.Valor_Total ' +
             '  from Pedidos p ' +
             ' where p.Codigo = :pCodigo ';
var
  qry : TFDQuery;
begin
  if FCodigo = 0 then
    raise Exception.Create('Código do pedido não foi informado. Por favor Verifique!');

  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Open;
    Clear;
    if qry.RecordCount = 0 then
      Exit;
    FCodigo := qry.FieldByName('Codigo').AsInteger;
    FDataEmissao := qry.FieldByName('Data_Emissao').AsDateTime;
    FVlrTotal := qry.FieldByName('Valor_Total').asCurrency;
    FEntidades.Codigo := qry.FieldByName('ID_Entidade').AsInteger;
    FEntidades.Carregar;
    CarregarProdutos;
  finally
    qry.Free;
  end;
end;

procedure TPedido.CarregarProdutos;
const
  cCOMANDO = 'select p.Codigo, p.ID_Pedido, p.ID_Produto, ' +
             '       p.Qtde, p.Vlr_Unitario, p.Vlr_Total ' +
             '  from Produtos_Pedido p ' +
             ' where p.ID_Pedido = :pCodigo ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Open;
    qry.First;
    while not qry.Eof do
    begin
      with FProdutos.Add do
      begin
        Codigo := qry.FieldByName('Codigo').AsInteger;
        Produto.Codigo := qry.FieldByName('ID_Produto').AsInteger;
        Produto.Carregar;
        VlrTotal := qry.FieldByName('Vlr_Total').asCurrency;
        Qtde := qry.FieldByName('Qtde').asCurrency;
        VlrUnitario := qry.FieldByName('Vlr_Unitario').asCurrency;
        Pedido := 0;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TPedido.Clear;
begin
  FCodigo := 0;
  FDataEmissao := Now;
  FVlrTotal := 0;
  FProdutos.Clear;
  FEntidades.Clear;
end;

constructor TPedido.Create;
begin
  FProdutos := TProdutosPedidosList.Create;
  FEntidades := TEntidade.Create;
  Clear;
end;

procedure TPedido.DeletarProdutos;
const
  cCOMANDO = 'delete from Produtos_Pedido ' +
             ' where ID_Pedido = :pCodigo';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TPedido.Deletar;
const
  cCOMANDO = 'delete from Pedidos ' +
             ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  if FCodigo = 0 then
    raise Exception.Create('Código do pedido não foi informado. Por favor Verifique!');
  dmDados.con.StartTransaction;
  try
    DeletarProdutos;
    qry := dmDados.CreateQuery;
    try
      qry.SQL.Add(cCOMANDO);
      qry.Params.ParamByName('pCodigo').Value := FCodigo;
      qry.ExecSQL;
    finally
      qry.Free;
    end;
    dmDados.con.Commit;
  except on e:Exception do
    begin
      dmDados.con.Rollback;
      raise Exception.Create('Houve um erro ao deletar o Pedido informado. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

destructor TPedido.Destroy;
begin
  FProdutos.Free;
  FEntidades.Free;
  inherited;
end;

procedure TPedido.Inserir;
const
  cCOMANDO = 'insert into Pedidos ' +
             '  (ID_Entidade, Data_Emissao, Valor_Total) ' +
             ' values  (:pIDEntidade, :pDataEmissao, :pValorTotal) ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pIDEntidade').Value := FEntidades.Codigo;
    qry.Params.ParamByName('pDataEmissao').Value := FDataEmissao;
    qry.Params.ParamByName('pValorTotal').Value := FVlrTotal;
    qry.ExecSQL;
    BuscarUltimoID;
  finally
    qry.Free;
  end;
end;

procedure TPedido.BuscarUltimoID;
const
  cCOMANDO = 'select Codigo from Pedidos ' +
             ' order by Codigo desc ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Open;
    qry.First;
    FCodigo := qry.FieldByName('Codigo').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TPedido.Alterar;
const
  cCOMANDO = 'update Pedidos ' +
             '   set ID_Entidade = :pIDEntidade, ' +
             '       Data_Emissao = :pData_Emissao, ' +
             '       Valor_Total = :pValor_Total ' +
             ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pIDEntidade').Value := FEntidades.Codigo;
    qry.Params.ParamByName('pDataEmissao').Value := FDataEmissao;
    qry.Params.ParamByName('pValorTotal').Value := FVlrTotal;
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TPedido.Validar;
begin
  if FVlrTotal = 0 then
    raise Exception.Create('Valor Total precisa ser informado. Por favor Verifique!');
  if FEntidades.Codigo = 0 then
    raise Exception.Create('Entidade precisa ser informada. Por favor Verifique!');
  if FProdutos.Count = 0 then
    raise Exception.Create('Um produto precisa ser informado. Por favor Verifique!');
end;

procedure TPedido.Salvar;
begin
  Validar;
  dmDados.con.StartTransaction;
  try
    if FCodigo = 0 then
      Inserir
    else
      Alterar;
    FProdutos.SalvarProdutos(FCodigo);
    dmDados.con.Commit;
  except on e:Exception do
    begin
      dmDados.con.Rollback;
      raise Exception.Create('Houve um erro ao salvar o Pedido informado. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

end.
