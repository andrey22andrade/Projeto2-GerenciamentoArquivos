/*************************************************************
Autor: Andrey Andrade
Projeto: Projeto2 - Gerenciamento de Arquivos de Dados
Ação: Mover arquivo de LOG (.ldf) para nova localização
*************************************************************/

USE master;
GO

IF DB_ID('DB_Gerenciamento') IS NULL
BEGIN
    PRINT 'ERRO: Banco DB_Gerenciamento não encontrado. Execute 01_criacao_banco.sql primeiro.';
    RETURN;
END
GO

-- Verificar nomes lógicos e caminhos físicos atuais
SELECT name, physical_name 
FROM sys.master_files 
WHERE database_id = DB_ID('DB_Gerenciamento');
GO

-- 1) Colocar o banco em OFFLINE (com ROLLBACK IMMEDIATE)
ALTER DATABASE DB_Gerenciamento SET OFFLINE WITH ROLLBACK IMMEDIATE;
GO

-- 2) Indicar ao SQL Server a nova localização do arquivo de log
-- ATENÇÃO: ajuste a pasta destino antes de executar (ex: D:\MSSQL_Data\)
ALTER DATABASE DB_Gerenciamento MODIFY FILE ( NAME = 'DB_Gerenciamento_Log', FILENAME = 'D:\\MSSQL_Data\\DB_Gerenciamento_Log.ldf' );
GO

-- 3) Copiar/mover fisicamente o arquivo .ldf para o novo local usando o Windows Explorer
-- (Faça isso manualmente agora: copie o arquivo do caminho antigo para o novo caminho informado acima)

-- 4) Colocar o banco novamente ONLINE
ALTER DATABASE DB_Gerenciamento SET ONLINE;
GO

-- Observações:
-- • O serviço do SQL Server precisa ter permissão de leitura/escrita na pasta de destino.
-- • Se preferir mover o arquivo de dados (.mdf/.ndf), repita o fluxo alterando o NAME correspondente.
