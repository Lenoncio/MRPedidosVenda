unit uModel.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Stan.Param,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Vcl.Forms, uControler.Criar.MTBD;

type
  TdmDados = class(TDataModule)
    con: TFDConnection;
    fdphysmysqldrvrlnk1: TFDPhysMySQLDriverLink;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
  private
    FSenha: String;
    FServidor: String;
    FUsuario: String;
    function LocalizarBaseDeDados(AConTeste : TFDConnection): Boolean;
    function EstabelecerConexaoTeste: Boolean;
    procedure CriarBancoDeDados(AConTeste : TFDConnection);
    { Private declarations }
  public
    property Senha: String read FSenha write FSenha;
    property Usuario: String read FUsuario write FUsuario;
    property Servidor: String read FServidor write FServidor;

    function CreateQuery: TFDQuery;
    procedure EstabelecerConexao;
    { Public declarations }
  end;

var
  dmDados: TdmDados;

implementation

uses
  Winapi.Windows;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmDados }

function TdmDados.CreateQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := con;
end;

function TdmDados.EstabelecerConexaoTeste: Boolean;
var
  conTeste : TFDConnection;
begin
  conTeste := TFDConnection.Create(nil);
  try
    conTeste.Params.Clear;
    conTeste.Params.Add('Database=SYS');
    conTeste.Params.Add('Password=' + FSenha + '');
    conTeste.Params.Add('User_Name=' + FUsuario + '');
    conTeste.Params.Add('Server=' + FServidor + '');
    conTeste.Params.Add('DriverID=MySQL');
    try
      conTeste.Connected := True;
      if not LocalizarBaseDeDados(conTeste) then
        CriarBancoDeDados(conTeste);
    except on e:Exception do
      begin
        Application.MessageBox(Pchar('Erro ao estabelecer conexao com o servidor.' + sLineBreak + 'Por favor Verifique!'), pchar(Application.Title), MB_ICONERROR+MB_OK);
      end;
    end;
  finally
    Result := conTeste.Connected;
    conTeste.Free;
  end;
end;

function TdmDados.LocalizarBaseDeDados(AConTeste : TFDConnection): Boolean;
const
  cCOMANDO = 'SELECT SCHEMA_NAME ' +
             '  FROM INFORMATION_SCHEMA.SCHEMATA ' +
             ' WHERE SCHEMA_NAME = :pNome';
var
  qry : TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := AConTeste;
    qry.SQL.Add(cCOMANDO);
    qry.Params.ParamByName('pNome').Value := 'MTBD';
    qry.Open;
    Result := qry.RecordCount = 1;
  finally
    qry.Free;
  end;
end;

procedure TdmDados.CriarBancoDeDados(AConTeste : TFDConnection);
var
  criar : TCriarMTBD;
begin
  criar := TCriarMTBD.Create;
  try
    criar.Senha := FSenha;
    criar.Usuario := FUsuario;
    criar.Servidor := FServidor;
    criar.Conexao := AConTeste;
    criar.CriarBase;
  finally
    criar.Free;
  end;
end;

procedure TdmDados.EstabelecerConexao;
begin
  if not EstabelecerConexaoTeste then
    Exit;
  con.Params.Clear;
  con.Params.Add('Database=MTBD');
  con.Params.Add('Password=' + FSenha + '');
  con.Params.Add('User_Name=' + FUsuario + '');
  con.Params.Add('Server=' + FServidor + '');
  con.Params.Add('DriverID=MySQL');
  con.Connected := True;
end;

end.
