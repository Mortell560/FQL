-- Q1) Liste des sportifs
SELECT distinct R.NumPersonne AS id, NomPersonne AS Nom, PrenomPersonne AS Prenom
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bSportif=1;

-- Q2) Liste des sportifs qui ne sont ni organisateur ni arbitre
/*
SELECT NomPersonne AS Nom, PrenomPersonne AS Prenom 
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bSportif=1 AND bArbitre=0 AND bOrga=0;
*/
SELECT NomPersonne AS Nom, PrenomPersonne AS Prenom 
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bSportif=1
EXCEPT
SELECT NomPersonne AS Nom, PrenomPersonne AS Prenom 
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bArbitre=1 or bOrga=1;

-- Q3) Nombre de competition pour le sport 115458
SELECT COUNT(*) AS nb_competitions
FROM Competition
WHERE NumSport=115458;

-- Q4) Duree max pour un sportif qui assiste à toutes les compèt

-- Somme de la durée de toute de les compétitions
SELECT SUM(DureeCompetition) AS duree_max
FROM Competition;

-- Cas où on ne compte pas les sports simultanés (+ une compétition ne commence et ne finit pas quand une compétition est en cours)
SELECT COUNT(Distinct DateCompetition)*120 AS duree_totale
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
WHERE AGE(EndDate, StartDate) <= '2 hour';

--SELECT SUM(DureeCompetition)
--FROM cte_fin AS cf CROSS APPLY (Competition AS c)
--WHERE cf.EndDate IS NOT NULL;
--AND cf.StartDate BETWEEN c.DateCompetition AND (c.DateCompetition + c.DureeCompetition * INTERVAL '1 minute')
--GROUP BY c.NumCompetitio;

-- Q5) Salaire moyen minimum des arbitre

-- Pas de distinction entre les arbitres (même si c'est a même personne)
SELECT AVG(salaireHoraireMini)
FROM Role AS R
JOIN Personne AS P ON P.NumPersonne=R.NumPersonne
WHERE bArbitre=1;

-- Méthode triche
SELECT *
FROM Personne
WHERE salaireHoraireMini=12 or salaireHoraireMini=32;

-- Q6) Salaire moyen minimum des gymnases
-- Alors la, va falloir m'expliquer c'est quoi le salaire moyen min d'un gymnase
-- Somme de tous les salaires divisée par le nombre de gymnase

--SELECT 
--(SELECT SUM(p.salaireHoraireMini) FROM Role AS r JOIN Personne AS p ON p.NumPersonne=r.NumPersonne WHERE bArbitre=1 or bOrga=1) /COUNT(*) AS SalaireGymnase
--FROM Gymnase;

SELECT g.NomGymnase, SUM(salaireHoraireMini)/COUNT(*) AS salaireGymnasee
FROM Role AS r
JOIN Personne AS p ON p.NumPersonne = r.NumPersonne
JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
JOIN Gymnase AS g ON g.NumGymnase = c.NumGymnase
WHERE r.bArbitre = 1 OR r.bOrga = 1
GROUP BY c.NumGymnase, g.NomGymnase;

-- Q7) Les couples (sport, gymnase) possibles
SELECT NomSport, NomGymnase
FROM SportGymnase AS SG
JOIN Gymnase AS G ON G.NumGymnase=SG.NumGymnase
JOIN Sport AS S ON S.NumSport=SG.NumSport;

-- Q8) Les competitions et les gymnases qui ne peuvent pas les recevoir

SELECT NomSport, NomGymnase
FROM SportGymnase
JOIN Sport ON SportGymnase.NumSport <> Sport.NumSport
JOIN Gymnase ON SportGymnase.NumGymnase <> Gymnase.NumGymnase
EXCEPT 
SELECT NomSport, NomGymnase
FROM SportGymnase
JOIN Sport ON SportGymnase.NumSport = Sport.NumSport
JOIN Gymnase ON SportGymnase.NumGymnase = Gymnase.NumGymnase;

-- Refaire la question par problème de compréhension

-- Q9) Capacité totale en nombre de personnes si tous les gymnases sont utilisés en même temps
SELECT SUM(capaciteMaxGymnase) AS max_cap
FROM Gymnase
WHERE adresseGymnase LIKE '%Mourenx%';

-- Q10) Coût de l'encadrement du sport 115458 s'il y a eu le nombre max de sportifs et dans le gymnase 123
SELECT SUM(salaireHoraireMini) AS cout_encadrement
FROM Role AS r
JOIN Personne AS p ON p.NumPersonne=r.NumPersonne
JOIN Competition AS c ON c.NumCompetition=r.NumCompetition
WHERE c.NumGymnase=123 AND c.NumSport=115458 AND (bArbitre = 1 OR bOrga = 1);
