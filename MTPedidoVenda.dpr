program MTPedidoVenda;

uses
  Vcl.Forms,
  View.PedidoVenda in 'View\View.PedidoVenda.pas' {frmPedidoVenda},
  uControler.Pedido in 'Controler\uControler.Pedido.pas',
  uControler.ProdutosPedidos in 'Controler\uControler.ProdutosPedidos.pas',
  uControler.Produtos in 'Controler\uControler.Produtos.pas',
  uControler.Entidade in 'Controler\uControler.Entidade.pas',
  uControler.Cidade in 'Controler\uControler.Cidade.pas',
  uControler.UF in 'Controler\uControler.UF.pas',
  uModel.DataModule in 'Model\uModel.DataModule.pas' {dmDados: TDataModule},
  uModel.Rotinas in 'Model\uModel.Rotinas.pas',
  View.Fundo in 'View\View.Fundo.pas' {frmFundo},
  View.Pesquisa in 'View\View.Pesquisa.pas' {frmPesquisa},
  View.Servidor in 'View\View.Servidor.pas' {frmAcessoServidor},
  uControler.Cadastro.Inicial.UF in 'Controler\uControler.Cadastro.Inicial.UF.pas',
  uControler.Cadastro.Inicial.Cidades in 'Controler\uControler.Cadastro.Inicial.Cidades.pas',
  uControler.Cadastro.Inicial.Entidade in 'Controler\uControler.Cadastro.Inicial.Entidade.pas',
  uControler.Cadastro.Inicial.Produtos in 'Controler\uControler.Cadastro.Inicial.Produtos.pas',
  uControler.Criar.MTBD in 'Controler\uControler.Criar.MTBD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.CreateForm(TfrmAcessoServidor, frmAcessoServidor);
  Application.Run;
end.
