USE Northwind


-- Stored Procedures / gespeicherte Prozeduren

/*
	- Sind gespeicherte SQL Anweisungen (nicht nur SELECT, sondern auch alles andere)
	- Arbeiten mit Variablen
	- Praktisch zum "automatisieren" von Code
	- Prozeduren verwenden immer wieder ihren QueryPlan
*/
GO

CREATE PROCEDURE spRechnungByOrderID @OrderID INT
AS
SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID
GO

-- Procedur ausführen
EXEC spRechnungByOrderID 10260
GO

CREATE PROCEDURE spRechnungByOrderIDZwei @OrderID INT, @OrderIDZwei INT
AS
SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID
SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderIDZwei
GO

EXEC spRechnungByOrderIDZwei 10248, 10249
GO

-----------------------
CREATE PROCEDURE spNewCustomer
@CustomerID char(5), @CompanyName varchar(40),
@Country varchar(30), @City varchar(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spNewCustomer 'ALDIS', 'ppedv AG', 'Germany', 'Burghausen'
GO
EXEC spNewCustomer LIDLI, 'Lidl GmbH', Germany, Burghausen
GO


SELECT * FROM Customers
WHERE CustomerID = 'LIDLI'
GO

-- Default Werte
CREATE PROCEDURE spKundenNachLandCity @Country varchar(50) = 'Germany', @City varchar(50) = 'Berlin'
AS
SELECT * FROM Customers WHERE Country = @Country AND City = @City
GO

EXEC spKundenNachLandCity France, Paris
GO
EXEC spKundenNachLandCity 
GO

-- Erstelle eine Procedure, der man als Parameter eine OrderID übergeben kann.
-- Bei Ausführung soll der Rechnungsbetrag dieser Order ausgegeben werden 
-- SUM(Quantity * UnitPrice + Freight) = RechnungsSumme.
ALTER PROCEDURE RechnungsSumme @OrderID INT
AS
SELECT Orders.OrderID as Test, SUM(Quantity * UnitPrice + Freight) FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderID = @OrderID
GROUP BY Orders.OrderID
GO

EXEC RechnungsSumme 10250
GO
