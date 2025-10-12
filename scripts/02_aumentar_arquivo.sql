/*************************************************************
Autor: Andrey Andrade
Projeto: Projeto2 - Gerenciamento de Arquivos de Dados
Ação: Aumentar o arquivo principal e adicionar um arquivo secundário (.ndf)
*************************************************************/

USE master;
GO

IF DB_ID('DB_Gerenciamento') IS NULL
BEGIN
    PRINT 'ERRO: Banco DB_Gerenciamento não encontrado. Execute 01_criacao_banco.sql primeiro.';
    RETURN;
END
GO

-- Aumentar tamanho do arquivo de dados principal (MDF)
ALTER DATABASE DB_Gerenciamento
MODIFY FILE ( NAME = 'DB_Gerenciamento_Data', SIZE = 100MB );
GO

-- Adicionar novo arquivo secundário (NDF)
ALTER DATABASE DB_Gerenciamento
ADD FILE (
    NAME = 'DB_Gerenciamento_File2',
    FILENAME = 'C:\\MSSQL_Data\\DB_Gerenciamento_File2.ndf',
    SIZE = 100MB,
    FILEGROWTH = 50MB
);
GO

-- Mostrar informações atualizadas
EXEC sp_helpdb 'DB_Gerenciamento';
GO

-- Observação: verifique permissões de pasta e ajuste caminhos conforme seu ambiente.
