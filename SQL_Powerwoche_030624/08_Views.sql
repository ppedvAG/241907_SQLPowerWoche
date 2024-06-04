USE Northwind
-- Views: Erzeugt eine Virtuelle Tabelle, deren Inhalt durch eien Abfrage definiert wird
/*
	Vorteile:
	- Sicherheit: User erlauben nur die View zu lesen, nicht zu ver�ndern
	- Views sind immer aktuell (aktuellen Daten)
		=> beim Aufruf einer View wird das hinterlegte Statement ausgef�hrt
	- Um komplexere Abfragen zu speichern
*/

CREATE VIEW vRechnungsDaten AS
SELECT
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName
GO

-- Aufruf der View
SELECT * FROM vRechnungsDaten

-- View loeschen
DROP VIEW vRechnungsDaten

-- Code hinter einer View (oder anderem DB Objekt) ansehen �ber Objekt Explorer
-- Rechtsklick -> SCRIPT AS -> CREATE -> neues Abfragefenster

-- View �ndern
ALTER VIEW vRechnungsDaten AS
SELECT
Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName,
CAST(SUM((UnitPrice * Quantity) * (1 - Discount)) + Freight as decimal(10,2)) as SummeBestPosi 
FROM [Order Details]
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Orders.OrderID, 
Customers.CustomerID, Customers.CompanyName, Customers.Country, Customers.City, Customers.PostalCode, Customers.Address,
Orders.Freight, Orders.OrderDate,
Employees.LastName
GO