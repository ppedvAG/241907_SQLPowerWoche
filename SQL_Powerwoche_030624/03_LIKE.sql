USE Northwind
-- LIKE: Für ungenaue Filterung/Suche 
-- (statt Vergleichsoperatoren)

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle = 'Owner'

-- Wildcards
-- "%"-Zeichen: Beliebige Symbole, beliebig iele davon
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Owner%'

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Manager%'

-- "_"-Zeichen: EIN beliebiges Symbole
SELECT CompanyName FROM Customers
WHERE CompanyName LIKE '_r%'

SELECT CompanyName FROM Customers
WHERE CompanyName LIKE 'Arou_%'

-- "[]"-Zeichen: Alles in den Klammern ist ein gültiges Symbol an der Stelle jeweils
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[012345]%'

-- "[a-z]"-Zeichen: Der Bereich in den Klammern ist gültig -> gegenteil [^a-z]
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[0-5]%'

-- gegenteil
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[^0-5]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[1-5][6-8]%'

-- Sonderfälle: % '
SELECT * FROM Customers
WHERE CompanyName LIKE '%['']%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'

-- Übung

-- 1. Alle CustomerIDs von Orders-Tabelle die Anfangen mit "V"
SELECT * FROM Orders
WHERE CustomerID LIKE '[V]%'

-- 2. Alle ShipCity's die mit einem "G" anfangen und an der 2ten Stelle ein "r" haben
SELECT * FROM Orders
WHERE ShipCity LIKE '[G][R]%'

-- 3. Alle ContactTitle's die ein "Administrator" beeinhalten 
-- Tabelle Customers
SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Administrator%'