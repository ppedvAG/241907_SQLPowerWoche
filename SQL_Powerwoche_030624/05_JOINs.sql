USE Northwind


-- Die Customers und Orders Tabelle in ein Ergebnisfenster ausgeben
SELECT * FROM Customers
SELECT * FROM Orders

/*
	JOIN Syntax:
	SELECT * FROM Tabelle A
	JOIN Tabelle B 
	ON A.Spalte1 = B.Spalte1
*/

SELECT * FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerID = 'ALFKI'
ORDER BY EmployeeID 


-- JOINEN - Orders - Customers - Order Details
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID

-- Übung:

-- 1. Welche Produkte (ProductName) hat "Leverling" bisher verkauft?
-- Tabellen: Employees - Orders - [Order Details] - Products
SELECT ProductName, LastName FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE LastName = 'Leverling'

-- 2. Wieviele Bestellungen haben Kunden aus Argentinien aufgegeben?
-- Tabellen: Customers - Orders
SELECT OrderID FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Argentina'

-- 3. Was war die größte Bestellmenge (Quantity) von Chai Tee (ProductName = 'Chai')?
-- Tabellen: [Order Details] - Products
SELECT TOP 1 ProductName, Quantity FROM Products 
JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
WHERE ProductName = 'Chai'
ORDER BY Quantity DESC

-- 4. Bestellungen die Herr King bearbeitet hat
-- Tabellen: Orders - Employees
SELECT * FROM Employees
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
WHERE Employees.LastName = 'King'

------------------------------------------------------------------------
-- OUTER JOINS: Left/Right und FULL OUTER

-- RIGHT: Z:189 & 502
-- Kunden die keine Bestellung getätigt haben
SELECT * FROM Orders as o
RIGHT JOIN Customers as cus ON o.CustomerID = cus.CustomerID

-- Ist das selbe
SELECT * FROM Customers as cus
LEFT JOIN Orders as o ON cus.CustomerID = o.CustomerID

SELECT * FROM Customers as cus
RIGHT JOIN Orders as o ON o.CustomerID = cus.CustomerID

-- FULL OUTER
SELECT * FROM Orders as o
FULL OUTER JOIN Customers as cus ON o.CustomerID = cus.CustomerID

-- JOIN "invertieren", d.h keine Schnittmenge anzeigen, durch filtern nach NULL
SELECT * FROM Orders as o
RIGHT JOIN Customers as cus ON o.CustomerID = cus.CustomerID
WHERE o.OrderID IS NULL

-- CROSS JOIN: Erstellt karthesissches Produkt zweier Tabellen (A x B)
SELECT * FROM Orders CROSS JOIN Customers

----------------------------------------------------------------------

-- Übung: 
-- 1. Alle Produkte (ProductNames) aus den Kategorien "Beverages" und "Produce"
-- (CategoryName in Categories)
SELECT * FROM Products as p
JOIN Categories as cat ON cat.CategoryID = p.CategoryID
WHERE Cat.CategoryName IN('Beverages', 'Produce')

-- 2. Alle Bestellungen (Orders) bei denen ein Produkt verkauft wurde, das nicht mehr gefuehrt wird
-- (Discontinued = 1 in Products)

--  3. Alle Produkte der Category "Beverages" (Tabelle Categories)
SELECT * FROM Products as p
JOIN Categories as cat ON cat.CategoryID = p.CategoryID
WHERE cat.CategoryName = 'Beverages'