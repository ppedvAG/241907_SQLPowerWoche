USE Demo2
-- Kompression

-- Daten verkleinern
--> Weniger Daten werden geladen, beim dekomprimieren wird CPU Leistung verwendet

-- Zwei verschiedene Typen
-- Row Compression
-- Page Compression
-- Page Compression enthält Row Compression

USE Northwind;
SELECT  Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Orders.Freight, Customers.CustomerID, Customers.CompanyName, 
		Customers.ContactName, Customers.ContactTitle, Customers.Address, Customers.City, 
        Customers.Region, Customers.PostalCode, Customers.Country, Customers.Phone, Orders.OrderID, Employees.EmployeeID, 
		Employees.LastName, Employees.FirstName, Employees.Title, [Order Details].UnitPrice, 
        [Order Details].Quantity, [Order Details].Discount, Products.ProductID, Products.ProductName, Products.UnitsInStock
INTO Demo2.dbo.M004_Kompression
FROM    [Order Details] INNER JOIN
        Products ON Products.ProductID = [Order Details].ProductID INNER JOIN
        Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
        Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
        Customers ON Orders.CustomerID = Customers.CustomerID

USE Demo2

INSERT INTO M004_Kompression
SELECT * FROM M004_Kompression
GO 8

SELECT COUNT(*) FROM M004_Kompression

SET STATISTICS time, io on

-- Rechtsklick auf Tabelle -> Speicher > Kompressionen

-- Ohne Compression: logische Lesevorgänge: 28289, CPU-Zeit = 187ms
-- verstrichene Zeit = 6984ms
SELECT * FROM M004_Kompression 

-- Row Compression
USE [Demo2]
ALTER TABLE [dbo].[M004_Kompression] REBUILD PARTITION = ALL
WITH
(DATA_COMPRESSION = ROW)

SELECT * FROM M004_Kompression
-- logische Lesevorgänge: 15865
-- CPU-Zeit = 282ms ; verstrichene Zeit = 6950ms


-- Page Compression
-- logische Lesevorgänge:  7608
-- CPU-Zeit = 375ms; verstrichene Zeit =  7378ms
SELECT * FROM M004_Kompression

-- Alle Kompression ausgeben
SELECT t.name as TableName, p.partition_number as PartitionNumber, p.data_compression_desc AS Compression
FROM sys.partitions AS p
JOIN sys.tables AS t ON t.object_id = p.object_id