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
SELECT NomCompetition, COUNT(*) AS freq FROM Competition AS c
JOIN Spectateur AS s ON s.NumCompetition = c.NumCompetition
JOIN Role AS r ON r.NumCompetition = c.NumCompetition
GROUP BY NumCompetition
ORDER BY freq; -- A tester

