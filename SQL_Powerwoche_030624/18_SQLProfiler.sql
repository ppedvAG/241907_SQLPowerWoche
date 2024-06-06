/*
	-- Profiler
	-- Live-Verfolgung was auf unsere DB passiert
	-- Kann in weiterer Folge für den DB-Optimierer verwendet werden

	-- Extras -> SQL Server Profiler

	-- Einstellungen auf der ersten Seite setzen
	-- Events auswählen auf dem zweiten Reiter
	    ---- StmtStarted
		---- StmtCompleted
		---- BatchStarted
		---- BatchCompleted
		---- ....
-- DatabaseName LIKE Name

-------------------------------------------------------

-- Nach der Trace -> Tuning Advisor

-- Tools -> Database Engine Tuning Advisor

-- Trace File laden oder Query Store auswählen

-- Tuning Options -> Indizes und/oder Partitionen auswählen

-- Oben -> Start Analysis

-- Actions -> Apply Recommendations
*/