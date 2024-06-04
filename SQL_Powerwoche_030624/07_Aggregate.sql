USE Northwind

-- Aggregatfunktionen: Führt eine Berecnung auf einer Menge von Werten durch und gibt
--					   einen einzigen Wert zurück
-- Ausnahme: COUNT(*) ignoriert keine NULL Werte, Aggregatfunktion schon

-- 5 grundsätzlichen verschiedenen Funktionen

SELECT
SUM(Freight) as Summe,
MIN(Freight) as Minimum,
MAX(Freight) as Maximum,
AVG(Freight) as Durchschnitt,
COUNT(ShippedDate) as ZähleSpalte,
COUNT(*) as Zählealles
FROM Orders

-- AVG selber berechen
SELECT SUM(Freight) / COUNT(*) FROM Orders

SELECT CustomerID, SUM(Freight) FROM Orders
-- Lösung über GROUP BY:
/*
	GROUP BY - Fasst mehrere Werte in Gruppen zusammen
*/

SELECT CustomerID, Freight FROM Orders
WHERE CustomerID = 'ANATR'

-- Lösung GROUP BY
SELECT CustomerID, SUM(Freight) AS Summe FROM Orders
GROUP BY CustomerID

SELECT ProductID, Quantity as SummeStueckzahl from [Order Details]
WHERE ProductID = 23

-- Quantity Summe PRO ProductID
SELECT ProductID, SUM(Quantity) as SummeStueckzahl from [Order Details]
GROUP BY ProductID

-- Quantity Summe pro ProductName
SELECT ProductName, SUM(Quantity) AS SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
--WHERE ProductName = 'Alice Mutton'
GROUP BY ProductName
ORDER BY SummeStueckZahl

-- Quantity Summe pro ProductName für Produkte der Kategorien 1-4
SELECT ProductName, SUM(Quantity) AS SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1,2,3,4)
GROUP BY ProductName
ORDER BY SummeStueckZahl DESC

-- Verkaufte Stueckzahlen pro Produkt, aber nur die über 1000
SELECT ProductName as Produkt, SUM(Quantity) as SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE SUM(Quantity) > 1000
GROUP BY ProductName
ORDER BY SummeStueckZahl DESC

-- HAVING funktioniert 1zu1 wie ein WHERE, kann aber gruppierte/aggregiert Werte nachträglich filtern
SELECT ProductName as Produkt, SUM(Quantity) as SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
--WHERE SUM(Quantity) > 1000
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeStueckZahl DESC

-- Übung
-- 1. Verkaufte Stueckzahlen (Quantity) pro ProduktKategorie (CategoryName) (8 Ergebniszeilen)
SELECT CategoryName as Kategorien, SUM(Quantity) as SummeStückZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName
ORDER BY SummeStückZahl DESC

-- 2. Wieviele Bestellungen hat jeder Mitarbeiter bearbeitet? (9 Ergebniszeilen)
SELECT Employees.EmployeeID, SUM(Quantity)as Bestellungen, LastName  FROM Orders
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY .Employees.EmployeeID, LastName
ORDER BY Bestellungen DESC

SELECT LastName, COUNT(OrderID) as Bestellungen, FirstName FROM Employees
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName, FirstName
ORDER BY Bestellungen DESC

-- 3. Was war das meistverkaufte Produkt im Jahr 1998 (Productname)? Wieviel Stück (Quantity)?
SELECT TOP 1 ProductName as Produkt, SUM(Quantity) as SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998
GROUP BY ProductName
ORDER BY SummeStueckZahl DESC

-- 4. In welcher Stadt (City) waren „Wimmers gute Semmelknödel“ am beliebtesten (Quantity)?
SELECT City, SUM(Quantity) as Verkaufsmenge FROM Products
JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE ProductName = 'Wimmers gute SemmelknÃ¶del'
GROUP BY City
ORDER BY Verkaufsmenge DESC

SELECT * FROM Products

-- 5. Welcher Spediteur (Shippers) war durchschnittlich am günstigsten? (Freight)
-- Tabelle: Shippers - Orders
SELECT CompanyName, AVG(Freight) as AvgFreight FROM Orders 
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName
ORDER BY AvgFreight


-- 6. Ist der Spediteur „Speedy Express“ 
--über die Jahre durchschnittlich teurer geworden? (Freight pro Jahr)
-- Tipps: DATEPART, AVG benötigt
-- GROUP BY DATEPART(YEAR, OrderDate) benötigt
SELECT CompanyName, DATEPART(YEAR, OrderDate) as Geschäftsjahr, AVG(Freight) as AvgFreight
FROM Orders JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
WHERE CompanyName = 'Speedy Express'
GROUP BY DATEPART(YEAR, OrderDate), CompanyName
ORDER BY AvgFreight DESC

-- 7. Gab es Bestellungen (OrderID) an Wochenendtagen (OrderDate)?
SELECT * FROM Orders
WHERE DATEPART(WEEKDAY, OrderDate) IN (6,7)
