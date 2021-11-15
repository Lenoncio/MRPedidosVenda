unit uControler.Unidade;

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
  FireDAC.Comp.Client;

type

  TUnidade = class
  private
    FCodigo: Integer;
    FNome: String;
    FSigla: String;
    procedure Inserir;
    procedure Alterar;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Sigla: String read FSigla write FSigla;

    destructor Destroy; override;
    constructor Create;

    procedure Carregar;
    procedure Clear;
    procedure Salvar;
    procedure Deletar;

    function Listar: TFDMemTable;
  end;

implementation

{ TUnidade }

procedure TUnidade.Alterar;
begin

end;

procedure TUnidade.Carregar;
begin

end;

procedure TUnidade.Clear;
begin

end;

constructor TUnidade.Create;
begin

end;

procedure TUnidade.Deletar;
begin

end;

destructor TUnidade.Destroy;
begin

  inherited;
end;

procedure TUnidade.Inserir;
begin

end;

function TUnidade.Listar: TFDMemTable;
begin

end;

procedure TUnidade.Salvar;
begin

end;

end.
