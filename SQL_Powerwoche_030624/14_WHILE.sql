USE Northwind

-- Variablen allgemein

DECLARE @OrderID int = 10250

SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

SET @OrderID = 10251

SELECT * FROM vRechnungsDaten
WHERE OrderID = @OrderID

-- WHILE - leitet eine Schleifenanweisung ein

-- WHILEE = Eine Schleife

DECLARE @Counter INT = 0

WHILE @Counter <= 5
BEGIN
SELECT 'Hallo'
SET @Counter = @Counter + 1
END

-- Endlosschleife, aufpassen auf den Computer
WHILE 1=1
BEGIN 
SELECT 'Hallo'
END