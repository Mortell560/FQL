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
SELECT c.NomCompetition, COUNT(p.NumPersonne) AS freq, DateCompetition FROM personnes AS p
JOIN Competition AS c ON c.NumCompetition = p.NumCompetition
GROUP BY p.NumCompetition, c.NomCompetition, c.DateCompetition
ORDER BY freq;

-- Pour export nos resultats de requetes dans des CSV tres jolis (c'est faux c'est pas joli)
-- On peut tout simplement faire \copy (requete sql) TO 'path_to_file.csv' with CSV HEADER
-- Pas de de ';' et le fichier est disponible au chemin indique (si vous utiliser un docker faudra faire un docker cp conteneur:/path_to_file.csv .)

-- #####################################################################################################################################################
-- Entrainnement obligatoire
-- #####################################################################################################################################################

-- infos financières
SELECT COUNT(*) * 30 AS argent_rentrant_spectateur FROM Spectateur;

SELECT COUNT(*) * 30 AS argent_rentrant_sportif FROM Role
WHERE bSportif = 1;

-- Si on veut la somme pour les deux requetes suivantes il suffit de mettre ça dans une subrequest
--SELECT COUNT(*)*12* c.DureeCompetition/60 AS argent_sortant_arbitre FROM Role AS r
--JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
--WHERE bArbitre = 1;
SELECT c.NomCompetition, COUNT(r.NumPersonne) * 12 * c.DureeCompetition/60 AS argent_sortant_arbitre
FROM Role AS r
JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
WHERE bArbitre = 1
GROUP BY c.NumCompetition, c.NomCompetition;


--SELECT COUNT(*)*20* c.DureeCompetition/60 AS argent_sortant_organisateur FROM Role
--JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
--WHERE bOrga = 1;
SELECT c.NomCompetition, COUNT(r.NumPersonne) * 20 * c.DureeCompetition/60 AS argent_sortant_organisateur
FROM Role AS r
JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
WHERE bOrga = 1
GROUP BY c.NumCompetition, c.NomCompetition;

-- horaire des compèt 1 et 12
SELECT DateCompetition
FROM Competition
WHERE NumCompetition = 1 or NumCompetition = 12;
-- Pour n'avoir que l'heure :
-- select DateCompetition::time

---******************************************************
--- à faire...
---******************************************************

-- Pour compèt 1 et 12 - liste des personnels avec leurs données financières et le nom de leur employeur principal
-- Solution supposant le non-overlapping (Sinon faut utiliser les deux sous-requests de la question 4)
SELECT p.NomPersonne, p.PrenomPersonne, c.DureeCompetition/60 * p.salaireHoraireMini AS salaire_du, pemp.NomPersonne AS NomEmployeur, pemp.PrenomPersonne AS PrenomEmployeur
FROM Role AS r
JOIN Personne AS p ON p.NumPersonne = r.NumPersonne
JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
JOIN Personne AS pemp ON pemp.NumPersonne = p.NumEmployeurPrincipal;
-- Ajouter un WHERE pour specifier la competition

-- Pour compèt 1 et 12 - liste des inscrits (sportifs) montant récolté par leurs inscriptions | déjà fait il me semble
-- nombre maximum d’argent récoltable en fonction de la capacité utile
WITH personnes AS (SELECT NumCompetition, NumPersonne FROM Role WHERE bOrga=1 OR bArbitre=1 AND bSportif=0)
SELECT (SUM(g.capaciteMaxGymnase)-COALESCE(COUNT(pe.NumPersonne)))*30 AS argent_recoltable FROM personnes AS pe
LEFT JOIN Competition AS c ON c.NumCompetition = pe.NumCompetition
LEFT JOIN Gymnase AS g ON g.NumGymnase = c.NumGymnase;

-- Données financières de la compèt 21

SELECT COUNT(*) * 30 AS argent_rentrant_spectateur FROM Spectateur
WHERE NumCompetition=21;

SELECT COUNT(*) * 30 AS argent_rentrant_sportif FROM Role
WHERE bSportif = 1 AND NumCompetition=21;

SELECT c.NomCompetition, COUNT(r.NumPersonne) * 12 * c.DureeCompetition/60 AS argent_sortant_arbitre
FROM Role AS r
JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
WHERE bArbitre = 1 AND c.NumCompetition=21
GROUP BY c.NomCompetition, c.DureeCompetition;

SELECT c.NomCompetition, COUNT(r.NumPersonne) * 20 * c.DureeCompetition/60 AS argent_sortant_organisateur
FROM Role AS r
JOIN Competition AS c ON c.NumCompetition = r.NumCompetition
WHERE bOrga = 1 AND c.NumCompetition=21
GROUP BY c.NomCompetition, c.DureeCompetition;

-- Justifier les dépenses de nos mairies concernant le festival après ces dernières inscriptions
-- Avec une compétition, on est riche. Point final



