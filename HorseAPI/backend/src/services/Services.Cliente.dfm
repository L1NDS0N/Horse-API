object ServiceCliente: TServiceCliente
  OldCreateOrder = False
  Height = 150
  Width = 322
  object Connection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Lindson Fran'#231'a\Desktop\HorseProjects\HorseAPI\' +
        'backend\database\database.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object qryCadastro: TFDQuery
    CachedUpdates = True
    Connection = Connection
    SQL.Strings = (
      'select c.id, c.nome, c.sobrenome, c.email'
      'from clientes c')
    Left = 200
    Top = 8
    object qryCadastroid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastronome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object qryCadastrosobrenome: TStringField
      FieldName = 'sobrenome'
      Origin = 'sobrenome'
      Size = 100
    end
    object qryCadastroemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 200
    end
  end
  object qryPesquisa: TFDQuery
    Connection = Connection
    SQL.Strings = (
      'select c.id, c.nome, c.sobrenome, c.email'
      'from clientes c')
    Left = 272
    Top = 8
    object qryPesquisaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPesquisanome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object qryPesquisasobrenome: TStringField
      FieldName = 'sobrenome'
      Origin = 'sobrenome'
      Size = 100
    end
    object qryPesquisaemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 200
    end
  end
end
