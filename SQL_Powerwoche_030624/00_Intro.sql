/*
	Agenda:

	Start: 09:00
	Ende: 16:30-17:00
	Mittag: ca. 12-12:30
	Vor- und Nachmittags:
	kleine Pause von 15min-20min

	Tag 1:
	- Management Studio
	- SELECT Abfragen
	- DISTINCT, TOP, ORDER BY
	- WHERE Filter + LIKE
	- Datentypen
	- JOINs

	Tag 2:
	- Systemfunktionen Datum/Strings/Cast
	- GROUP BY
	- Aggregate (COUNT, MAX)
	- Views

	Tag 3:
	- INSERT/UPDATE/DELETE
	- CREATE/ ALTER / DROP
	- stored Procedures
	- Unterabfragen
	- Tempor�re Tabellen
	- Case

	Tag 4:
	- Dateigruppen
	- MAXDOP
	- Datums Dateigruppen

	Tag 5:
	- Indizes
	- SQL Profiler



*/

USE Northwind

SELECT City as Stadt FROM Customers
WHERE City = 'Berlin'
ORDER BY Stadt DESC