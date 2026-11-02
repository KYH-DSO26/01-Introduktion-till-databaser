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

ALTER TABLE Users
Add Email VARCHAR(100);
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

-- Uppgift 7
-- Mata in två valfria tekniker i tabellen Users (t.ex. 'GlennDevOps' och 'AdaAdmin') i en
-- och samma INSERT-sats utan att manuellt ange något värde för Id-kolumnen.
INSERT INTO Users (Username, Email, Role)
VALUES
	('GlennDevOps', 'glenn@failsafe.it', 'DevOps'),
	('AdaAdmin', 'ada@failsafe.it', 'SysAdmin');
GO

--Uppgift 8
--Mata in tre servrar i tabellen Servers. Konfigurera en av dem för produktionsmiljön
--('Prod') och de andra två för utvecklingsmiljön ('Dev').
insert into Servers (ServerName, IpAddress, Environment)
values
	('SVR-PROD-SQL01', '10.0.1.10', 'Prod'),
	('SVR-STAGE-APP02', '10.0.2.20', 'Dev'),
	('SVR-DEV-SAND01', '10.0.3.50', 'Dev');

-- Uppgift 9
--Skriv en sökfråga som hämtar och visar samtliga kolumner och samtliga rader från
--tabellen Servers för att verifiera inmatningen

-- Hämta allt
SELECT * FROM Servers;

-- Uppgift 10
--Optimera sökfrågan från Uppgift 9 så att den endast hämtar kolumnerna ServerName
--och IpAddress, samt filtrerar bort alla servrar som inte tillhör produktionsmiljön ('Prod').
SELECT ServerName, IpAddress
FROM Servers
WHERE Environment = 'Prod';