-- Skapa en ny databas:
CREATE DATABASE FailSafeIT_Local;
GO
-- Använd den nya databasen:
USE FailSafeIT_Local;
GO

-- Skapa tabellen Users med kolumnerna 
--	Id (heltal som räknar upp sig själv automatiskt), 
--	Username (text med stöd för internationella tecken, max 50 tecken, får ej vara tom) och 
--	Role (text, max 20 tecken).
CREATE TABLE Users(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Username NVARCHAR(50),
	Role NVARCHAR(20)
);