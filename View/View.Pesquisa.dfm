object frmPesquisa: TfrmPesquisa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'frmPesquisa'
  ClientHeight = 335
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 448
    Height = 45
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 2
      Width = 442
      Height = 13
      Align = alBottom
      Caption = 'Pesquisa por:'
      ExplicitWidth = 65
    end
    object edtFiltro: TEdit
      AlignWithMargins = True
      Left = 3
      Top = 21
      Width = 442
      Height = 21
      Align = alBottom
      TabOrder = 0
      OnChange = edtFiltroChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 294
    Width = 448
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnFechar: TButton
      AlignWithMargins = True
      Left = 370
      Top = 3
      Width = 75
      Height = 35
      Align = alRight
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object btnConfirmar: TButton
      AlignWithMargins = True
      Left = 289
      Top = 3
      Width = 75
      Height = 35
      Align = alRight
      Caption = '&Confirmar'
      TabOrder = 1
      OnClick = btnConfirmarClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 45
    Width = 448
    Height = 249
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 448
      Height = 249
      Align = alClient
      DataSource = dsItens
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
      OnTitleClick = DBGrid1TitleClick
    end
  end
  object dsItens: TDataSource
    Left = 176
    Top = 89
  end
end
