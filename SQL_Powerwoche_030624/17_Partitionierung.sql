/*
	Partitionierung:
	Aufteilung in "mehrere" Tabellen
	Einzelne Tabellen bleibt bestehen, aber intern werden die Daten partitioniert
*/

-- Anfordungen
-- Partitionsfunktion: Stellt die Bereiche dar (0-100, 101-200, 201-Ende)
-- Partitionsschema: Weist die einzelnen Partition auf Dateigruppen zu

-- 0-100-200-Ende
CREATE PARTITION FUNCTION pf_Zahl(int) AS
RANGE LEFT FOR VALUES(100, 200)

-- Für ein Partitionsschema muss immer eine extra Dateigruppe existieren
CREATE PARTITION SCHEME sch_ID as
PARTITION pf_Zahl TO (P1, P2, P3)

-- Dateigruppe nachher hinzufügen
ALTER DATABASE Demo2 ADD FILEGROUP P1

ALTER DATABASE Demo2
ADD FILE
(
	NAME = N'P1',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P1.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
) TO FILEGROUP P1

-- C:\_SQLDATA\P1.ndf

ALTER DATABASE Demo2
ADD FILE
(
	NAME = N'P2',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P2.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
) TO FILEGROUP P2

ALTER DATABASE Demo2
ADD FILE
(
	NAME = N'P3',
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P3.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
) TO FILEGROUP P3

--------------------------------------------------
-- Hier muss die Tabelle auf das Schema gelegt werden
CREATE TABLE M003_Test
(
	id int identity,
	zahl float
) ON sch_ID(id)

BEGIN TRANSACTION
DECLARE @i int = 0
WHILE @i < 1000
BEGIN
	INSERT INTO M003_Test VALUES (RAND() * 1000)
	SET @i += 1
END
COMMIT

-- Nichts besonderes zu sehen
SELECT * FROM M003_Test

SELECT * FROM M003_Test
WHERE ID < 50

-- Übersicht über Partition verschaffen
SELECT OBJECT_NAME(OBJECT_ID), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

SELECT $partition.pf_Zahl(50)
SELECT $partition.pf_Zahl(150)
SELECT $partition.pf_Zahl(250)

-- Pro Datensatz die Partition
SELECT * FROM M003_Test t
JOIN
(
	SELECT name, ips.partition_number
	FROM sys.filegroups as fg -- Name

	JOIN sys.allocation_units as au
	on fg.data_space_id = au.data_space_id

	JOIN sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED') as ips
	ON ips.hobt_id =au.container_id

	WHERE OBJECT_NAME(ips.object_id) = 'M003_Test'
) x
ON $partition.pf_Zahl(t.id) = x.partition_number


-- Übung
/*
	- Erstelle 2 Dateigruppen (Test1, Test2)
	- Erstelle 2 Dateien (jeweils Test1, Test2)

	Erstelle eine Partitionsfunktion Namens (pf_Test)
	die von Links die Werte ausließt (0-500, 501-1000)

	Erstelle ein Partitionsschema Namens (sch_Test)
	als Partition für (pf_Test) zu (Test1, Test2)

	Lege eine Tabelle auf das Schema und befülle diese


*/

