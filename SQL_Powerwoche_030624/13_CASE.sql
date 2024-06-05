USE Northwind


-- CASE - unterscheiden definierte F�lle, die die Ausgabe ver�ndern

-- Wenn ein Fall gefunden wird, dann passiert xyz, wenn nicht dann ist das Ergebnis NULL
SELECT UnitsInStock,  
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
	WHEN UnitsInStock >= 10 THEN 'Passt.'
END as Pr�fung
FROM Products

-- Alternativ mit ELSE einen "Notausgang" definieren:
SELECT UnitsInStock,  
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
	WHEN UnitsInStock >= 10 THEN 'Passt.'
	ELSE 'Fehler!'
END as Pr�fung
FROM Products

-- Auch im GROUP BY
SELECT SUM(UnitsInStock),
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
	WHEN UnitsInStock >= 10 THEN 'Passt.'
	ELSE 'Fehler!'
END as Pr�fung
FROM Products
GROUP BY
CASE
	WHEN UnitsInStock < 10 THEN 'Nachbestellen!'
	WHEN UnitsInStock >= 10 THEN 'Passt.'
	ELSE 'Fehler!'
END

-- Funktioniert auch mit UPDATE:
UPDATE Customers
SET City = 
CASE
	WHEN Country = 'Germany' THEN 'Berlin'
	WHEN Country = 'France' THEN 'Paris'
	ELSE City
END