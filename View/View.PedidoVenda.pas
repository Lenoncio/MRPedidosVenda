unit View.PedidoVenda;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Mask,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.AppEvnts,
  View.Fundo,
  uControler.Produtos,
  FireDAC.Stan.Async;

type
  TfrmPedidoVenda = class(TForm)
    pnlBotoes: TPanel;
    Panel1: TPanel;
    pnlCampos: TPanel;
    lblEntidade: TLabel;
    btnFechar: TButton;
    grdItens: TDBGrid;
    lbProduto: TLabel;
    lbQuantidade: TLabel;
    lbValor: TLabel;
    dsItens: TDataSource;
    Panel3: TPanel;
    btnCancelar: TButton;
    edtCodEntidade: TEdit;
    edtNomeEntidade: TButtonedEdit;
    btnConsultaEntidade: TButton;
    qryItens: TFDMemTable;
    intgrfldItensCodigo: TIntegerField;
    strngfldItensNome: TStringField;
    crncyfldItensQtde: TCurrencyField;
    crncyfldItensVlrUnitario: TCurrencyField;
    crncyfldItensVlrTotal: TCurrencyField;
    edtCodProduto: TEdit;
    btnConsultaProduto: TButton;
    edtNomeProduto: TButtonedEdit;
    edtQuantidade: TMaskEdit;
    edtValor: TMaskEdit;
    btnAcionar: TButton;
    lblValorTotal: TLabel;
    lblValorTotalPedido: TLabel;
    btnGravarPedido: TButton;
    pnlCarregar: TPanel;
    btnCarregar: TButton;
    edtNroPedidoCarregar: TEdit;
    edtNroPedidoCancelar: TEdit;
    lblNroPedidoCarregar: TLabel;
    lblNroPedidoCancelar: TLabel;
    aplctnvnts1: TApplicationEvents;
    btnCancelarProduto: TButton;
    intgrfldItensID: TIntegerField;
    fdcmnd1: TFDCommand;
    procedure btnFecharClick(Sender: TObject);
    procedure btnAcionarClick(Sender: TObject);
    procedure grdItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodEntidadeChange(Sender: TObject);
    procedure edtCodEntidadeExit(Sender: TObject);
    procedure aplctnvnts1ModalBegin(Sender: TObject);
    procedure aplctnvnts1ModalEnd(Sender: TObject);
    procedure btnConsultaEntidadeClick(Sender: TObject);
    procedure btnConsultaProdutoClick(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCancelarProdutoClick(Sender: TObject);
  private
    FValorTotal : Currency;
    FFrmFundo : TfrmFundo;
    FIDItemCarregado : Integer;
    procedure DeletarRegistro;
    procedure ValidarCarregarCancelar;
    procedure LimparCancelar;
    procedure LimparCarregar;
    procedure LimparEntidade;
    procedure LimparProdutos;
    procedure CarregarPeido;
    procedure DeletarPeido;
    procedure SalvarPeido;
    procedure CarregarValorTotalPedido;
    procedure CarregarPedido;
    procedure CarregarProdutoQuery;
    procedure ValidarDadosProduto;
    procedure LimparTela;
    procedure RecarregarProduto;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

uses
  uControler.Pedido,
  uControler.Entidade,
  uModel.Rotinas;

{$R *.dfm}

procedure TfrmPedidoVenda.btnCancelarClick(Sender: TObject);
begin 
  Screen.Cursor := crHourGlass;
  try
    DeletarPeido;
    edtNroPedidoCancelar.Clear;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPedidoVenda.btnCarregarClick(Sender: TObject);
begin              
  Screen.Cursor := crHourGlass;
  try        
    CarregarPedido;
    CarregarValorTotalPedido;
    edtNroPedidoCarregar.Clear;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPedidoVenda.btnConsultaEntidadeClick(Sender: TObject);
var
  entidade : TEntidade;
begin
  entidade := TEntidade.Create;
  try
    entidade.Consultar;
    if entidade.Codigo > 0 then
    begin
      edtCodEntidade.OnExit := nil;
      edtCodEntidade.Text := entidade.Codigo.ToString;
      edtNomeEntidade.Text := entidade.Nome;
      edtCodEntidade.OnExit := edtCodEntidadeExit;
    end;
  finally
    entidade.Free;
  end;
end;

procedure TfrmPedidoVenda.btnConsultaProdutoClick(Sender: TObject);
var
  produtos : TProdutos;
begin
  produtos := TProdutos.Create;
  try
    produtos.Consultar;
    if produtos.Codigo > 0 then
    begin
      edtCodProduto.OnExit := nil;
      edtCodProduto.Text := produtos.Codigo.ToString;
      edtNomeProduto.Text := produtos.Nome;
      edtCodProduto.OnExit := edtCodProdutoExit;
    end;
  finally
    produtos.Free;
  end;
end;

procedure TfrmPedidoVenda.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    if StrToIntDef(edtCodEntidade.Text,0) = 0 then
      raise Exception.Create('Entidade não foi informada. Por favor Verifique!');
    if qryItens.RecordCount = 0 then
      raise Exception.Create('Nenhum produto adicionado ao pedido. Por favor Verifique!');

    qryItens.DisableControls;
    qryItens.First;
    SalvarPeido;
    LimparTela;
    Application.MessageBox('Pedido salvo com sucesso!', PChar(Application.Title), MB_ICONINFORMATION+MB_OK);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPedidoVenda.btnCancelarProdutoClick(Sender: TObject);
begin
  LimparProdutos;
end;

procedure TfrmPedidoVenda.LimparTela;
begin
  LimparEntidade;
  LimparProdutos;
  LimparCarregar;
  LimparCancelar;
  FValorTotal := 0;
  CarregarValorTotalPedido;
  qryItens.Close;
  qryItens.Open;
  qryItens.EnableControls;
end;

procedure TfrmPedidoVenda.SalvarPeido;
var
  pedido : TPedido;
begin
  pedido := TPedido.Create;
  try
    pedido.Entidades.Codigo := StrToIntDef(edtCodEntidade.Text, 0);
    pedido.Entidades.Carregar;
    pedido.VlrTotal := FValorTotal;
    while not qryItens.eof do
    begin
      with pedido.Produtos.Add do
      begin
        Produto.Codigo := qryItens.FieldByName('Codigo').AsInteger;
        Produto.Carregar;
        VlrTotal := qryItens.FieldByName('VlrTotal').asCurrency;
        Qtde := qryItens.FieldByName('Qtde').asCurrency;
        VlrUnitario := qryItens.FieldByName('VlrUnitario').asCurrency;
      end;
      qryItens.Next;
    end;
    pedido.Salvar;
  finally
    pedido.Free;
  end;
end;

procedure TfrmPedidoVenda.CarregarPeido;
var
  pedido : TPedido;
begin 
  pedido := TPedido.Create;
  try
    pedido.Codigo := StrToIntDef(edtNroPedidoCancelar.Text,0);
    pedido.Carregar;
  finally
    pedido.Free;
  end;
end;

procedure TfrmPedidoVenda.DeletarPeido;
var
  pedido : TPedido;
begin
  pedido := TPedido.Create;
  try
    pedido.Codigo := StrToIntDef(edtNroPedidoCancelar.Text,0);
    pedido.Carregar;
    if pedido.Codigo = 0 then
      raise Exception.Create('Pedido não foi localizado. Por favor Verifique!');
    pedido.Deletar;
  finally
    pedido.Free;
  end;
end;

procedure TfrmPedidoVenda.grdItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check: Integer;
  R    : TRect;
begin
  if odd((Sender as TDBGrid).DataSource.DataSet.recno) then
    TDBGrid(Sender).Canvas.Brush.Color := $00FBECD9
  else
    TDBGrid(Sender).Canvas.Brush.Color := clWhite;

  TDBGrid(Sender).Canvas.font.Color := clBlack;
  if gdSelected in State then
  begin
    (Sender as TDBGrid).Canvas.Brush.Color := $00C1E1C1;
    (Sender as TDBGrid).Canvas.FillRect(Rect);
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[DataCol].Field, State);
end;

