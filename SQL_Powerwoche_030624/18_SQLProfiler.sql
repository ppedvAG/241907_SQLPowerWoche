/*
	-- Profiler
	-- Live-Verfolgung was auf unsere DB passiert
	-- Kann in weiterer Folge f�r den DB-Optimierer verwendet werden

	-- Extras -> SQL Server Profiler

	-- Einstellungen auf der ersten Seite setzen
	-- Events ausw�hlen auf dem zweiten Reiter
	    ---- StmtStarted
		---- StmtCompleted
		---- BatchStarted
		---- BatchCompleted
		---- ....
-- DatabaseName LIKE Name

-------------------------------------------------------

-- Nach der Trace -> Tuning Advisor

-- Tools -> Database Engine Tuning Advisor

-- Trace File laden oder Query Store ausw�hlen

-- Tuning Options -> Indizes und/oder Partitionen ausw�hlen

-- Oben -> Start Analysis

-- Actions -> Apply Recommendations
*/