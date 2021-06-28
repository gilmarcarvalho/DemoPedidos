object fConfig: TfConfig
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es'
  ClientHeight = 531
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    0000010018000000000040030000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00008F918D787F7D000000000000000000000000000000000000000000000000
    B4A99DA69A8BA4968700000000000085857E5DADDD5EBDFA6F82870000000000
    00000000000000000000000000000000A49788FFFFFFA89C8D000000817E765D
    ACDB5EBFFD5B9CC25EBDFA818F94000000000000998979BFB6AAA596899F9181
    B3A89B9C9F9C6F81886A848F5DA9D95EBEFC5B9FC75EBFFD5DABD99195910000
    00000000B5AA9CFFFFFFE8E4E0F7F6F47F85845CAFE2677A8162A2C55EBFFD5B
    9EC65EBFFD5DABD985857E000000000000000000A7988BEDEBE8FFFFFFBCB9B4
    609FC56A7B7FC1BCB598948D62A1C65EBFFD5DA9D983837B0000000000000000
    000000009B8B7CFEFDFDE9E7E5969894656C6A8A7A69CFCAC4DAD7D397928962
    A1C6687D85000000000000000000917F6EA8998CD3CDC5FDFDFDDBD8D4988F84
    AEA598EDEAE79D8F7FD7D3CFC4BEB86A7C806B797BAA9D8F000000000000A798
    8BFFFFFFFFFFFFF4F3F2DAD7D3A09283FFFFFFFFFFFFEDEAE79E91846B7D815D
    B1E6949490FFFFFFA193840000009D8D7EA19384CCC5BCF8F7F7DAD7D3B2A89C
    D9D4CEFFFFFFAEA598656C69609FC37B7F79D8D2CCC1B6AD9585730000000000
    00000000907F6EFFFFFFE2E0DCD9D6D2B4AA9F9C8E7E93897C8C8880B8B5AFF6
    F5F39786760000000000000000000000000000008E7C69FCFCFBFAFAF9E1DFDC
    DAD7D3DAD7D3DBD8D4E9E7E5FFFFFFC4BBB10000000000000000000000000000
    00A39586E1DCD8FFFFFFECE9E6FEFEFEF7F7F6F4F3F2FDFDFDFFFFFFFEFEFEFC
    FCFB9C8D7C000000000000000000000000000000A19384A89A8BAA9D8F978777
    EBE7E4FFFFFFB6AB9F958573988776ECE9E69583730000000000000000000000
    00000000000000000000000000000000C6BCB3FFFFFFA3958600000000000099
    8B79000000000000000000000000000000000000000000000000000000000000
    84725EA19382000000000000000000000000000000000000000000000000FFF3
    0000FC610000FC400000C0000000C0010000C0030000C0070000000300000001
    000000010000C0070000C00F000080070000C0070000FC6F0000FCFF0000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 20
    Top = 20
    Width = 140
    Height = 19
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Nome Empresa:'
  end
  object Label1: TLabel
    Left = 20
    Top = 48
    Width = 281
    Height = 19
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Tempo m'#225'ximo para evento ser considerado duplicado:'
  end
  object Label5: TLabel
    Left = 371
    Top = 48
    Width = 61
    Height = 19
    AutoSize = False
    Caption = 'Segundos'
  end
  object btnCancelar: TButton
    Left = 596
    Top = 498
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object btnFechar: TButton
    Left = 677
    Top = 498
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 4
    OnClick = btnFecharClick
  end
  object btnSalvar: TButton
    Left = 515
    Top = 498
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object DBEdit2: TDBEdit
    Left = 164
    Top = 16
    Width = 321
    Height = 21
    DataField = 'Nome_Empresa'
    DataSource = dsMaster
    TabOrder = 0
  end
  object DBEdit1: TDBEdit
    Left = 308
    Top = 44
    Width = 58
    Height = 21
    AutoSize = False
    DataField = 'Tempo_registro_duplicado'
    DataSource = dsMaster
    TabOrder = 1
  end
  object DBCheckBox1: TDBCheckBox
    Left = 20
    Top = 81
    Width = 353
    Height = 17
    Caption = 'Considerar evento de dia anterior como continua'#231#227'o'
    DataField = 'Considera_dia_anterior'
    DataSource = dsMaster
    TabOrder = 2
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object DBCheckBox2: TDBCheckBox
    Left = 20
    Top = 104
    Width = 353
    Height = 17
    Caption = 'Registrar evento duplicado'
    DataField = 'Registra_registro_duplicado'
    DataSource = dsMaster
    TabOrder = 6
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  object qryMaster: TFDQuery
    AfterOpen = qryMasterAfterOpen
    BeforePost = qryMasterBeforePost
    CachedUpdates = True
    Connection = dm1.db1
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      'SELECT'
      'configuracoes.ID,'
      'configuracoes.Tempo_registro_duplicado,'
      'configuracoes.Registra_registro_duplicado,'
      'configuracoes.Considera_dia_anterior,'
      'configuracoes.Nome_Empresa'
      'FROM'
      'configuracoes')
    Left = 158
    Top = 120
    object qryMasterID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryMasterTempo_registro_duplicado: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'Tempo_registro_duplicado'
      Origin = 'Tempo_registro_duplicado'
    end
    object qryMasterRegistra_registro_duplicado: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'Registra_registro_duplicado'
      Origin = 'Registra_registro_duplicado'
      FixedChar = True
      Size = 1
    end
    object qryMasterConsidera_dia_anterior: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'Considera_dia_anterior'
      Origin = 'Considera_dia_anterior'
      FixedChar = True
      Size = 1
    end
    object qryMasterNome_Empresa: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'Nome_Empresa'
      Origin = 'Nome_Empresa'
      Size = 255
    end
  end
  object dsMaster: TDataSource
    DataSet = qryMaster
    OnStateChange = dsMasterStateChange
    Left = 210
    Top = 160
  end
  object dsHorarios: TDataSource
    DataSet = qryHorarios
    OnStateChange = dsHorariosStateChange
    Left = 632
    Top = 136
  end
  object qryHorarios: TFDQuery
    BeforeEdit = qryHorariosBeforeEdit
    AfterScroll = qryHorariosAfterScroll
    OnNewRecord = qryHorariosNewRecord
    CachedUpdates = True
    OnReconcileError = qryHorariosReconcileError
    Connection = dm1.db1
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    SQL.Strings = (
      'SELECT'
      'configuracoeshorarios.ID,'
      'configuracoeshorarios.IDConfiguracao,'
      'configuracoeshorarios.Dia,'
      'configuracoeshorarios.HrSaida,'
      'configuracoeshorarios.HrEntrada,'
      'configuracoeshorarios.Intervalo,'
      'configuracoeshorarios.HrIntervInicio,'
      'configuracoeshorarios.HrIntervTermino,'
      'configuracoeshorarios.CargaHoraria'
      'FROM configuracoeshorarios'
      'where '
      'configuracoeshorarios.IDConfiguracao=:IDConfiguracao')
    Left = 632
    Top = 84
    ParamData = <
      item
        Name = 'IDCONFIGURACAO'
        DataType = ftLargeint
        ParamType = ptInput
        Value = 0
      end>
    object qryHorariosID: TLargeintField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryHorariosDia: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'Dia'
      Origin = 'Dia'
    end
    object qryHorariosHrSaida: TTimeField
      AutoGenerateValue = arDefault
      FieldName = 'HrSaida'
      Origin = 'HrSaida'
      DisplayFormat = 'hh:mm'
    end
    object qryHorariosHrEntrada: TTimeField
      AutoGenerateValue = arDefault
      FieldName = 'HrEntrada'
      Origin = 'HrEntrada'
      DisplayFormat = 'hh:mm'
    end
    object qryHorariosHrIntervInicio: TTimeField
      AutoGenerateValue = arDefault
      FieldName = 'HrIntervInicio'
      Origin = 'HrIntervInicio'
      DisplayFormat = 'hh:mm'
    end
    object qryHorariosHrIntervTermino: TTimeField
      AutoGenerateValue = arDefault
      FieldName = 'HrIntervTermino'
      Origin = 'HrIntervTermino'
      DisplayFormat = 'hh:mm'
    end
    object qryHorariosCargaHoraria: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'CargaHoraria'
      Origin = 'CargaHoraria'
      DisplayFormat = '#,##0.0#'
      Precision = 18
      Size = 3
    end
    object qryHorariosIntervalo: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'Intervalo'
      Origin = 'Intervalo'
      OnChange = qryHorariosIntervaloChange
      FixedChar = True
      Size = 1
    end
    object qryHorariosIDConfiguracao: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'IDConfiguracao'
      Origin = 'IDConfiguracao'
    end
  end
end
