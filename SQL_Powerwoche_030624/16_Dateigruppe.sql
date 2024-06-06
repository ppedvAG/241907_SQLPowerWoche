/*
	Dateigruppen:
	Datenbank aufteilen auf mehrere Dateien, und verschiedene Datentr‰ger in weiterer Folge
	[PRIMARY]: Hauptgruppe, existiert immer, enth‰lt standardm‰ﬂig alle Files

	Das Hauptfile hat die Endung .mdf
	Weiteren Files haben die Endung .ndf
	Log File haben die Endung .ldf
*/

USE Demo2

/*
	Rechtsklick auf die DB -> Eigenschaften
	Dateigruppen
		- Hinzuf¸gen, Name vergeben
	Dateien
		- Hinzuf¸gen, Namen, Dateigruppe angeben, Pfad usw...
*/

CREATE TABLE M002_FG2
(
	id int identity,
	test char(4100)
)

INSERT INTO M002_FG2
VALUES('XYU')
GO 20000

-- Wie verschiebe ich eine Tabelle auf eine andere Dateigruppe?
-- Neu erstellen, Daten verschieben, Alte Tabelle lˆschen

CREATE TABLE M002_FG2_2
(
	id int,
	test char(4100)
) ON [Aktiv]

INSERT INTO M002_FG2_2
SELECT * FROM M002_FG2

-- Identity hinzuf¸gen per Designer
-- Extras -> Optionen -> Designer -> Speichern von Ver‰nderungen verhindern, die die Neuerstellung der Tabelle erfordern

-- Tabellenstruktur kopieren
SELECT TOP 0 *
INTO Test
FROM M002_FG2_2

-- Salamitaktik
-- Groﬂe Tabellen in kleinere Tabellen aufteilen

CREATE TABLE M002_Umsatz
(
	datum date,
	umsatz float
)

BEGIN TRANSACTION
DECLARE @i int = 0
WHILE @i < 100000
BEGIN
		INSERT INTO M002_Umsatz VALUES
		(DATEADD(DAY, FLOOR(RAND()*1095), '20210101'), RAND() * 1000)
		SET @i += 1
END
COMMIT

SELECT * FROM M002_Umsatz

TRUNCATE TABLE M002_Umsatz

SELECT * FROM M002_Umsatz ORDER BY datum DESC

/*
	Pl‰ne:
	Zeigt den genauen Ablauf einer Abfrage + Details an
	Aktivieren mit dem Button "Tats‰chlichen Ausf¸hrungsplan einschlieﬂen"

	Wichtigen Werte:
	-Operatorkosten: Prozentualer Anteil des Leistungsverbrauch der Abfrage
	-Anzahl der Zeilen
*/
-- 2 Pfade
SELECT * FROM M002_Umsatz
UNION ALL
SELECT * FROM M002_Umsatz

SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2021 -- Alle 100000 Zeilen m¸ssen durchsucht werden
-------------------------------------------------------------------------------------------------

CREATE TABLE M002_Umsatz2021
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2021
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2021

SELECT * FROM M002_Umsatz2021

------------------------------------------------
CREATE TABLE M002_Umsatz2022
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2022
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2022
----------------------------------------------------------------

CREATE TABLE M002_Umsatz2023
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2023
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2023