procedure TfrmPedidoVenda.grdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if qryItens.RecordCount = 0 then
    Exit;
  case Key of
    VK_DELETE : DeletarRegistro;
    VK_RETURN : RecarregarProduto;
  end;
end;

procedure TfrmPedidoVenda.RecarregarProduto;
begin
  FIDItemCarregado := qryItens.FieldByName('ID').AsInteger;
  edtCodProduto.Text := qryItens.FieldByName('Codigo').asString;
  edtCodProduto.ReadOnly := True;
  btnConsultaProduto.Enabled := False;
  edtCodProdutoExit(edtCodProduto);
  edtQuantidade.Text := FormatCurr('#,##0.00', qryItens.FieldByName('Qtde').asCurrency);
  edtValor.Text := FormatCurr('#,##0.00', qryItens.FieldByName('VlrUnitario').asCurrency);
end;

procedure TfrmPedidoVenda.aplctnvnts1ModalBegin(Sender: TObject);
begin
  FFrmFundo := TfrmFundo.Create(Self);
  FFrmFundo.Parent := Self;
  FFrmFundo.Show;
end;

procedure TfrmPedidoVenda.aplctnvnts1ModalEnd(Sender: TObject);
begin
  FFrmFundo.Free;
end;

procedure TfrmPedidoVenda.btnAcionarClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    ValidarDadosProduto;
    CarregarProdutoQuery;
    LimparProdutos;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPedidoVenda.DeletarRegistro;
