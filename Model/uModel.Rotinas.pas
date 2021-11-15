unit uModel.Rotinas;

interface

uses
  uModel.DataModule;

  function EstabelecerConexao: Boolean;
  procedure PrepararBanco;

var
  dmDados : tdmdados;

implementation

uses
  Vcl.Forms,
  Vcl.Controls,
  View.Servidor,
  uControler.Cadastro.Inicial.Cidades,
  uControler.Cadastro.Inicial.Entidade,
  uControler.Cadastro.Inicial.Produtos,
  uControler.Cadastro.Inicial.UF,
  FireDAC.Comp.Client,
  System.SysUtils;

function EstabelecerConexao: Boolean;
var
  frm : TfrmAcessoServidor;
begin
  Result := False;
  dmDados := tdmDados.Create(nil);
  frm := TfrmAcessoServidor.Create(Application);
  try
    while not dmDados.con.Connected do
    begin
      if frm.ShowModal = mrCancel then
        Exit;

      dmDados.Senha := frm.edtSenha.Text;
      dmDados.Usuario := frm.edtUsuario.Text;
      dmDados.Servidor := frm.edtServidor.Text;
      dmDados.EstabelecerConexao;
      Result := dmDados.con.Connected;
    end;
  finally
    frm.Free;
  end;
end;

procedure CadastroEntidadesIniciais;
var
  entidade : TCadastroInicialEntidades;
begin
  entidade := TCadastroInicialEntidades.Create;
  try
    entidade.VerificarRegistros;
  finally
    entidade.Free;
  end;
end;

procedure CadastroProdutosIniciais;
var
  produtos : TCadastroInicialProdutos;
begin
  produtos := TCadastroInicialProdutos.Create;
  try
    produtos.VerificarRegistros;
  finally
    produtos.Free;
  end;
end;

procedure CadastroUFIniciais;
var
  uf : TCadastroInicialUF;
begin
  uf := TCadastroInicialUF.Create;
  try
    uf.VerificarRegistros;
  finally
    uf.Free;
  end;
end;

procedure CadastroCidadesIniciais;
var
  cidade : TCadastroInicialCidades;
begin
  cidade := TCadastroInicialCidades.Create;
  try
    cidade.VerificarRegistros;
  finally
    cidade.Free;
  end;
end;

procedure PrepararBanco;
begin
  dmDados.con.StartTransaction;
  try
    CadastroUFIniciais;
    CadastroCidadesIniciais;
    CadastroEntidadesIniciais;
    CadastroProdutosIniciais;
    dmDados.con.Commit;
  except on e:Exception do
    begin
      dmDados.con.Rollback;
      raise Exception.Create('Houve um problema ao realizar os cadastros iniciais.' + sLineBreak + 'Por favor Verifique!');
    end;
  end;
end;

end.
