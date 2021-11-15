unit uControler.Produtos;

interface

uses
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  uModel.Rotinas;

type
  TProdutos = class
  private
    FCodigo: Integer;
    FNome: String;
    FValorVenda : Currency;

    procedure Inserir;
    procedure Alterar;
    function CriarMemTable: TFDMemTable;
    function Listar: TFDMemTable;
    procedure Validar;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property ValorVenda: Currency read FValorVenda write FValorVenda;

    destructor Destroy; override;
    constructor Create;

    procedure Carregar;
    procedure Clear;
    procedure Salvar;
    procedure Deletar;
    procedure Consultar;
  end;

implementation

uses
  System.SysUtils,
  System.UITypes,
  Vcl.Forms,
  Data.DB,
  View.Pesquisa, Winapi.Windows;

{ TProdutos }

procedure TProdutos.Carregar;
const
  cCOMANDO = 'select Codigo, Descricao, ' +
             '       Preco_Venda ' +
             '  from Produtos ' +
             ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  if FCodigo = 0 then
    raise Exception.Create('Código do produto não foi informado. Por favor Verifique!');

  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Open;
    Clear;
    FCodigo := qry.FieldByName('Codigo').AsInteger;
    FValorVenda := qry.FieldByName('Preco_Venda').AsCurrency;
    FNome := qry.FieldByName('Descricao').asString;
  finally
    qry.Free;
  end;
end;

procedure TProdutos.Clear;
begin
  FCodigo := 0;
  FValorVenda := 0;
  FNome := '';
end;

procedure TProdutos.Consultar;
var
  frm : TfrmPesquisa;
begin
  frm := TfrmPesquisa.Create(Application);
  try
    frm.qryRegistros := Listar;
    if frm.QryRegistros.RecordCount = 0 then
    begin
      Application.MessageBox('Nenhum registro para ser listado!', Pchar(Application.Title), MB_ICONINFORMATION + MB_OK);
      Exit;
    end;
    if frm.ShowModal = mrCancel then
    begin
      Clear;
      Exit;
    end;
    FCodigo := frm.qryRegistros.FieldByName('Codigo').asinteger;
    Carregar;
  finally
    frm.Free;
  end;
end;

constructor TProdutos.Create;
begin
  Clear;
end;

procedure TProdutos.Deletar;
const
  cCOMANDO = 'delete from Produtos '+
             ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  if FCodigo = 0 then
    raise Exception.Create('Código do produto não foi informado. Por favor Verifique!');

  dmDados.con.StartTransaction;
  try
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
      raise Exception.Create('Houve um erro ao deletar o Produto informafo.' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

destructor TProdutos.Destroy;
begin
  inherited;
end;

procedure TProdutos.Inserir;
const
  cCOMANDO = 'insert into Produtos ' +
             '   (Descricao, Preco_Venda) ' +
             ' values (:pNome, :pPrecoVenda)';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.Params.ParamByName('pPrecoVenda').Value := FValorVenda;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TProdutos.Alterar;
const
  cCOMANDO = 'update Produtos ' +
             '   set Preco_Venda = :pPrecoVenda, ' +
             '       Descricao = :pNome ' +
             ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.Params.ParamByName('pPrecoVenda').Value := FValorVenda;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TProdutos.Validar;
begin
  if Trim(FNome) = '' then
    raise Exception.Create('Nome do produto precisa ser informado. Por favor Verifique!');
  if FValorVenda = 0 then
    raise Exception.Create('Valor de venda precisa ser informado. Por favor Verifique!');
end;

procedure TProdutos.Salvar;
begin
  Validar;
  dmDados.con.StartTransaction;
  try
    if FCodigo = 0 then
      Inserir
    else
      Alterar;
    dmDados.con.Commit;
  except on e:Exception do
    begin
      dmDados.con.Rollback;
      raise Exception.Create('Houve um erro ao salvar o Produto informado. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

function TProdutos.CriarMemTable: TFDMemTable;
begin
  Result := TFDMemTable.Create(Nil);
  Result.FieldDefs.Add('Codigo', ftInteger);
  Result.FieldDefs.Add('Nome', ftString, 75);
  Result.FieldDefs.Add('ValorVenda', ftCurrency);

  Result.Close;
  Result.Open;
  Result.FieldByName('Codigo').DisplayLabel := 'Código';
  Result.FieldByName('Nome').DisplayLabel := 'Nome';
  Result.FieldByName('ValorVenda').DisplayLabel := 'Valor de Venda';
  TCurrencyField(Result.FieldByName('ValorVenda')).DisplayFormat := '#,###,##0.00'
end;

function TProdutos.Listar: TFDMemTable;
const
  cCOMANDO = 'select p.Codigo, p.Descricao, p.Preco_Venda'+
             '  from Produtos p ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    Result := CriarMemTable;
    qry.SQL.Add(cCOMANDO);
    qry.Open;
    qry.First;
    while not qry.Eof do
    begin
      Result.Append;
      Result.FieldByName('Codigo').AsInteger := qry.FieldByName('Codigo').AsInteger;
      Result.FieldByName('Nome').AsString := qry.FieldByName('Descricao').AsString;
      Result.FieldByName('ValorVenda').AsString := qry.FieldByName('Preco_Venda').AsString;
      Result.Post;

      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

end.