begin
  if Application.MessageBox('Deseja realmente deletar o registro selecionado?', PChar(Application.Title), MB_YESNO+MB_ICONQUESTION) = ID_NO then
    Exit;
  Screen.Cursor := crHourGlass;
  try
    FValorTotal := FValorTotal - qryItens.FieldByName('VlrTotal').AsCurrency;
    CarregarValorTotalPedido;
    qryItens.Delete;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPedidoVenda.ValidarCarregarCancelar;
begin
  btnCancelar.Visible := StrToIntDef(edtCodEntidade.Text, 0) = 0;
  btnCarregar.Visible := StrToIntDef(edtCodEntidade.Text, 0) = 0;
  edtNroPedidoCarregar.ReadOnly := StrToIntDef(edtCodEntidade.Text, 0) > 0;
  edtNroPedidoCancelar.ReadOnly := StrToIntDef(edtCodEntidade.Text, 0) > 0;
  if StrToIntDef(edtCodEntidade.Text, 0) > 0 then
  begin
    edtNroPedidoCarregar.Clear;
    edtNroPedidoCancelar.Clear;
  end;
end;

procedure TfrmPedidoVenda.edtCodEntidadeChange(Sender: TObject);
begin
  ValidarCarregarCancelar;
end;

procedure TfrmPedidoVenda.edtCodEntidadeExit(Sender: TObject);
var
  entidade : TEntidade;
begin
  entidade := TEntidade.Create;
  try
    if StrToIntDef(edtCodEntidade.Text, 0) = 0 then
    begin
      edtNomeEntidade.Clear;
      Exit;
    end;
    entidade.Codigo := StrToIntDef(edtCodEntidade.Text, 0);
    entidade.Carregar;
    if entidade.Codigo = 0 then
      LimparEntidade
    else
      edtNomeEntidade.Text := entidade.Nome;
  finally
    entidade.Free;
    ValidarCarregarCancelar;
  end;
end;

procedure TfrmPedidoVenda.edtCodProdutoExit(Sender: TObject);
var
  produtos : TProdutos;
begin
  produtos := TProdutos.Create;
  try
    if StrToIntDef(edtCodProduto.Text,0) = 0 then
    begin
      LimparProdutos;
      Exit;
    end;
    produtos.Codigo := StrToIntDef(edtCodProduto.Text,0);
    produtos.Carregar;
    if produtos.Codigo = 0 then
      LimparProdutos
    else
    begin
      edtCodProduto.Text := produtos.Codigo.ToString;
      edtNomeProduto.Text := produtos.Nome;
    end;
  finally
    produtos.Free;
  end;
end;

procedure TfrmPedidoVenda.FormShow(Sender: TObject);
begin
  if not EstabelecerConexao then
    Close;
  PrepararBanco;
  qryItens.Close;
  qryItens.Open;
end;

procedure TfrmPedidoVenda.LimparEntidade;
begin
  edtCodEntidade.Clear;
  edtNomeEntidade.Clear;
end;

procedure TfrmPedidoVenda.LimparProdutos;
begin
  edtCodProduto.Clear;
  edtNomeProduto.Clear;
  edtQuantidade.Clear;
  edtValor.Clear;
  FIDItemCarregado := 0;
end;

procedure TfrmPedidoVenda.LimparCarregar;
begin
  edtNroPedidoCarregar.Clear;
  btnCarregar.Visible := True;
