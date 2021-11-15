unit View.Servidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAcessoServidor = class(TForm)
    pnlBotoes: TPanel;
    pnlCampos: TPanel;
    btnCancelar: TButton;
    btnConfirmar: TButton;
    lbServidor: TLabel;
    edtServidor: TEdit;
    lbUsuario: TLabel;
    edtUsuario: TEdit;
    lbSenha: TLabel;
    edtSenha: TEdit;
    lbPorta: TLabel;
    edtPorta: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    procedure ValidarCampos;
    procedure ValidarServidor;
    procedure ValidarPorta;
    procedure ValidarUsuario;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAcessoServidor: TfrmAcessoServidor;

implementation

{$R *.dfm}

procedure TfrmAcessoServidor.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmAcessoServidor.btnConfirmarClick(Sender: TObject);
begin
  ValidarCampos;
  ModalResult := mrOk;
end;

procedure TfrmAcessoServidor.ValidarServidor;
begin
  if Trim(edtServidor.Text) = '' then
  begin
    edtServidor.SetFocus;
    raise Exception.Create('Servidor para conexão deve ser informado. Por favor Verifique!');
  end;
end;

procedure TfrmAcessoServidor.ValidarUsuario;
begin
  if Trim(edtUsuario.Text) = '' then
  begin
    edtUsuario.SetFocus;
    raise Exception.Create('Usuário para conexão deve ser informado. Por favor Verifique!');
  end;
end;

procedure TfrmAcessoServidor.ValidarPorta;
begin
  if Trim(edtPorta.Text) = '' then
  begin
    edtPorta.SetFocus;
    raise Exception.Create('Porta para conexão deve ser informada. Por favor Verifique!');
  end;
end;

procedure TfrmAcessoServidor.ValidarCampos;
begin
  ValidarServidor;
  ValidarUsuario;
  ValidarPorta;
end;

procedure TfrmAcessoServidor.FormShow(Sender: TObject);
begin
  edtPorta.Text := '3306';
  edtServidor.Text := 'LocalHost';
  edtUsuario.Text := 'root';
end;

end.
