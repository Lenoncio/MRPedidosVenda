unit uControler.UF;

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
  uControler.Produtos;

type
  TUF = class
  private
    FCodigo: Integer;
    FNome: String;
    FSigla: String;

    procedure Inserir;
    procedure Alterar;
    function CriarMemTable: TFDMemtable;
    function Listar: TFDMemtable;
    procedure Consultar;
    procedure Validar;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Sigla: String read FSigla write FSigla;

    constructor Create;
    destructor Destroy; override;

    procedure Carregar;
    procedure Clear;
    procedure Salvar;
    procedure Deletar;
    class function ConsultarIDUF(ANomeUF: String): Integer;
  end;

implementation

uses
  uModel.Rotinas,
  System.SysUtils,
  View.Pesquisa,
  Vcl.Forms,
  Vcl.Controls,
  Winapi.Windows,
  Data.DB;

{ TUF }
procedure TUF.Carregar;
const
  cCOMANDO = 'select Codigo, Nome, Sigla ' +
             '  from UF ' +
             ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  qry :=dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pCodigo').Value := FCodigo;
    qry.Open;
    Clear;
    if qry.RecordCount = 0 then
      Exit;
    FCodigo := qry.FieldByName('Codigo').AsInteger;
    FNome := qry.FieldByName('Nome').AsString;
    FSigla := qry.FieldByName('Sigla').AsString;
    qry.Next;
  finally
    qry.Free;
  end;
end;

procedure TUF.Clear;
begin
  FCodigo := 0;
  FNome := '';
  FSigla := '';
end;

constructor TUF.Create;
begin
  Clear;
end;

function TUF.CriarMemTable: TFDMemtable;
begin
  Result := TFDMemtable.Create(nil);
  Result.FieldDefs.Add('Codigo', ftInteger);
  Result.FieldDefs.Add('Estado', ftString, 75);
  Result.FieldDefs.Add('Sigla', ftString, 2);
  Result.Close;
  Result.Open;
  Result.FieldByName('Codigo').DisplayLabel := 'Código';
  Result.FieldByName('Estado').DisplayLabel := 'Estado';
  Result.FieldByName('Sigla').DisplayLabel := 'Sigla';
end;

function TUF.Listar: TFDMemtable;
const
  cCOMANDO = 'select Codigo, Nome, Sigla from UF';
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
      Result.FieldByName('Estado').AsInteger := qry.FieldByName('Nome').AsInteger;
      Result.FieldByName('Sigla').AsInteger := qry.FieldByName('Sigla').AsInteger;
      Result.Post;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure TUF.Consultar;
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

class function TUF.ConsultarIDUF(ANomeUF: String): Integer;
const
  cCOMANDO = 'select Codigo from UF '+
             ' where Nome = :pNome';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pNome').Value := ANomeUF;
    qry.Open;
    Result := qry.FieldByName('Codigo').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TUF.Deletar;
const
  cCOMANDO = 'delete from UF '+
             ' where Codigo = :pCodigo';
var
  qry : TFDQuery;
begin
  if FCodigo = 0 then
    raise Exception.Create('Código da UF não foi informada. Por favor Verifique!');

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
      raise Exception.Create('Houve um erro ao deletar a UF informada. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

destructor TUF.Destroy;
begin

  inherited;
end;

procedure TUF.Inserir;
const
  cCOMANDO = 'insert into UF ' +
             '  (Nome, Sigla) ' +
             ' values (:pNome, :pSigla) ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.Params.ParamByName('pSigla').Value := FSigla;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TUF.Alterar;
const
  cCOMANDO = ' update UF ' +
             '   set Nome = :pNome, ' +
             '       Sigla = :pSigla ' +
             ' where Codigo = :pCodigo ';
var
  qry : TFDQuery;
begin
  qry := dmDados.CreateQuery;
  try
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pID').Value := FCodigo;
    qry.Params.ParamByName('pNome').Value := FNome;
    qry.Params.ParamByName('pSigla').Value := FSigla;
    qry.ExecSQL;
  finally
    qry.Free;
  end;
end;

procedure TUF.Validar;
begin
  if Trim(FNome) = '' then
    raise Exception.Create('Nome do Estado precisa ser informado. Por favor Verifique!');
  if Trim(FSigla) = '' then
    raise Exception.Create('Sigla do Estado precisa ser informado. Por favor Verifique!');
end;

procedure TUF.Salvar;
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
      raise Exception.Create('Houve um erro ao salvar a UF informada. ' + sLineBreak + 'Erro: '+e.Message);
    end;
  end;
end;

end.
