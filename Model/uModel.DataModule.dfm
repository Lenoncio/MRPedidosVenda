object dmDados: TdmDados
  OldCreateOrder = False
  Height = 150
  Width = 215
  object con: TFDConnection
    Params.Strings = (
      'Database=MTBD'
      'User_Name=root'
      'Password=Tic7@@212'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object fdphysmysqldrvrlnk1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Windows\System\libmysql.dll'
    Left = 136
    Top = 8
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 64
  end
end
