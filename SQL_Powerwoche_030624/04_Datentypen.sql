/*
	Datentypen in SQL: 3 große Gruppen

	1. Charakter/String Datentypen:

	char(10) = 'Hallo     ' => 10 Byte => UTF-8
	nchar(10) = 'Hallo     ' => 20 Byte => UTF-16

	varchar(10) = 'Hallo' => 5 Byte was verwendet wird
	nvarchar(10) = 'Hallo' => 10 Byte => Pro Charakter = 2 Byte 
	-> Weil UTF-16

	Legacy: text --> mittlerweile VARCHAR(MAX) = bis zu 2GB GROß
	varchar(8000) & nvarchar(4000) sind maximum


	2. Numerische Datentypen
	tinyint = 8 Bit = 1 Byte = -255 bis 255
	smallint = 16 Bit = 2 Byte = -32k bis 32k
	int = 32 Bit = 4 Byte = -2,14Mrd bis 2,14Mrd => Primary Key
	bigint = 64 Bit = 8 Byte = -9,2 Trillion bis 9,2 Trillion

	double = Kommazahl
	float = Kommazahl => wesentlich Präziser

	decimal(x, y) = x Ziffern insgesamt, davon sind y Ziffern Nachkommastellen
	decimal(10,2) = 10 Ziffern insgesamt, davon sind 2 Ziffern Nachkommastellen
	money = ca. 9,2 Trillion
	smallmoney = ca 214 Tausend



	bit = 1 oder 0 (True = 1, False = 0) => Es gibt kein Bool!

	3. Datum/Zeit Datentypen
	date = YYYY-MM-DD
	time = hh:mm:ss.nnnnnnn
	datetime = date + time in MS = YYYY-MM-DD hh:mm:ss.mmm
	datetime2 = YYYY-MM-DD hh:mm:ss.nnnnnnn
	smalldatetime = präzise bis Sekunden = YYYY-MM-DD hh:mm:ss

	Andere:
	XML
	JSON
	geometry
	geography
*/

SELECT * FROM Employees