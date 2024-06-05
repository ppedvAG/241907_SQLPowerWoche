USE Northwind

/*

	CREATE / ALTER / DROP - DDL (Data Definition Language)

*/

-- Immer wenn wir Datenbankobjekte "bearbeiten" gelten diese Befehle

-- Erstellen eine Tabelle Namens 'PurchasingOrders'
CREATE TABLE PurchasingOrders
(
	ID INT IDENTITY(1, 1) PRIMARY KEY,
	OrderDate date NOT NULL,
	ProductID int NOT NULL
)

SELECT * FROM PurchasingOrders

-- Beziehung zwischen PurchasingOrders und Products anlegen �ber ProductID
ALTER TABLE PurchasingOrders ADD FOREIGN KEY (ProductID)
REFERENCES Products (ProductID)

-- Neue Spalte hinzufuegen zu bestehendem Table:
ALTER TABLE PurchasingOrders
ADD TestDaten INT

-- Spalte aus bestehender Tabelle l�schen:
ALTER TABLE PurchasingOrders
DROP COLUMN TestDaten

-- INSERT - Datens�tzen in einer Tabelle einf�gen

-- Alle Spalten zu befuellen:
INSERT INTO PurchasingOrders
VALUES ('20240605', 5)

-- Explizit einzelne Spalten befuellen:
INSERT INTO PurchasingOrders (OrderDate, ProductID)
VALUES (GETDATE(), 10)

SELECT * FROM PurchasingOrders

-- Ergebnis einer SELECT-Abfrage k�nnen direkt Inserted werden (Wenn Spaltenanzahl passt
-- & Datentypen kompatibel sind)
INSERT INTO PurchasingOrders
SELECT GETDATE(), 20


-- DELETE - L�schen von Datens�tzen in einer Bestehenden Tabelle

SELECT * FROM PurchasingOrders

-- Aufpassen! Ohne WHERE Filter werden alle Datens�tze gel�scht!
DELETE FROM PurchasingOrders
WHERE ID = 10

-- Prim�r-/Fremdschl�sselbeziehungen verhindern das l�schen von Datesn�tzen, wenn andere Datens�tze
-- sonst "ins Leere laufen w�rden"
DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

-- UPDATE -- �ndern von Spaltenwerden in einem vorhanden Datensatz

SELECT * FROM PurchasingOrders

UPDATE PurchasingOrders
SET ProductID = 10
WHERE ID = 12

UPDATE PurchasingOrders
SET TestDaten = 50

-- "L�schen" von Werten:
UPDATE PurchasingOrders
SET TestDaten = NULL

--Trage dich selber in die Tabelle ein (Employees). Bei den folgenden Spalten: 
--LastName, FirstName, Title, TitleOfCourtesy, BirthDate, 
--HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo
SELECT * FROM Employees

INSERT INTO Employees (LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, City, Region, PostalCode, Country, HomePhone, ReportsTo)
VALUES ('Libowicz', 'Philipp', 'IT-Trainer', 'Mr', '20050213', '20230901', 'Burghausen', 'Bayern', '84489', 'Deutschland', '555-983162', 1)
-- Bonus: Aendere die Werte danach um, in eine Person die frei erfunden ist


-- Transactions

BEGIN TRANSACTION

UPDATE PurchasingOrders
SET TestDaten = 5

COMMIT  -- => �bernahme von �nderungen
ROLLBACK -- => Reset von �nderungen

SELECT * FROM PurchasingOrders