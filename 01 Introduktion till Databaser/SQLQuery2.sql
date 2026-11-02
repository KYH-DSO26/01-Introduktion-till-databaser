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

-- Uppgift 11
--Uppdatera IP-adressen för en specifik server i databasen med hjälp av ett UPDATEkommando.
--Säkerställ att du använder ett filter så att inte alla servrar påverkas.
UPDATE Servers
SET IpAddress = '10.0.1.99'
WHERE ServerName = 'SVR-PROD-SQL01';	-- GÖRVIKTIGT! PÅ RIKTIGT!!!

begin transaction	-- BRA ATT GÖRA innan man försöker sig på något farligt
UPDATE Servers
SET IpAddress = '10.0.1.99'		-- OBS vi har inget WHERE
select * from Servers	-- ALLA har fått samma IP
ROLLBACK	-- Rulla tillbaka alla ändringar
select * from Servers	-- Det ser OK ut

-- Om ändringarna gick bra, så låser vi in dem med COMMIT
--COMMIT


-- Uppgift 12
--Radera en av utvecklingsservrarna permanent från tabellen Servers genom att rikta ett
--DELETE-kommando specifikt mot radens unika ID-nummer.
select * from Servers
delete from Servers
WHERE Id = 2;			-- GÖRVIKTIGT! Annars raderar vi alla rader i tabellen!!!

-- Antag nu att vi vill stoppa tillbaka den nyss borttagna severn. 
-- Vi kan lägga till den på nytt:
insert into Servers (ServerName, IpAddress, Environment)
values
	('SVR-STAGE-APP02', '10.0.2.20', 'Dev');
SELECT * FROM Servers		-- Observera nu vad servern fick för ID

-- Uppgift 13
--Modifiera tabellen Users i efterhand med hjälp av ett DDL-kommando (ALTER TABLE) så
--att kolumnen Username får villkoret UNIQUE (vilket förhindrar att två tekniker har samma
--namn).
ALTER TABLE Users
ADD CONSTRAINT UQ_Users_Username UNIQUE (Username);

-- Om vi nu försöker att stoppa in en dublett, så går inte det. Vi får ett felmeddelande.
INSERT INTO Users (Username, Email, Role)
VALUES
	('GlennDevOps', 'glenn@failsafe.it', 'DevOps');