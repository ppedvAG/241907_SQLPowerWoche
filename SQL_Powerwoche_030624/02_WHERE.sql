USE Northwind

-- WHERE: filtert Ergebniszeilen
SELECT * FROM Customers
WHERE Country = 'Germany'

SELECT * FROM Customers
WHERE Country = 'France'

-- = wird nach exakten Treffern gefiltert

SELECT * FROM Orders
WHERE Freight = 100

-- alle boolschen Vergleichsoperatoren verwenden
-- (>, <, >=, != bzw. <>)

SELECT * FROM Orders
WHERE Freight > 500

SELECT * FROM Orders
WHERE Freight < 500

-- Ungleich Zeichen
SELECT * FROM Customers
WHERE Country != 'Germany'

-- Kombinieren von WHERE Ausdrücken mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

-- Filtern nach Germany oder France
SELECT * FROM Customers
WHERE Country = 'Germany' OR Country = 'France'

-- AND = "Beide Bedingungen müssen "wahr" sein (true oder 1)
-- OR = Ein Ausdruck muss wahr sein
-- Können beliebig viele kombiniert werden

-- "Vorsicht" bei Kombination aus AND und OR
SELECT * FROM Customers
WHERE (City = 'Paris' OR City = 'Berlin') AND Country = 'Germany'
-- AND "ist stärker bindent" als OR; Notfalls Klammern setzen!


-- Ranges mit Randwerten 
SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500

-- BETWEEN, Randwerte mit Inbegriffen
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT * FROM Customers
WHERE Country = 'Brazil' OR Country = 'Germany' OR Country = 'France'

-- Alternative: IN(Wert1, Wert2, Wert3)
SELECT * FROM Customers
WHERE Country IN ('Brazil', 'Germany', 'France')
-- IN verbindet mehrere OR Bedingungen die sich auf die selbe Spalte beziehen

-- Übungen:

-- 1. Alle ContactNames die als Title "Owner" haben
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle = 'Owner'

-- 2. Alle [Order Details] die ProductID 43 bestellt haben
SELECT * From [Order Details]
WHERE ProductID = 43

-- 3. Alle Kunden aus Paris, Berlin, Madrid oder Brasilien
SELECT * FROM Customers
WHERE City IN ('Paris', 'Berlin', 'Madrid') OR Country = 'Brazil'

-- 4. Filtern mit/nach NULL Werten:
-- NULL bedeutet KEIN Wert eingetragen, nicht dasselbe wie " " Leerzeichen
-- (Bonus Aufgabe) Spalte Fax von Customers
SELECT * FROM Customers
WHERE Fax IS NULL

SELECT * FROM Customers
WHERE Fax != 'NULL'

SELECT * FROM Customers
WHERE Fax IS NOT NULL