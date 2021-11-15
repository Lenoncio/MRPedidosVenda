unit View.Pesquisa;

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
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Data.DB,
  FireDAC.Comp.Client;

type
  TfrmPesquisa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    btnFechar: TButton;
    btnConfirmar: TButton;
    dsItens: TDataSource;
    Label1: TLabel;
    edtFiltro: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtFiltroChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FLabel : String;
    FNome : String;
    FDataType : TFieldType;
    FQryRegistros: TFDMemTable;

    procedure RealizarFiltro;
    procedure DefinirColunas;
    { Private declarations }
  public
    property QryRegistros: TFDMemTable read FQryRegistros write FQryRegistros;
    { Public declarations }
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

procedure TfrmPesquisa.btnFecharClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmPesquisa.btnConfirmarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmPesquisa.DBGrid1DblClick(Sender: TObject);
begin
  btnConfirmarClick(btnConfirmar);
end;

procedure TfrmPesquisa.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TfrmPesquisa.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnConfirmarClick(btnConfirmar);
end;

procedure TfrmPesquisa.DBGrid1TitleClick(Column: TColumn);
begin
  FLabel := Column.Field.DisplayLabel;
  FNome := Column.Field.DisplayName;
  FDataType := Column.Field.DataType;
  edtFiltro.NumbersOnly := FDataType in [ftInteger, ftCurrency];
  edtFiltro.Clear;
end;

procedure TfrmPesquisa.edtFiltroChange(Sender: TObject);
begin
  RealizarFiltro;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  FQryRegistros.First;
  dsItens.DataSet := FQryRegistros;
  DBGrid1TitleClick(DBGrid1.Columns[0]);
  DefinirColunas;
end;

procedure TfrmPesquisa.DefinirColunas;
var
  i : Integer;
begin
  for i := 0 to Pred(DBGrid1.FieldCount) do
  begin
    case DBGrid1.Columns[i].Field.DataType of
      ftInteger : DBGrid1.Columns[i].Width := 48;
      ftString : DBGrid1.Columns[i].Width := 150;
      ftCurrency : DBGrid1.Columns[i].Width := 75
    end;
  end;
end;

procedure TfrmPesquisa.RealizarFiltro;
begin
  FQryRegistros.DisableControls;
  try
    FQryRegistros.Filtered := False;
    if Trim(edtFiltro.text) = '' then
      Exit;
    case FDataType  of
      ftInteger : FQryRegistros.Filter := FNome + ' = ' + edtFiltro.text;
      ftCurrency : FQryRegistros.Filter := FNome + ' = ' + edtFiltro.text;
    else
      FQryRegistros.Filter := FNome + ' LIKE ''%'+edtFiltro.text+'%'' ';
    end;
    FQryRegistros.Filtered := True;
  finally
    FQryRegistros.EnableControls;
  end;
end;

end.
