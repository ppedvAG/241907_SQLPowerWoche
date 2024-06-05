USE Northwind

-- Subqueries / Unterabfragen / nested queries

/*
	- M�ssen eigenst�dnig fehlerfrei ausf�hrbar sein!
	- K�nnen prinzipiell �berall in eine Abfrage eingebaut werden (wenn es Sinn macht)
	- Abfragen werden "von innen nach au�en" der Reihe nach ausgef�hrt
*/

-- Zeige mir alle Orders, deren Freight Wert �ber dem Durchschnitt liegt
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) -- 78,2442

--  Schreiben Sie eine Abfrage, um eine Produktliste 
--	(ID, Name, St�ckpreis) mit einem �berdurchschnittlichen Preis zu erhalten.
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice DESC