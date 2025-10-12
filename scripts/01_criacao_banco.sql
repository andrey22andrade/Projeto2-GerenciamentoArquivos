/*************************************************************
Autor: Andrey Andrade
Projeto: Projeto2 - Gerenciamento de Arquivos de Dados
Ação: Criação do banco DB_Gerenciamento com parâmetros personalizados
*************************************************************/

USE master;
GO

-- ATENÇÃO: Este script reinicia o ambiente para o exercício.
IF DB_ID('DB_Gerenciamento') IS NOT NULL
BEGIN
    PRINT 'Banco DB_Gerenciamento existe. Removendo para recriar (DROP).';
    DROP DATABASE DB_Gerenciamento;
END
GO

CREATE DATABASE DB_Gerenciamento
ON 
( NAME = 'DB_Gerenciamento_Data',
  FILENAME = 'C:\\MSSQL_Data\\DB_Gerenciamento_Data.mdf',
  SIZE = 20MB,
  MAXSIZE = 500MB,
  FILEGROWTH = 10MB )
LOG ON
( NAME = 'DB_Gerenciamento_Log',
  FILENAME = 'C:\\MSSQL_Data\\DB_Gerenciamento_Log.ldf',
  SIZE = 10MB,
  MAXSIZE = 200MB,
  FILEGROWTH = 10MB )
COLLATE Latin1_General_CI_AS;
GO

-- Exibe informações do banco
EXEC sp_helpdb 'DB_Gerenciamento';
GO

-- Observação: ajuste os caminhos (FILENAME) se seu SQL Server usa outro diretório de dados.
