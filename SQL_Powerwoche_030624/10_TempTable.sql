USE Northwind

/*

	Tempor�re Tabellen / Temp Tables / #Tables

*/

/*
	- SELECT INTO #TableName => Ergebnisse in eine Tempor�re Tabelle geschrieben werden
	- existieren nur innerhalb der Session (Skriptfenster / Query)
	- werden in SystemDB -> tempDB angelegt
	- Ergebnisse werden nur einmal generiert -> Sehr schnell dennoch nicht aktuell
	- mit einem # = "lokal"
	- mit zwei ## = "global"

*/

-- Erstellen
SELECT *
INTO #TempTable
FROM Customers
WHERE Country = 'Germany'

-- Tempor�re Tabelle ausgeben
SELECT * FROM #TempTable

-- manuell l�schen
DROP TABLE #TempTable

-- globale Temp Table:
SELECT *
INTO ##TempTable
FROM Customers
WHERE Country = 'Germany'

SELECT * FROM ##TempTable

--1. Hat �Andrew Fuller� (Employee) schonmal Produkte der Kategorie 
--�Seafood� (Categories) verkauft?
--Wenn ja, wieviel Lieferkosten sind 
--dabei insgesamt entstanden (Freight)?
-- Bonus: Das ganze mit Temporaere Tabellen machen
SELECT DISTINCT SUM(Freight) as Lieferkosten 
INTO #TempTable
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE Employees.LastName = 'Fuller' AND Categories.CategoryName = 'Seafood'

SELECT * FROM #TempTable