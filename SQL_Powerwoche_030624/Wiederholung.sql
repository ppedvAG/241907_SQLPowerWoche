USE Northwind

SELECT CustomerID, SUM(Freight) FROM Orders
GROUP BY CustomerID


-- Übung

--1. Hat „Andrew Fuller“ (Employee) schonmal Produkte der Kategorie 
--„Seafood“ (Categories) verkauft?
--Wenn ja, wieviel Lieferkosten sind 
--dabei insgesamt entstanden (Freight)?
SELECT Employees.EmployeeID as Mitarbeiter, CategoryName, SUM(Freight) as Kosten, SUM(Quantity) as Bestellungen, LastName, FirstName FROM Orders
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE Employees.LastName = 'Fuller' AND CategoryName = 'Seafood'
GROUP BY Employees.EmployeeID, CategoryName, LastName, FirstName
ORDER BY Bestellungen DESC

-- Musterlösung
SELECT DISTINCT SUM(Freight) as Lieferkosten
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE Employees.LastName = 'Fuller' AND Categories.CategoryName = 'Seafood'

--2. Erstellen Sie einen Bericht, der die Gesamtzahl der 
--Bestellungen nach Kunde seit dem 31. Dezember 1996 anzeigt. 
--Der Bericht sollte nur Zeilen zurückgeben, 
--für die die Gesamtzahl der Aufträge größer als 15 ist (5 Zeilen)
SELECT CustomerID, COUNT(OrderID) FROM Orders
WHERE OrderDate > '19961231'
GROUP BY CustomerID
HAVING COUNT(OrderID) > 15
ORDER BY 2 

-- 3. Jahrweiser Vergleich unserer 3. Spediteure: (Shippers Tabelle): 
-- Lieferkosten (Freight) gesamt, Durchschnitt (freight)
-- pro Lieferung und Anzahl an Lieferungen
-- Tables: Orders - Shippers
-- Aggregate: SUM, AVG, COUNT
-- DATEPART() benoetigt
/*
	Ergebnis in etwa so:
	SpediteurName, Geschäftsjahr, FreightGesamt, FreightAvg, AnzBestellungen
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	usw....
*/
SELECT ShipperID, CompanyName as Spediteur,
DATEPART(YEAR, OrderDate) as Geschäftsjahr,
SUM(Freight) as FreightGesamt,
AVG(Freight) as FreightAvg
FROM Shippers
JOIN Orders ON Orders.ShipVia = Shippers.ShipperID
GROUP BY ShipperID, CompanyName, DATEPART(YEAR, OrderDate)
ORDER BY DATEPART(YEAR,OrderDate) DESC

-- Musterlösung
SELECT CompanyName as SpediteurName,
DATEPART(YEAR, OrderDate) as Geschaeftsjahr,
SUM(Freight) AS FreightGesamt,
AVG(Freight) AS FreightAvg,
COUNT(*) as AnzBestellungen
FROM Shippers
JOIN Orders ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)
ORDER BY Geschaeftsjahr, FreightAvg

-- 4. Wieviel Umsatz haben wir in jedem Geschäftsjahr insgesamt gemacht?
-- Benoetigt: SUM(SummeBestPosi)
SELECT * FROM vRechnungsDaten

SELECT DATEPART(YEAR, OrderDate) AS GeschäftsJahr,
SUM(SummeBestPosi) AS Umsatz FROM vRechnungsDaten
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY GeschäftsJahr

-- 5. Wieviel Umsatz haben wir in Q1 1998 mit Kunden aus den USA gemacht?
SELECT DATEPART(QUARTER, OrderDate) as Quartal, OrderDate as BestellDatum, Country as Land,
SUM(SummeBestPosi) AS Umsatz FROM vRechnungsDaten
WHERE DATEPART(QUARTER, OrderDate) = 1 AND Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1998
GROUP BY OrderDate, Country

-- Musterlösung
SELECT SUM(SummeBestPosi) AS GesamtUmsatz FROM vRechnungsDaten
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(QUARTER, OrderDate) = 1




-- Hatten wir Bestellungen, die wir zu spaet ausgeliefert haben? Wenn 
-- ja, welche OrderIDs waren das und wieviele Tage
-- waren wir zu spaet dran? (Verzoegerung = Unterschied zwischen Shipped 
-- & Required Date in Orders) Tipp: DATEDIFF & ISNULL
-- ISNULL prueft auf Null Werte und ersetzt diese wenn gewuenscht
-- BSP: SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers
/* 37
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
usw...
*/
SELECT OrderID, DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) as TageZuSpät FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) > 0
ORDER BY TageZuSpät DESC