-- Pour calc le nb de billets, il suffit de lire la table des spectateurs
SELECT COUNT(*) FROM Spectateur;
-- Et donc pour avoir le prix on multiplie par le prix des billets
SELECT COUNT(*) * 30 FROM Spectateur;


-- Pour justifier nos finances, on a le excel et on peut aussi utiliser les salaires renseingés dans Personne
SELECT SUM(salaireHoraireMini) * 40 FROM Personne;
-- Pourquoi 40? parce que c'est la duree totale de notre festival. On peut la calculer aussi avec la requete n°4 de requetes_sol.sql


-- Pour supp des events ou en rajouter, il suffit d'utiliser soit
-- INSERT INTO table VALUES (a,b,c), (d,e,f)
-- ou 
-- DELETE FROM table WHERE b = 2; 
-- Faites attention au cle etrangere

-- Pour avoir les détails de frequentation sur une journee ou une competition il suffit de select les competitions avec la date demandee
-- Exemple pour la frequentation de toutes les competitions
--SELECT c.NomCompetition, COUNT(DISTINCT r.NumPersonne)+COUNT(DISTINCT s.NumPersonne) AS freq FROM Competition AS c
--JOIN Spectateur AS s ON s.NumCompetition = c.NumCompetition
--JOIN Role AS r ON r.NumCompetition = c.NumCompetition AND s.NumPersonne <> r.NumPersonne
--GROUP BY c.NumCompetition
--ORDER BY freq; -- A tester

--SELECT c.NomCompetition, COUNT(DISTINCT r.NumPersonne) AS freq 
--FROM Competition AS c, Role AS r
--WHERE r.NumCompetition = c.NumCompetition
--GROUP BY c.NumCompetition
--ORDER BY freq; -- A tester

--SELECT c.NomCompetition, COUNT(DISTINCT s.NumPersonne)+COUNT(DISTINCT s.NumPersonne) AS freq 
--FROM Competition AS c, Spectateur AS s, Role AS r
--WHERE s.NumCompetition = c.NumCompetition or r.NumCompetition = c.NumCompetition
--GROUP BY c.NumCompetition
--ORDER BY freq;

--Ok la solution avec de la triche et des operateurs ensemblistes
WITH personnes AS (SELECT NumCompetition, NumPersonne FROM Spectateur UNION SELECT NumCompetition, NumPersonne FROM Role)
SELECT c.NomCompetition, COUNT(p.NumPersonne) AS freq FROM personnes AS p
JOIN Competition AS c ON c.NumCompetition = p.NumCompetition
GROUP BY p.NumCompetition, c.NomCompetition
ORDER BY freq;

-- Pour export nos resultats de requetes dans des CSV tres jolis (c'est faux c'est pas joli)
-- On peut tout simplement faire \copy (requete sql) TO 'path_to_file.csv' with CSV HEADER
-- Pas de de ';' et le fichier est disponible au chemin indique (si vous utiliser un docker faudra faire un docker cp conteneur:/path_to_file.csv .)

-- #####################################################################################################################################################
-- Entrainnement obligatoire
-- #####################################################################################################################################################

-- infos financières
SELECT COUNT(*) * 30 AS argent_rentrant FROM Spectateur;

SELECT COUNT(*) * 30 AS argent_rentrant_sportif FROM Role
WHERE bSportif = 1;

SELECT COUNT(*)*12*2 AS argent_sortant_arbitre FROM Role
WHERE bArbitre = 1;

SELECT COUNT(*)*20*2 AS argent_sortant_organisateur FROM Role
WHERE bOrga = 1;

--Tout en une ligne, oui c'est moche mais bon

SELECT (
    SELECT COUNT(*) * 30  
    FROM Spectateur
    ) + (
        SELECT COUNT(*) * 30
        FROM Role 
        WHERE bSportif = 1) - (
                              SELECT COUNT(*)*12*2 
                              FROM Role 
                              WHERE bArbitre = 1) - (
                                                     SELECT COUNT(*)*20*2 
                                                     FROM Role
                                                     WHERE bOrga = 1)
AS bilan_financier;

-- horaire des compèt 1 et 12
SELECT DateCompetition
FROM Competition
WHERE NumCompetition = 1 or NumCompetition = 12;
-- Pour n'avoir que l'heure :
-- select DateCompetition::time

---******************************************************
--- à faire...
---******************************************************

-- liste des personnels avec leurs données financières et le nom de leur employeur principal | "leurs données financières" i.e. leur salaire ? 
--                                                                                              Si oui, on les paies à leur présence ou c'est leur salaire 
--                                                                                              minimultiplié par le nombre d'heures possibles, même si ils ne 
--                                                                                              sont pas là ?

-- liste des inscrits (sportifs) montant récolté par leurs inscriptions | déjà fait il me semble
-- nombre maximum d’argent récoltable en fonction de la capacité utile


-- Afficher les competitions dispo pour un sport
--Exemple : Basketball
--Problème : ne prend pas en compte les compétitions sans spectateurs

SELECT NomCompetition, DateCompetition, COUNT(DISTINCT Spectateur.NumPersonne), COUNT(DISTINCT Role.NumPersonne), Gymnase.capaciteMaxGymnase
FROM Competition
JOIN Sport ON Competition.NumSport = Sport.NumSport
JOIN Role ON Competition.NumCompetition = Role.NumCompetition
JOIN Spectateur ON Spectateur.NumCompetition = Competition.NumCompetition
JOIN Gymnase ON Gymnase.NumGymnase = Competition.NumGymnase
WHERE NomSport = 'Basketball'
GROUP BY Competition.NumCompetition, Gymnase.capaciteMaxGymnase
HAVING COUNT(DISTINCT Spectateur.NumPersonne) + COUNT(DISTINCT Role.NumPersonne) < Gymnase.capaciteMaxGymnase;



--COUNT(DISTINCT Spectateur.NumPersonne),








