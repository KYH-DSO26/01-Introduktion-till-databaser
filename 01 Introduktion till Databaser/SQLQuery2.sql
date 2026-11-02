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
GO

--Uppgift 6
--Skapa tabellen Servers med kolumnerna 
--Id (självuppräknande heltal), 
--ServerName (text, max 100 tecken, får ej vara tom), 
--IpAddress (ren textsträng för IPv4, max 15 tecken) och 
--Environment (text, max 20 tecken).
create table Servers(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	ServerName nvarchar(100) not null,
	IpAddress varchar(15) not null,
	Environment nvarchar(20) not null
);
go
