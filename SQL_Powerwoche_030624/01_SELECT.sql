-- USE Datenbankname wechselt die angesprochene Datenbank
-- Alternativ "oben links" im Drop-Down Men� richtige DB ansprechen
USE Northwind

-- einzeiliger Kommentar

/*
	Mehrzeiligen 
	Kommentar
*/

/*
	SELECT: w�hlt Spalten aus, die im 
	Ergebnisfenster angezeigt werden sollen
*/
SELECT * FROM Customers -- * = w�hlt alle Spalten aus

-- "Custom"- Werte und mathematische Operatoren verwendet

SELECT 100

SELECT 'Hallo!'

SELECT 'Hallo!', 100

SELECT 100+5, 7*8
-- Nur einzelne "Anweisungen" ausf�hren: Zeile markieren, ausf�hren F5 oder STRG + E

---------------------------------------------------------
SELECT CustomerID, CompanyName, Country
FROM Customers

-- SQL ist NICHT case-sensitive, Formatierung spielt keine Rolle, ebenso wie keine Semikolons
sElEcT						CouNtrY,

				ComPanYnAmE
FROM		Customers

-- Sortieren mit ORDER BY
SELECT * FROM Customers
ORDER BY City

-- Absteigend sortieren mit DESC
SELECT * FROM Customers
ORDER BY City DESC
-- Order by ist syntaktisch IMMER AM ENDE
-- DESC = Descending -> absteigend
-- ASC = Ascending -> aufsteigend (Standard)

-- Auch mehrere Spalten gleichzeitig m�glich, DESC bezieht sich immer nur auf eine Spalte
SELECT City, CompanyName FROM Customers
ORDER BY City ASC, CompanyName DESC
-----------------------------------------------------------------

-- Die obersten 10 Zeilen von der Customers Tabelle
SELECT TOP 10 * FROM Customers
SELECT * FROM Customers -- => 91 Zeilen
SELECT TOP 100 * FROM Customers -- gibt uns auch nur die 91 Zeilen raus

-- Geht auch mit %-Angaben
-- TOP X PERCENT
SELECT TOP 10 PERCENT * FROM Customers

-- Die 20 gr��ten Frachtkosten
SELECT TOP 20 * FROM Orders
ORDER BY Freight DESC

-- Die 20 kleinsten Frachtkosten
SELECT TOP 20 * FROM Orders
ORDER BY Freight ASC

/*
	WICHTIG!: "BOTTOM X" existiert nicht, Ergebnisse 
	einfach "umdrehen" mit ORDER BY
*/
--------------------------------------------------------------------------
-- DISTINCT: Duplikate "filtern"
-- Filtert wir alle Ergebnisse/Datens�tze deren Werte exakt gleich ist

SELECT Country FROM Customers

SELECT DISTINCT Country FROM Customers

SELECT DISTINCT City, Country FROM Customers


--------------------------------------------------------------------------
-- UNION f�hrt mehrere Ergebnistabellen vertikal in eine Tabelle zusammen
-- UNION macht automatisch ein DISTINCT mit

SELECT * FROM Customers
UNION
SELECT * FROM Customers

-- mit UNION ALL wird kein DISTINCT ausgef�hrt
SELECT * FROM Customers
UNION ALL
SELECT * FROM Customers

-- Geht nicht wegen Datentypen, falsche Reihenfolge
SELECT 100, 'Hallo'
UNION
SELECT 'Tsch�ss', 5

-- Geht wiederrum schon
SELECT 100 as ID, 'Hallo' as 'Varchar-Spalte'
UNION
SELECT 5, 'Tsch�ss'

/*
	100     | Hallo
	Tsch�ss | 5

*/
--------------------------------------------------------------
-- Spalten "umbennen" �ber Aliase bzw. "as"
SELECT 100 as Zahl, 'Hallo' as Begr��ung

SELECT City as Stadt FROM Customers

-- Aliase k�nnen auch f�r Tabellennamen vergeben werden
SELECT * FROM Customers as cus

-- �bung:

-- 1. Die 10 gr��ten UnitPrices in der Product-Tabelle
SELECT TOP 10 * FROM Products
ORDER BY UnitPrice DESC

-- 2. Die 5 kleinsten UnitPrices in der Product-Tabelle
SELECT TOP 5 * FROM Products
ORDER BY UnitPrice ASC

-- 3. Aus der Orders-Tabelle, die Spalten OrderDate, RequiredDate, Shippeddate rausholen und auf Deutsch umbennen die Spalten
SELECT OrderDate as 'Bestelldatum', RequiredDate as 'Wunschdatum', ShippedDate as 'Lieferdatum'
FROM Orders