end;

procedure TfrmPedidoVenda.LimparCancelar;
begin     
  edtNroPedidoCancelar.Clear;
  btnCancelar.Visible := True;
end;

procedure TfrmPedidoVenda.CarregarValorTotalPedido;
begin
  lblValorTotalPedido.Caption := FormatCurr('#,##0.00', FValorTotal);
end;

procedure TfrmPedidoVenda.CarregarPedido;
var
  pedido : TPedido;
  i : Integer;
begin
  pedido := TPedido.Create;
  try
    pedido.Codigo := StrToIntDef(edtNroPedidoCarregar.Text,0);
    pedido.Carregar;
    if pedido.Codigo = 0 then
      raise Exception.Create('Pedido não foi localizado. Por favor Verifique!');
    edtCodEntidade.Text := pedido.Entidades.Codigo.ToString;
    edtNomeEntidade.Text := pedido.Entidades.Nome;
    qryItens.Close;
    qryItens.Open;
    for i := 0 to Pred(pedido.Produtos.Count) do
    begin
      qryItens.Append;
      qryItens.FieldByName('ID').AsInteger := qryItens.RecordCount;
      qryItens.FieldByName('Codigo').AsInteger := pedido.Produtos.Items[i].Produto.Codigo;
      qryItens.FieldByName('Nome').AsString := pedido.Produtos.Items[i].Produto.Nome;
      qryItens.FieldByName('Qtde').AsCurrency := pedido.Produtos.Items[i].Qtde;
      qryItens.FieldByName('VlrUnitario').AsCurrency := pedido.Produtos.Items[i].VlrUnitario;
      qryItens.FieldByName('VlrTotal').AsCurrency := pedido.Produtos.Items[i].VlrTotal;
      qryItens.Post;
      FValorTotal := FValorTotal + qryItens.FieldByName('VlrTotal').AsCurrency
    end;
  finally
    pedido.Free;
  end;
end;

procedure TfrmPedidoVenda.ValidarDadosProduto;
begin
  if StrToIntDef(edtCodProduto.Text, 0) = 0 then
  begin
    edtCodProduto.Clear;
    raise Exception.Create('Código do produto não foi informado.' + sLineBreak + 'Por favor Verifique');
  end;
  if StrToFloatDef(edtQuantidade.Text, 0) = 0 then
  begin
    edtQuantidade.Clear;
    raise Exception.Create('Quantidade do produto não foi informado.' + sLineBreak + 'Por favor Verifique');
  end;
  if StrToFloatDef(edtValor.Text, 0) = 0 then
  begin
    edtValor.Clear;
    raise Exception.Create('Valor do produto não foi informado.' + sLineBreak + 'Por favor Verifique');
  end;
end;

procedure TfrmPedidoVenda.CarregarProdutoQuery;
begin
  qryItens.DisableControls;
  try
    if FIDItemCarregado = 0 then
    begin
      qryItens.Append;
      qryItens.FieldByName('ID').AsInteger := qryItens.RecordCount;
    end
    else
    begin
      qryItens.Filtered := False;
      qryItens.Filter := 'ID = ' + FIDItemCarregado.ToString;
      qryItens.Filtered := True;
      qryItens.Edit;
      FValorTotal := FValorTotal - qryItens.FieldByName('VlrTotal').AsCurrency;
    end;
    qryItens.FieldByName('Codigo').asInteger := StrToIntDef(edtCodProduto.Text, 0);
    qryItens.FieldByName('Nome').AsString := edtNomeProduto.Text;
    qryItens.FieldByName('Qtde').AsCurrency := StrToCurrDef(edtQuantidade.Text,0);
    qryItens.FieldByName('VlrUnitario').AsCurrency := StrToCurrDef(edtValor.Text,0);
    qryItens.FieldByName('VlrTotal').AsCurrency := qryItens.FieldByName('Qtde').AsCurrency * qryItens.FieldByName('VlrUnitario').AsCurrency;
    qryItens.Post;
  finally
    FValorTotal := FValorTotal + qryItens.FieldByName('VlrTotal').AsCurrency;
    CarregarValorTotalPedido;
    qryItens.Filtered := False;
    qryItens.EnableControls;
    edtCodProduto.ReadOnly := False;
    btnConsultaProduto.Enabled := True;
  end;
end;

end.
