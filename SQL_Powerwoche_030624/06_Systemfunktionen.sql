USE Northwind
-- String Funktionen bzw Text-Datentypen manipulieren

-- LEN gibt die laenge des Strings zur¸ck (Anzahl von Charaktern) als int
SELECT CompanyName, LEN(CompanyName) FROM Customers

-- LEFT/RIGHT geben die "linken" bzw. "rechten" x Zeichen eines Strings zur¸ck
SELECT CompanyName, LEFT(CompanyName, 5) FROM Customers
SELECT CompanyName, RIGHT(CompanyName, 5) FROM Customers

-- SUBSTRING(Spalte, x, y) springt zur Position x in einem String und gibt y Zeichen zur¸ck
SELECT SUBSTRING(CompanyName, 5, 5), CompanyName FROM Customers

-- STUFF(Spalte, x, y, replace) ersetzt y Zeichen eines Strings ab Position x
-- mit 'replace Wert' (optional)
SELECT Phone, STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

-- PATINDEX sucht nach "Schema" (wie LIKE) in einem String und gibt Position aus
-- an der das Schema das erste mal gefunden wurde
SELECT PATINDEX('%m%', CompanyName), CompanyName FROM Customers

-- CONCAT f¸gt mehrere Strings in die selbe Spalte hinzu
SELECT * FROM Employees
SELECT CONCAT(FirstName, ' ', LastName) as GanzerName FROM Employees
SELECT FirstName + ' ' + LastName as GanzerName FROM Employees

-- Datumsfunktionen
SELECT GETDATE() -- aktuelle Systemzeit mit Zeitstempel

SELECT YEAR(OrderDate) as Jahr, MONTH(OrderDate) as Monat, DAY(OrderDate) as Tag, 
OrderDate FROM Orders

-- "Zieht" ein gew¸nschtes Zeitintervall aus einem Datum
SELECT 
DATEPART(YEAR, OrderDate) as Jahr,
DATEPART(QUARTER, OrderDate) as Quartal,
DATEPART(WEEK, OrderDate) as KW,
DATEPART(WEEKDAY, OrderDate) as Wochentag,
DATENAME(WEEKDAY, OrderDate) as WochenTagName,
DATEPART(HOUR, OrderDate) AS Stunde,
OrderDate
FROM Orders

/*
	Deutsches Format:
	1-Montag, 2-Dienstag, 3-Mittwoch, 4-Donnerstag, 5-Freitag, 6-Samstag, 7-Sonntag

	Englischen Format:
	1-Sonntag, 2-Montag, 3-Dienstag, 4-Mittwoch, 5-Donnerstag, 6-Freitag, 7-Samstag

	Monaten:
	Deutschland: 1-12
	Englischem Format: 0-11
*/

-- Zieht den IntervallNamen aus einem Datum
SELECT DATENAME(MONTH, OrderDate), DATENAME(WEEKDAY, OrderDate),
DATEPART(WEEK, OrderDate), OrderDate FROM Orders

-- Intervall zu einem Datum addieren/subtrahieren
SELECT DATEADD(DAY, 14, GETDATE())
SELECT DATEADD(DAY, -14, GETDATE())

-- Differenz in Intervallen zwischen 2 Datums
SELECT DATEDIFF(YEAR, '20050213', GETDATE()), GETDATE()
SELECT DATEDIFF(YEAR, OrderDate, GETDATE()), OrderDate FROM Orders

-------------------------------------------------------------------------------
-- ‹bungen:
-- 1. Alle Bestellungen (Orders) aus Quartal 2 in 1997 (Datumsformat im String 'YYYYMMDD')
-- 2 Lˆsungswege:
SELECT * FROM Orders
WHERE DATEPART(QUARTER, OrderDate) = 2 AND DATEPART(YEAR, OrderDate) = 1997 

SELECT * FROM Orders
WHERE OrderDate BETWEEN '19970401' AND '19970630'


-- 2. Alle Produkte (ProductNames) die um Weihnachten herum (+- 10 Tage) in
-- 1996 verkauft wurden
-------------------------------------------------------------------------------
SELECT * FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate BETWEEN '19961214' AND '19970103'


-------------------------------------------------------------------------------
SELECT OrderDate FROM Orders

-- CAST oder CONVERT, wandeln Datentypen in der Ausgabe um
-- konvertierung von datetime => date
SELECT CAST(OrderDate as date) FROM Orders

SELECT CONVERT(date, OrderDate) FROM Orders

-- ISNULL pr¸ft auf NULL Werte und ersetzt diese wenn gew¸nscht
SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers

-- Komplexere Datumskonvertierungen mit Formatierung kombinieren! + Unterabfrage
SELECT FORMAT((SELECT CONVERT(date, '20050213')), 'D', 'de-de')
-- 2005-02-13
-- Sonntag, 13. Februar 2005 => D
-- 13.02.2005 => d

-- Telefonnummer customizen
SELECT FORMAT(4915455097, CONCAT('+', '## #### ####')) AS 'Custom Number'

-- REPLACE(x, y, z) => "y" sucht in "x" den String um Ihn mit "z" zu ersetzen
SELECT REPLACE('Hallo Welt!', 'Welt!', 'und Willkommen!')

-- REPLICATE(x, y) => Setize "y" mal die "x" vor der Spalte "Phone"
SELECT REPLICATE('0', 3) + Phone, Phone FROM Customers

-- REVERSE(Spaltenname) => z.B 'Hallo' wird zu 'ollaH'
SELECT CompanyName, REVERSE(CompanyName) FROM Customers

-- UPPER(Spaltenname) => alles in Groﬂbuchstaben
SELECT CompanyName, UPPER(CompanyName) FROM Customers

-- LOWER(Spaltenname) => alles in kleinbuchstaben
SELECT CompanyName, LOWER(CompanyName) FROM Customers

------------------------------------------------------------------------------
-- ‹bungen

-- 1. Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr 1997 aufgegeben wurden
-- (OrderDate in Orders) 'YYYYMMDD'
--> Customers - Orders
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND OrderDate BETWEEN '19970101' AND '19971231'

-- Bonus
-- Das ganze filtern mit Datumsfunktionen
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1997

-- 2. Welches Produkt (ProductName) hatte die groeﬂte Bestellmenge (Quantity in OD) im Februar 1998?
SELECT TOP 1 * FROM Products
JOIN [Order Details] ON [Order Details].ProductID = Products.ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(MONTH, OrderDate) = 2 AND DATEPART(YEAR, OrderDate) = 1998
ORDER BY Quantity DESC

-- 3. Wieviele Bestellungen kamen aus Spain (Customers) in Quartal 2 1997?
--   Sind es mehr oder weniger als aus Frankreich? (2. Abfrage)

-- Espaniola
SELECT * FROM Orders
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE DATEPART(QUARTER, OrderDate) = 2 AND DATEPART(YEAR, OrderDate) = 1997
AND Country = 'Spain'

-- France
SELECT * FROM Orders
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE DATEPART(QUARTER, OrderDate) = 2 AND DATEPART(YEAR, OrderDate) = 1997
AND Country = 'France'