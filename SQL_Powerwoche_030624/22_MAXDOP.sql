-- MAXDOP
-- Maximum Degree of Parallelism
-- Steuerung der Anzahl Prozessorkerne pro Abfrage
-- Parallelisierung passiert von alleine

SET STATISTICS time, IO on

SELECT Freight, FirstName, LastName 
FROM M005_Index
Where Freight > (SELECT AVG(Freight) FROM M005_Index)
-- Diese Abfrage wird parallesiert durch die zwei schwarzen Pfeile in dem gelben Kreis
--> Ausführungsplan

SELECT Freight, FirstName, LastName 
FROM M005_Index
Where Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 1)
-- CPU-Zeit = 156ms, verstrichene Zeit = 821ms

SELECT Freight, FirstName, LastName 
FROM M005_Index
Where Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 2)
-- CPU-Zeit = 202ms, verstrichene Zeit = 1147ms


SELECT Freight, FirstName, LastName 
FROM M005_Index
Where Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 4)
-- CPU-Zeit = 342ms, verstrichene Zeit= 1841ms

SELECT Freight, FirstName, LastName 
FROM M005_Index
Where Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 8)
-- CPU-Zeit = 278ms, verstrichenen Zeit = 1353ms
