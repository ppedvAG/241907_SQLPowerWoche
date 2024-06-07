USE Demo2

/*
	Table Scan: Durchsucht die gesamte Tabelle (langsam)
	Index Scan: Durchsucht bestimmte Teile der Tabelle (besser)
	Index Seek: Geht in einen Index gezielt zu den Daten hin (am besten)

	Clustered Index:
	Normaler Index, welcher sich immer selbst soritert
	bei INSERT/UPDATE werden die Daten herumgeschoben
	Kann nur einmal existieren pro Tabelle
	-> Kostet Performance
	Standardmäßig auf den PK gelegt

	Non-Clustered Index:
	StadardIndex
	Zwei Komponenten: Schlüsselspalten, inkludierten Spalten
	Anhand an der Komponten entscheiden die DB ob der Index verwendet wird
*/

SELECT * INTO M005_Index
FROM M004_Kompression

USE Demo2

SET STATISTICS time, io ON

-- Tabellenscan
SELECT * FROM M005_Index

SELECT * FROM M005_Index
WHERE OrderID >= 11000
-- Table Scan
-- Cost: 21, logische Lesevorgänge: 28365, CPU-Zeit = 94ms, verstrichene Zeit = 1078ms

-- Neuer Index: NCIX_OrderID
SELECT * FROM M005_Index
WHERE OrderID >= 11000
-- Index Seek
-- Cost: 2,18, logische Lesevorgänge: 2894, CPU-Zeit = 32ms, verstrichene Zeit = 902ms

-- Indizes anschauen
SELECT OBJECT_NAME(OBJECT_ID), index_level, page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE OBJECT_NAME(object_ID) = 'M005_Index'

-- Auf bestimmte häufige Abfragen Indizes aufbauen
SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice
FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Tabellenscan
-- Cost: 21, logische Lesevorgänge: 38365, CPU-Zeit = 124ms, verstrichene Zeit = 107ms

-- Neuer Index: NCIX_ProductName
SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice
FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Index Seek
-- Cost: 0,06, logische Lesevorgänge: 80, CPU-Zeit = 0ms, verstrichene Zeit = 71ms

-- Neuer Index: NCIX_Freight
SELECT CompanyName, ContactName, Phone, ProductName, Quantity * UnitPrice, Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > 50
-- Tabellenscan
-- Cost: 21, logische Lesevorgänge: 28365, CPU-Zeit = 0ms, verstrichene Zeit = 2117ms

SELECT CompanyName, ContactName, Phone, ProductName, Quantity * UnitPrice, Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > 50
-- Index Seek
-- Cost: 11, logische Lesevorgänge: 14766, CPU-Zeit = 78ms, verstrichene Zeit = 2120ms

-- Nur die Spalten genommen die benötigt waren
SELECT CompanyName, ContactName, Phone, ProductName, Quantity * UnitPrice, Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > 50
-- Index Seek
-- Cost: 5,4, logische Lesevorgänge: 6889, CPU-Zeit = 15ms, verstrichene Zeit = 2023ms

SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice, Freight
FROM M005_Index
WHERE Freight > 50
-- Index Seek
-- Cost: 3,92, logische Lesevorgänge: 4833, CPU-Zeit = 0ms, verstrichene Zeit = 1630ms

--------------------------------------------------------------------

-- Indizierte Sicht
-- View mit Index
-- Benötigt SCHEMABINDING
-- WITH SCHEMABINDING: Solange die View existiert, kann die Tabellenstruktur nicht verändert werden

ALTER TABLE M005_Index ADD id int identity
GO

CREATE VIEW Adressen WITH SCHEMABINDING
AS
SELECT id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M005_Index

-- Clustered Index Scan = Gruppierter Index Scan
SELECT * FROM Adressen

-- Clustered Index Scan
-- Abfrage auf die Tabelle verwendet den Index der View
SELECT id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M005_Index