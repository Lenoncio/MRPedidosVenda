object frmAcessoServidor: TfrmAcessoServidor
  Left = 0
  Top = 0
  Caption = 'Acesso Servidor'
  ClientHeight = 164
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 123
    Width = 312
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 354
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 234
      Top = 3
      Width = 75
      Height = 35
      Align = alRight
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
      ExplicitLeft = 276
    end
    object btnConfirmar: TButton
      AlignWithMargins = True
      Left = 153
      Top = 3
      Width = 75
      Height = 35
      Align = alRight
      Caption = '&Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
      ExplicitLeft = 195
    end
  end
  object pnlCampos: TPanel
    Left = 0
    Top = 0
    Width = 312
    Height = 123
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 354
    object lbServidor: TLabel
      Left = 14
      Top = 16
      Width = 40
      Height = 13
      Caption = 'Servidor'
    end
    object lbUsuario: TLabel
      Left = 18
      Top = 43
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
    end
    object lbSenha: TLabel
      Left = 24
      Top = 70
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object lbPorta: TLabel
      Left = 28
      Top = 97
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object edtServidor: TEdit
      Left = 60
      Top = 13
      Width = 238
      Height = 21
      TabOrder = 0
    end
    object edtUsuario: TEdit
      Left = 60
      Top = 40
      Width = 238
      Height = 21
      TabOrder = 1
    end
    object edtSenha: TEdit
      Left = 60
      Top = 67
      Width = 238
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
    object edtPorta: TEdit
      Left = 60
      Top = 94
      Width = 238
      Height = 21
      NumbersOnly = True
      TabOrder = 3
    end
  end
end
