-- Query Store
-- Erstellt während des Normalbetriebs Statistiken zu Abfragen

-- Rechtsklick auf DB -> Eigenschaften -> Abfragespeicher -> Betriebsmodus -> Lesen/Schreiben

USE DEMO2

SELECT * FROM Northwind.dbo.Orders o
INNER JOIN M005_Index i
ON o.CustomerID = i.CustomerID AND o.OrderID = i.OrderID AND o.EmployeeID = i.EmployeeID