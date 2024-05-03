-- Q1
SELECT NomPersonne AS Nom, PrenomPersonne AS Prenom
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bSportif=1;

-- Q2
SELECT NomPersonne AS Nom, PrenomPersonne AS Prenom 
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bSportif=1 AND bArbitre=0 AND bOrga=0;

-- Q3
SELECT COUNT(*) AS nb_competitions
FROM SportCompetition
WHERE NumSport=115458;

-- Q4
SELECT SUM(DureeCompetition) AS duree_max
FROM Competition;

-- Sol avec overlap Q4
-- Utilisable en psql uniquement
WITH cte AS (
  SELECT DateCompetition FROM Competition
  UNION
  SELECT DateCompetition + (DureeCompetition * INTERVAL '1 minute') FROM Competition
),

cte_fin AS (
  SELECT DateCompetition AS StartDate, LEAD(DateCompetition) OVER (ORDER BY DateCompetition) + (-1 * INTERVAL '1 minute') AS EndDate FROM cte)

SELECT SUM(AGE(EndDate, StartDate)) + COUNT(*) * INTERVAL '1 minute' AS duree_totale -- On compense les minutes retirees pour calculer les intervales de temps
FROM cte_fin
WHERE EndDate IS NOT NULL;
--SELECT SUM(DureeCompetition)
--FROM cte_fin AS cf CROSS APPLY (Competition AS c)
--WHERE cf.EndDate IS NOT NULL;
--AND cf.StartDate BETWEEN c.DateCompetition AND (c.DateCompetition + c.DureeCompetition * INTERVAL '1 minute')
--GROUP BY c.NumCompetitio;

-- Q5
SELECT AVG(salaireHoraireMini) AS salaire_moyen_arbitre
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bArbitre=1;

-- Q6
-- Alors la, va falloir m'expliquer c'est quoi le salaire moyen min d'un gymnase
SELECT NomGymnase, AVG(salaireHoraireMini) AS salaire_moyen_gymnase
FROM Role AS r
JOIN Personne AS p ON p.NumPersonne=r.NumPersonne
JOIN Gymnase AS g ON g.NumGymnase=r.NumGymnase
GROUP BY NumGymnase, NomGymnase;

-- Q7
SELECT NomSport, NomGymnase
FROM SportGymnase AS SG
JOIN Gymnase AS G ON G.NumGymnase=SG.NumGymnase
JOIN Sport AS S ON S.NumSport=SG.NumSport;

-- Q8
SELECT NomGymnase
FROM SportGymnase AS sg
JOIN Gymnase AS g ON g.NumGymnase=sg.NumGymnase
EXCEPT
SELECT NomGymnase
FROM SportCompetition AS sc
JOIN SportGymnase AS sg ON sg.NumSport=sc.NumSport
JOIN Gymnase AS g ON g.NumGymnase=sg.NumGymnase;

-- Q9
SELECT SUM(capaciteMaxGymnase) AS max_cap
FROM Gymnase
WHERE adresseGymnase LIKE '%Mourenx%';

-- Q10
-- petit doute sur celle ci
SELECT SUM(salaireHoraireMini) AS cout_encadrement
FROM Role AS r
JOIN Personne AS p ON p.NumPersonne=r.NumPersonne
JOIN Competition AS c ON c.NumCompetition=r.NumCompetition
JOIN SportCompetition AS sc ON sc.NumCompetition=r.NumCompetition
JOIN SportGymnase AS sg ON sg.NumSport=sc.NumSport
WHERE r.bArbitre=1 OR r.bOrga=1 AND r.NumGymnase=123 AND sc.NumSport=115458;

