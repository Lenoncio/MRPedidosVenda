unit uControler.Cidade;

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
  uControler.UF;

type
  TCidade = class
  private
    FCodigo: Integer;
    FUF: TUF;
    FNome: String;
    procedure Inserir;
    procedure Alterar;
    function CriarMemTable: TFDMemTable;
    function Listar: TFDMemTable;
    procedure Validar;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property UF: TUF read FUF write FUF;
    property Nome: String read FNome write FNome;

    constructor Create;
    destructor Destroy; override;

    procedure Carregar;
    procedure Clear;
    procedure Salvar;
    procedure Deletar;
    procedure Consultar;
    class function ConsultarIDCidade(ANomeCidade: String): Integer; static;
  end;

implementation

uses
  uModel.Rotinas,
  System.SysUtils,
  View.Pesquisa,
  Vcl.Controls,
  Vcl.Forms,
  Data.DB,
  Winapi.Windows,
  uControler.Produtos;

{ TCidade }

procedure TCidade.Carregar;
const
  cCOMANDO = 'select c.Codigo, c.Nome, u.Codigo as uf ' +
             '  from Cidades c ' +
             ' inner join UF u ' +
             '    on c.ID_UF = u.Codigo '+
             ' where c.Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.ADD(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Open;
    Clear;
    if qry.RecordCount = 0 then
      Exit;
    FUF.Codigo := qry.FieldByName('uf').AsInteger;
    FUF.Carregar;
    FCodigo := qry.FieldByName('Codigo').AsInteger;
    FNome := qry.FieldByName('Nome').AsString;

  finally
    qry.Free;
  end;
end;

procedure TCidade.Clear;
begin
  FUF.Clear;
  FCodigo := 0;
  FNome := '';
end;

procedure TCidade.Consultar;
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

constructor TCidade.Create;
begin
  FUF := TUF.Create;
  Clear;
end;

procedure TCidade.Deletar;
const
  cCOMANDO = 'delete from Cidades '+
             ' where Codigo = :pCodigo ';
var
  qry : TFDQuery;
begin
  if FCodigo = 0 then
    raise Exception.Create('Código da Cidade não foi informado. Por favor Verifique!');
  dmDados.con.StartTransaction;
  try
    qry := dmDados.CreateQuery;
    try
      qry.SQL.Add(cCOMANDO);
      qry.Params.ParamByName('pUF').Value := FCodigo;
      qry.ExecSQL;
    finally
      qry.Free;
    end;
    dmDados.con.Commit;
  except on e:Exception do
    begin
      dmDados.con.Rollback;
      raise Exception.Create('Houve um erro ao Deletar a Cidade informada. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

function TCidade.CriarMemTable: TFDMemTable;
begin
  Result := TFDMemTable.Create(nil);
  Result.FieldDefs.Add('Codigo', ftInteger);
  Result.FieldDefs.Add('Nome', ftString, 75);
  Result.FieldDefs.Add('UF', ftString, 75);
  Result.Close;
  Result.Open;
  Result.FieldByName('Codigo').DisplayLabel := 'Código';
  Result.FieldByName('Nome').DisplayLabel := 'Cidade';
  Result.FieldByName('UF').DisplayLabel := 'UF';
end;

destructor TCidade.Destroy;
begin
  FUF.Free;
  inherited;
end;

function TCidade.Listar: TFDMemtable;
const
  cCOMANDO = 'select c.Codigo, c.Nome, u.Nome as uf ' +
             '  from Cidades c ' +
             ' inner join UF u ' +
             '    on c.ID_UF = u.Codigo ';
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
      Result.FieldByName('UF').AsString := qry.FieldByName('uf').AsString;
      Result.Post;

      qry.Next
    end;
  finally
    qry.Free;
  end;
end;

procedure TCidade.Alterar;
const
  cCOMANDO = 'update Cidades ' +
             '   set ID_UF = :pUF, ' +
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
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TCidade.Inserir;
const
  cCOMANDO = 'insert into Cidades '+
             '    (ID_UF, Nome) ' +
             '  values (:pUF, :pNome) ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pUF').Value := FUF.Codigo;
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TCidade.Validar;
begin
  if FUF.Codigo = 0 then
    raise Exception.Create('Estado não foi informado. Por favor Verifique!');
  if Trim(FNome) = '' then
    raise Exception.Create('Estado não foi informado. Por favor Verifique!');
end;

procedure TCidade.Salvar;
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
      raise Exception.Create('Houve um erro ao salvar a Cidade informada. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

class function TCidade.ConsultarIDCidade(ANomeCidade: String): Integer;
const
  cCOMANDO = 'select Codigo from Cidades '+
             ' where Nome = :pNome';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pNome').Value := ANomeCidade;
    qry.Open;
    Result := qry.FieldByName('Codigo').AsInteger;
  finally
    qry.Free;
  end;
end;

end.
