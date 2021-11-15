unit uControler.Entidade;

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
  uControler.Cidade,
  uControler.UF;

type
  TEntidade = class
  private
    FCodigo: Integer;
    FCidade: TCidade;
    FUF: TUF;
    FNome: String;
    procedure Inserir;
    procedure Alterar;
    function Listar: TFDMemtable;
    function CriarMemTable: TFDMemTable;
    procedure Validar;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Cidade: TCidade read FCidade write FCidade;
    property UF : TUF read FUF write FUF;
    property Nome: String read FNome write FNome;

    constructor Create;
    destructor Destroy; override;

    procedure Carregar;
    procedure Clear;
    procedure Salvar;
    procedure Deletar;
    procedure Consultar;
  end;

implementation

uses
  Data.DB,
  uModel.Rotinas,
  System.SysUtils,
  View.Pesquisa,
  Vcl.Forms,
  Vcl.Controls,
  Winapi.Windows;

{ TEntidade }

procedure TEntidade.Carregar;
const
  cCOMANDO = 'select c.Codigo, c.Nome, c.ID_UF, ' +
             '       c.ID_Cidade ' +
             '  from Clientes c ' +
             ' where c.Codigo = :pCodigo ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Open;
    Clear;
    if qry.RecordCount = 0 then
      Exit;

    FCodigo := qry.FieldByName('Codigo').AsInteger;
    FNome := qry.FieldByName('Nome').asString;
    FCidade.Codigo := qry.FieldByName('ID_Cidade').AsInteger;
    FCidade.Carregar;
    FUF.Codigo := qry.FieldByName('ID_UF').AsInteger;
    FUF.Carregar;
  finally
    qry.Free;
  end;
end;

procedure TEntidade.Clear;
begin
  FCodigo := 0;
  FNome := '';
  FCidade.Clear;
  FUF.Clear;
end;

constructor TEntidade.Create;
begin
  FUF := TUF.Create;
  FCidade := TCidade.Create;
  Clear;
end;

procedure TEntidade.Deletar;
const
  cCOMANDO  = 'delete from Clientes '+
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
      raise Exception.Create('Houve um erro ao deletar a Entidade informafa. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

destructor TEntidade.Destroy;
begin
  FCidade.Free;
  FUF.Free;
  inherited;
end;

procedure TEntidade.Consultar;
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

function TEntidade.Listar: TFDMemtable;
const
  cCOMANDO = 'select c.Codigo, c.Nome, u.Nome as UF, ci.Nome as Cidade ' +
             '  from clientes c ' +
             ' inner join Cidades ci ' +
             '    on c.ID_Cidade = ci.Codigo ' +
             ' inner join UF u ' +
             '    on c.ID_UF = u.Codigo';
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
      Result.FieldByName('Nome').AsString := qry.FieldByName('Nome').AsString;
      Result.FieldByName('Cidade').AsString := qry.FieldByName('Cidade').AsString;
      Result.FieldByName('UF').AsString := qry.FieldByName('UF').AsString;
      Result.Post;

      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

function TEntidade.CriarMemTable: TFDMemTable;
begin
  Result := TFDMemTable.Create(Nil);
  Result.FieldDefs.Add('Codigo', ftInteger);
  Result.FieldDefs.Add('Nome', ftString, 75);
  Result.FieldDefs.Add('Cidade', ftString, 75);
  Result.FieldDefs.Add('UF', ftString, 75);

  Result.Close;
  Result.Open;
  Result.FieldByName('Codigo').DisplayLabel := 'Código';
  Result.FieldByName('Nome').DisplayLabel := 'Nome';
  Result.FieldByName('Cidade').DisplayLabel := 'Cidade';
  Result.FieldByName('UF').DisplayLabel := 'UF';
end;

procedure TEntidade.Alterar;
const
  cCOMANDO = 'update Clientes ' +
             '   set ID_UF = :pUF, ' +
             '       ID_Cidade = :pCidade, ' +
             '       Nome = :pNome ' +
             ' where Codigo = :pCodigo ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Params.ParamByName('pUF').Value := FUF.Codigo;
    qry.Params.ParamByName('pCidade').Value := FCidade.Codigo;
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TEntidade.Inserir;
const
  cCOMANDO = 'insert into clientes ' +
             '  (ID_UF, ID_Cidade, Nome) ' +
             ' values (:pUF, :pCidade, :pNome) ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pUF').Value := FUF.Codigo;
    qry.Params.ParamByName('pCidade').Value := FCidade.Codigo;
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TEntidade.Validar;
begin
  if FUF.Codigo = 0 then
    raise Exception.Create('Estado precisa ser informado. Por favor Verifique!');
  if FCidade.Codigo = 0 then
    raise Exception.Create('Cidade precisa ser informada. Por favor Verifique!');
  if Trim(FNome) = '' then
    raise Exception.Create('Nome precisa ser informado. Por favor Verifique!');
end;

procedure TEntidade.Salvar;
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
      raise Exception.Create('Houve um erro ao salvar a Entidade informafa. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

end.
