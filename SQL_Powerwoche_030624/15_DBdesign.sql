/*
	Seite:
	8kB = 8192B groß
	8060b für tatäschlichen Daten
	132b sind für Management Daten

	Seiten werden immer 1zu1 gelesen

	Max. 700 DS Seite
	Datensätzen komplett auf die Seite anpassen
	Leerer Raum darf existieren, aber wollen wir vermeiden
*/

-- dbcc: Database Console Commands
-- showcontig: Zeigt Seiteninformatioen über ein Datenbankobjekt

dbcc showcontig('Orders') -- gescannte Seiten: 21 ; Seitendichte: 94,15%

CREATE DATABASE Demo2
USE Demo2

CREATE TABLE M001_Test1
(
	id int identity,
	test char(4100)
)

INSERT INTO M001_Test1
VALUES ('XYZ')
GO 20000

dbcc showcontig('M001_Test1')


CREATE TABLE M001_Test2
(
	id int identity,
	test varchar(4100)
)

INSERT INTO M001_Test2
VALUES ('XYZ')
GO 20000

dbcc showcontig('M001_Test2') -- gescannte Seiten: 52 ; Seitendichte: 95,01%
------------------------------------------------------------------------------

CREATE TABLE M001_Test3
(
	id int identity,
	test varchar(MAX)
)

INSERT INTO M001_Test3
VALUES ('XYZ')
GO 20000

dbcc showcontig('M001_Test3') -- Seiten: 52 ; Seitendichte: 95,01%
----------------------------------------------------------------

CREATE TABLE M001_Test4
(
	id int identity,
	test nvarchar(MAX)
)

INSERT INTO M001_Test4
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test4') -- Seiten: 60 ; Seitendichte: 94,70%

-- Statistiken für Zeit und Lesevorgägne zu aktiveren/deaktivieren
SET STATISTICS time, io ON

SELECT * FROM M001_Test3

-- sys.dm_db_index_physical_stats: Gibt einen Gesamtüberblick über die Seiten der Datenbank
SELECT OBJECT_NAME(OBJECT_ID), *
FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

/*
	Merke: 
	Seitendichte %-Grade:
	ab 70% OK, ab 80% ist es Gut, ab 90% ist es Sehr gut
	nvarchar: 2B pro Zeichen, varchar: 1B pro Zeichen

	Ziel:
	--> Weniger Seiten -> Weniger Daten laden -> bessere Performance
*/

SELECT * FROM INFORMATION_SCHEMA.TABLES
select * FROM INFORMATION_SCHEMA.COLUMNS -- Alle Spalten der Tabellen in der Datenbank anzeigen
-------------------------------------------------------------------------------------------------

USE Demo2

CREATE TABLE M001_TestFloat
(
	id int identity,
	zahl float
)

INSERT INTO M001_TestFloat
VALUES(2.2)
GO 20000

-- Mit SET STATISTICS time, io ON = 38 Sek
-- Ohne: 28 Sek

dbcc showcontig('M001_TestFloat') -- Seiten: 55 ; Seitendichte von 94,32%
------------------------------------

CREATE TABLE M001_TestDecimal
(
	id int identity,
	zahl decimal(2, 1)
)

INSERT INTO M001_TestDecimal
VALUES(2.2)
GO 20000

dbcc showcontig('M001_TestDecimal') -- Seiten: 47 ; Seitendichte: 94,61%

-- Schnellere Variante
BEGIN TRANSACTION
DECLARE @i INT = 0
WHILE @i < 20000
BEGIN
		INSERT INTO M001_TestDecimal VALUES(2.2)
		SET @i += 1
END
COMMIT



CREATE TABLE M001_Char
(
	id int identity,
	test char(8000)
)


INSERT INTO M001_Char
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Char') -- Seiten: 20000

-- CONVERT(TIME, SYSDATETIME())

CREATE TABLE M001_Char2
(
	id int identity,
	test char(2000)
)

INSERT INTO M001_Char2
VALUES ('XYZ')
GO 20000

dbcc showcontig('M001_Char2')

CREATE TABLE M001_Char3
(
	id int identity,
	test char(6000)
)

INSERT INTO M001_Char3
VALUES ('XYZ')
GO 20000

dbcc showcontig('M001_Char3')