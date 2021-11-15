object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  Caption = 'Pedidos de Venda'
  ClientHeight = 429
  ClientWidth = 853
  Color = clBtnFace
  Constraints.MinHeight = 468
  Constraints.MinWidth = 869
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 388
    Width = 853
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object lblValorTotal: TLabel
      Left = 16
      Top = 16
      Width = 71
      Height = 13
      Caption = 'Valor Total R$:'
    end
    object lblValorTotalPedido: TLabel
      Left = 93
      Top = 16
      Width = 22
      Height = 13
      Caption = '0,00'
    end
    object btnFechar: TButton
      AlignWithMargins = True
      Left = 753
      Top = 3
      Width = 97
      Height = 35
      Align = alRight
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
    object btnGravarPedido: TButton
      AlignWithMargins = True
      Left = 650
      Top = 3
      Width = 97
      Height = 35
      Align = alRight
      Caption = 'Gravar Pedido'
      TabOrder = 0
      OnClick = btnGravarPedidoClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 542
    Height = 388
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object grdItens: TDBGrid
      Left = 0
      Top = 0
      Width = 542
      Height = 388
      Align = alClient
      DataSource = dsItens
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = grdItensDrawColumnCell
      OnKeyDown = grdItensKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
          Title.Caption = 'C'#243'digo'
          Width = 37
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome'
          Title.Caption = 'Descri'#231#227'o'
          Width = 223
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qtde'
          Title.Caption = 'Quantidade'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrUnitario'
          Title.Caption = 'Vlr. Unit'#225'rio'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VlrTotal'
          Title.Caption = 'Vlr. Total'
          Width = 75
          Visible = True
        end>
    end
  end
  object pnlCampos: TPanel
    Left = 542
    Top = 0
    Width = 311
    Height = 388
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object lblEntidade: TLabel
      Left = 11
      Top = 96
      Width = 42
      Height = 13
      Caption = 'Entidade'
    end
    object lbProduto: TLabel
      Left = 11
      Top = 152
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object lbQuantidade: TLabel
      Left = 11
      Top = 208
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object lbValor: TLabel
      Left = 181
      Top = 208
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Panel3: TPanel
      Left = 0
      Top = 41
      Width = 311
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblNroPedidoCancelar: TLabel
        Left = 41
        Top = 13
        Width = 52
        Height = 13
        Caption = 'Nro Pedido'
      end
      object btnCancelar: TButton
        AlignWithMargins = True
        Left = 211
        Top = 3
        Width = 97
        Height = 35
        Align = alRight
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = btnCancelarClick
      end
      object edtNroPedidoCancelar: TEdit
        Left = 99
        Top = 10
        Width = 98
        Height = 21
        TabOrder = 0
      end
    end
    object edtCodEntidade: TEdit
      Left = 11
      Top = 115
      Width = 49
      Height = 21
      TabOrder = 2
      OnChange = edtCodEntidadeChange
      OnExit = edtCodEntidadeExit
    end
    object edtNomeEntidade: TButtonedEdit
      Left = 93
      Top = 115
      Width = 209
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      ReadOnly = True
      TabOrder = 3
    end
    object btnConsultaEntidade: TButton
      Left = 65
      Top = 113
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 4
      OnClick = btnConsultaEntidadeClick
    end
    object edtCodProduto: TEdit
      Left = 10
      Top = 171
      Width = 49
      Height = 21
      TabOrder = 5
      OnExit = edtCodProdutoExit
    end
    object btnConsultaProduto: TButton
      Left = 65
      Top = 169
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 6
      OnClick = btnConsultaProdutoClick
    end
    object edtNomeProduto: TButtonedEdit
      Left = 93
      Top = 171
      Width = 209
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      ReadOnly = True
      TabOrder = 7
    end
    object edtQuantidade: TMaskEdit
      Left = 11
      Top = 227
      Width = 120
      Height = 21
      TabOrder = 8
      Text = ''
    end
    object edtValor: TMaskEdit
      Left = 181
      Top = 227
      Width = 121
      Height = 21
      TabOrder = 9
      Text = ''
    end
    object btnAcionar: TButton
      AlignWithMargins = True
      Left = 211
      Top = 254
      Width = 97
      Height = 35
      Caption = 'Adicionar'
      TabOrder = 10
      OnClick = btnAcionarClick
    end
    object pnlCarregar: TPanel
      Left = 0
      Top = 0
      Width = 311
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblNroPedidoCarregar: TLabel
        Left = 41
        Top = 17
        Width = 52
        Height = 13
        Caption = 'Nro Pedido'
      end
      object btnCarregar: TButton
        AlignWithMargins = True
        Left = 211
        Top = 3
        Width = 97
        Height = 35
        Align = alRight
        Caption = 'Carregar'
        TabOrder = 1
        OnClick = btnCarregarClick
      end
      object edtNroPedidoCarregar: TEdit
        Left = 99
        Top = 14
        Width = 98
        Height = 21
        TabOrder = 0
      end
    end
    object btnCancelarProduto: TButton
      AlignWithMargins = True
      Left = 108
      Top = 254
      Width = 97
      Height = 35
      Caption = 'Cancelar'
      TabOrder = 11
      OnClick = btnCancelarProdutoClick
    end
  end
  object dsItens: TDataSource
    DataSet = qryItens
    Left = 80
    Top = 136
  end
  object qryItens: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 80
    Top = 192
    object intgrfldItensCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object strngfldItensNome: TStringField
      FieldName = 'Nome'
      Size = 150
    end
    object crncyfldItensQtde: TCurrencyField
      FieldName = 'Qtde'
      currency = False
    end
    object crncyfldItensVlrUnitario: TCurrencyField
      FieldName = 'VlrUnitario'
    end
    object crncyfldItensVlrTotal: TCurrencyField
      FieldName = 'VlrTotal'
    end
    object intgrfldItensID: TIntegerField
      FieldName = 'ID'
    end
  end
  object aplctnvnts1: TApplicationEvents
    OnModalBegin = aplctnvnts1ModalBegin
    OnModalEnd = aplctnvnts1ModalEnd
    Left = 416
    Top = 232
  end
  object fdcmnd1: TFDCommand
    Left = 416
    Top = 168
  end
end
