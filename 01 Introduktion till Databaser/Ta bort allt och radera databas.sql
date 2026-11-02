-- Uppgift 15
--Skriv ett skript som permanent raderar tabellen Servers och all dess sparade data från
--hårddisken, följt av ett kommando som raderar hela databasen FailSafeIT_Local.

-- Säkerställ att vi använder rätt databas:
USE FailSafeIT_Local;
GO

-- Ta bort tabellen Servers
DROP TABLE Servers;

-- Växla över till databasen master för att kunna ta bort hela vår databas
USE master;
GO

-- Nu kan vi ta bort vår databas
DROP DATABASE FailSafeIT_Local;
GO