-- Afficher les competitions dispo pour un sport
--Exemple : Basketball
SELECT c.NomCompetition, c.DateCompetition, COALESCE(COUNT(DISTINCT s.NumPersonne)) AS nb_spectateurs, COALESCE(COUNT(DISTINCT r.NumPersonne)) AS nb_sportifs_et_autres, g.capaciteMaxGymnase, g.NomGymnase
FROM Competition AS c
JOIN SportGymnase AS sg ON sg.NumGymnase = c.NumGymnase AND sg.NumSport = c.NumSport
JOIN Sport AS sp ON sg.NumSport = sp.NumSport
LEFT JOIN Role AS r ON c.NumCompetition = r.NumCompetition
LEFT JOIN Spectateur AS s ON s.NumCompetition = c.NumCompetition
JOIN Gymnase AS g ON g.NumGymnase = sg.NumGymnase
WHERE sp.NomSport LIKE 'Basketball'
GROUP BY c.NumCompetition, c.NomCompetition, g.capaciteMaxGymnase, g.NomGymnase
HAVING COALESCE(COUNT(DISTINCT s.NumPersonne)) + COALESCE(COUNT(DISTINCT r.NumPersonne)) < g.capaciteMaxGymnase;

--Soutenance :

--2)
INSERT INTO Competition VALUES (22, 'Ball Busters', 120, '2024-06-27 08:00:00', 1, 32, 4, 8, 1, 43);)
INSERT INTO Role VALUES (1,22,0,1,1);
INSERT INTO Role VALUES (12,22,0,1,0);
INSERT INTO Role VALUES (18,22,0,1,0);
INSERT INTO Role VALUES (20,22,0,1,0);
INSERT INTO Role VALUES (1001, 22, 1, 0, 0);
INSERT INTO Role VALUES (1002, 22, 1, 0, 0);
INSERT INTO Role VALUES (1003, 22, 1, 0, 0);

SELECT * FROM Competition WHERE NumCompetition = 22;

--3)
SELECT c.NumCompetition, c.NomCompetition
FROM Spectateur AS s
JOIN Competition AS c ON c.Numcompetition=s.NumCompetition
WHERE NumPersonne=1003 /*petit fils*/

INTERSECT

SELECT c.NumCompetition, c.NomCompetition
FROM Spectateur AS s
JOIN Competition AS c ON c.Numcompetition=s.NumCompetition
WHERE NumPersonne=1001; /*Bob*/

--4)
SELECT c.NomCompetition, c.DateCompetition, g.NomGymnase, p2.NomPersonne
FROM Competition AS c
JOIN SportGymnase AS sg ON sg.NumGymnase = c.NumGymnase AND sg.NumSport = c.NumSport
LEFT JOIN Role AS r ON c.NumCompetition = r.NumCompetition
LEFT JOIN Spectateur AS s ON s.NumCompetition = c.NumCompetition
JOIN Gymnase AS g ON g.NumGymnase = sg.NumGymnase
JOIN Personne AS p ON p.NumPersonne=r.NumPersonne
JOIN Personne AS p2 ON c.NumChef = p2.NumPersonne
WHERE p.NomPersonne='Bob' AND p.PrenomPersonne = 'Mauranne'
GROUP BY c.NumCompetition, c.NomCompetition, g.capaciteMaxGymnase, g.NomGymnase, p2.NomPersonne
HAVING COALESCE(COUNT(DISTINCT s.NumPersonne)) + COALESCE(COUNT(DISTINCT r.NumPersonne)) >= 5;


-- Question 5
SELECT c.NomCompetition, c.DateCompetition, COALESCE(COUNT(DISTINCT s.NumPersonne)) AS nb_spectateurs, COALESCE(COUNT(DISTINCT r.NumPersonne)) AS nb_sportifs_et_autres, g.capaciteMaxGymnase, g.NomGymnase
FROM Competition AS c
JOIN SportGymnase AS sg ON sg.NumGymnase = c.NumGymnase AND sg.NumSport = c.NumSport
JOIN Sport AS sp ON sg.NumSport = sp.NumSport
LEFT JOIN Role AS r ON c.NumCompetition = r.NumCompetition
LEFT JOIN Spectateur AS s ON s.NumCompetition = c.NumCompetition
JOIN Gymnase AS g ON g.NumGymnase = sg.NumGymnase
WHERE sp.NomSport LIKE 'Basketball'
GROUP BY c.NumCompetition, c.NomCompetition, g.capaciteMaxGymnase, g.NomGymnase
HAVING COALESCE(COUNT(DISTINCT s.NumPersonne)) + COALESCE(COUNT(DISTINCT r.NumPersonne)) < g.capaciteMaxGymnase AND g.capaciteMaxGymnase - COALESCE(COUNT(DISTINCT s.NumPersonne)) + COALESCE(COUNT(DISTINCT r.NumPersonne)) >= 10;
-- Ou
SELECT * 
FROM Gymnase 
WHERE capaciteMaxGymnase > 10;






