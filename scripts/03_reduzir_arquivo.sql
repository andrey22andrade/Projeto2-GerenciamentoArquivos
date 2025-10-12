/*************************************************************
Autor: Andrey Andrade
Projeto: Projeto2 - Gerenciamento de Arquivos de Dados
Ação: Popular base para teste e realizar shrink (DBCC SHRINK)
*************************************************************/

-- Este script pode gerar alto volume de dados. Execute com cuidado.
USE master;
GO

IF DB_ID('DB_Gerenciamento') IS NULL
BEGIN
    PRINT 'ERRO: Banco DB_Gerenciamento não encontrado. Execute 01_criacao_banco.sql primeiro.';
    RETURN;
END
GO

USE DB_Gerenciamento;
GO

-- Criar tabela de teste (se não existir)
IF OBJECT_ID('dbo.tb_Teste', 'U') IS NOT NULL
    DROP TABLE dbo.tb_Teste;
GO

CREATE TABLE dbo.tb_Teste(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ColunaGrande NCHAR(2000),
    ColunaBigint BIGINT
);
GO

SET NOCOUNT ON;
GO

-- Inserir 100.000 linhas (pode demorar)
INSERT INTO dbo.tb_Teste (ColunaGrande, ColunaBigint)
VALUES (REPLICATE(N'A', 2000), 123456789);
GO 100000
-- Ajuste o número de repetições se desejar (<100000 para execução mais rápida)

-- Verificar uso de espaço
SELECT 
    name AS Arquivo,
    size * 8 / 1024. AS Tamanho_MB,  
    FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024. AS Espaco_Utilizado_MB,
    CAST(FILEPROPERTY(name, 'SpaceUsed') AS DECIMAL(10,4)) / CAST(size AS DECIMAL(10,4)) * 100 AS Percentual_Utilizado
FROM sys.database_files;
GO

-- Reduz o banco deixando 10% livre
DBCC SHRINKDATABASE('DB_Gerenciamento', 10);
GO

-- (Opcional) Reduz arquivo específico para tamanho aproximado (em MB)
-- DBCC SHRINKFILE (N'DB_Gerenciamento_Data', 100);
-- GO

-- Observação: shrink pode causar fragmentação; use com critério em produção.
