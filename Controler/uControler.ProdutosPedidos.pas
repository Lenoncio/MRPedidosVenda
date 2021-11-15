unit uControler.ProdutosPedidos;

interface

uses
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uControler.Produtos;

type
  TProdutosPedidos = class
  private
    FCodigo: Integer;
    FProduto: TProdutos;
    FVlrTotal: Currency;
    FQtde: Currency;
    FVlrUnitario: Currency;
    FPedido: Integer;
    procedure Inserir;
    procedure Alterar;
    procedure Validar;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Produto: TProdutos read FProduto write FProduto;
    property Qtde: Currency read FQtde write FQtde;
    property VlrUnitario: Currency read FVlrUnitario write FVlrUnitario;
    property VlrTotal: Currency read FVlrTotal write FVlrTotal;
    property Pedido: Integer read FPedido write FPedido;
    procedure Salvar;
  end;

  TProdutosPedidosList = class(TList)
  private
    function GetItems(Index: Integer): TProdutosPedidos;
    procedure SetItems(Index: Integer; const Value: TProdutosPedidos);
  public
    property Items[Index: Integer]: TProdutosPedidos read GetItems write SetItems; default;
    function Add: TProdutosPedidos; overload;
    function Last(): TProdutosPedidos;
    procedure SalvarProdutos(APedido: Integer);
    procedure Clear;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, uModel.Rotinas;


{ TComandosList }

function TProdutosPedidosList.Add: TProdutosPedidos;
var
  i : Integer;
begin
  i := inherited Add(TProdutosPedidos.Create);
  Items[i].Produto := TProdutos.Create;
  Result := Items[i];
end;

procedure TProdutosPedidosList.Clear;
var
  item : TProdutosPedidos;
  i : Integer;
begin
  for i := Pred(Count) downto 0 do
  begin
    item := Extract(Items[i]);
    item.Free;
  end;
end;

destructor TProdutosPedidosList.Destroy;
begin
  Clear;
  inherited;
end;

function TProdutosPedidosList.GetItems(Index: Integer): TProdutosPedidos;
begin
  Result := TProdutosPedidos(inherited Get(Index));
end;

function TProdutosPedidosList.Last: TProdutosPedidos;
begin
  Result := TProdutosPedidos(inherited Last);
end;

procedure TProdutosPedidosList.SalvarProdutos(APedido: Integer);
var
  i : Integer;
begin
  for i := Pred(Count) downto 0 do
  begin
    Items[i].Pedido := APedido;
    Items[i].Salvar;
  end;
end;

procedure TProdutosPedidosList.SetItems(Index: Integer; const Value: TProdutosPedidos);
begin
  inherited Put(Index, Value);
end;

{ TProdutosPedidos }

procedure TProdutosPedidos.Alterar;
const
  cCOMANDO  = 'update Produtos_Pedido ' +
              '   set ID_Pedido = :pIDPedido, ' +
              '       ID_Produto = :pIDProduto, ' +
              '       Qtde = :pQtde, ' +
              '       Vlr_Unitario = :pVlrUnitario, ' +
              '       Vlr_Toal = :pvlrToal ' +
              ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pIDPedido').Value := FPedido;
    qry.Params.ParamByName('pIDProduto').Value := FProduto.Codigo;
    qry.Params.ParamByName('pQtde').Value := FQtde;
    qry.Params.ParamByName('pVlrUnitario').Value := FVlrUnitario;
    qry.Params.ParamByName('pVlrToal').Value := FVlrTotal;
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TProdutosPedidos.Inserir;
const
  cCOMANDO  = 'insert into Produtos_Pedido ' +
              '  (ID_Pedido, ID_Produto, Qtde, ' +
              '   Vlr_Unitario, Vlr_Total) ' +
              ' values (:pIDPedido, :pIDProduto, :pQtde, ' +
              '         :pVlrUnitario, :pvlrTotal)';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pIDPedido').Value := FPedido;
    qry.Params.ParamByName('pIDProduto').Value := FProduto.Codigo;
    qry.Params.ParamByName('pQtde').Value := FQtde;
    qry.Params.ParamByName('pVlrUnitario').Value := FVlrUnitario;
    qry.Params.ParamByName('pvlrTotal').Value := FVlrTotal;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TProdutosPedidos.Validar;
begin
  if FPedido = 0 then
    raise Exception.Create('Número do Pedido não foi informado. Por favor Verifique!');
  if FProduto.Codigo = 0 then
    raise Exception.Create('Produto não foi informado. Por favor Verifique!');
  if FQtde = 0 then
    raise Exception.Create('Quantidade não foi informado. Por favor Verifique!');
  if FVlrUnitario = 0 then
    raise Exception.Create('Valor Unitário não foi informado. Por favor Verifique!');
  if FVlrTotal = 0 then
    raise Exception.Create('Valor Toral não foi informado. Por favor Verifique!');
end;

procedure TProdutosPedidos.Salvar;
begin
  Validar;
  if FCodigo = 0 then
    Inserir
  else
    Alterar;
end;

end.
