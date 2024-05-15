-- Content from file init --
-- On retire toutes les tables si elles existent deja
-- Marche en postgresql uniquement
--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;
--GRANT ALL ON SCHEMA public TO postgres;
--GRANT ALL ON SCHEMA public TO public;

DROP TABLE IF EXISTS Spectateur CASCADE;
DROP TABLE IF EXISTS SportGymnase CASCADE;
DROP TABLE IF EXISTS SportCompetition CASCADE;
DROP TABLE IF EXISTS Competition CASCADE;
DROP TABLE IF EXISTS Role CASCADE;
DROP TABLE IF EXISTS Sport CASCADE;
DROP TABLE IF EXISTS Gymnase CASCADE;
DROP TABLE IF EXISTS Personne CASCADE;


-- Schema

CREATE TABLE Personne(
  NumPersonne BIGINT PRIMARY KEY NOT NULL, 
  NomPersonne VARCHAR(100) NOT NULL,
  PrenomPersonne VARCHAR(100) NOT NULL,
  anneeNaissancePersonne INT,
  TelPersonne VARCHAR(16),
  NumEmployeurPrincipal BIGINT,
  salaireHoraireMini NUMERIC(9,2),
  FOREIGN KEY(NumEmployeurPrincipal) REFERENCES Personne(NumPersonne)
);

CREATE TABLE Gymnase(
  NumGymnase BIGINT PRIMARY KEY NOT NULL,
  NomGymnase TEXT NOT NULL,
  adresseGymnase TEXT NOT NULL,
  capaciteMaxGymnase INT NOT NULL
);

CREATE TABLE Sport (
  NumSport BIGINT PRIMARY KEY NOT NULL,
  NomSport TEXT
);

CREATE TABLE SportGymnase (
  NumGymnase BIGINT NOT NULL,
  NumSport BIGINT NOT NULL,
  FOREIGN KEY(NumGymnase) REFERENCES Gymnase(NumGymnase),
  FOREIGN KEY(NumSport) REFERENCES Sport(NumSport),
  PRIMARY KEY(NumGymnase, NumSport)
);

CREATE TABLE Competition (
  NumCompetition BIGINT PRIMARY KEY NOT NULL,
  NomCompetition TEXT NOT NULL,
  DureeCompetition INT NOT NULL,
  DateCompetition TIMESTAMP NOT NULL,
  NumChef BIGINT NOT NULL,
  besoin_min_sportifs INT NOT NULL,
  besoin_min_arbitre INT NOT NULL,
  nb_Max_sportif_par_arbitre INT NOT NULL,
  NumSport BIGINT NOT NULL,
  NumGymnase BIGINT NOT NULL,
  FOREIGN KEY(NumChef) REFERENCES Personne(NumPersonne),
  FOREIGN KEY(NumGymnase, NumSport) REFERENCES SportGymnase(NumGymnase, NumSport)
);

CREATE TABLE Role (
  NumPersonne BIGINT NOT NULL,
  NumCompetition BIGINT NOT NULL,
  bSportif INT DEFAULT 0 NOT NULL,
  bArbitre INT DEFAULT 0 NOT NULL,
  bOrga INT DEFAULT 0 NOT NULL,
  FOREIGN KEY (NumPersonne) REFERENCES Personne(NumPersonne),
  FOREIGN KEY (NumCompetition) REFERENCES Competition(NumCompetition),
  PRIMARY KEY(NumPersonne, NumCompetition)
);

CREATE TABLE Spectateur(
  NumPersonne BIGINT NOT NULL,
  NumCompetition BIGINT NOT NULL,
  FOREIGN KEY(NumPersonne) REFERENCES Personne(NumPersonne),
  FOREIGN KEY(NumCompetition) REFERENCES Competition(NumCompetition),
  PRIMARY KEY(NumPersonne, NumCompetition)
);


-- Peut-etre mettre auto increment en fonction des donnees de la prof

-- Contraintes sur le Schema



-- Content from file Personne --
INSERT INTO Personne VALUES (1, 'Tison', 'Alexandre', 2004, '0744493406', 1, 32);
INSERT INTO Personne VALUES (2, 'Bafour', 'Ambre', 2004, '0615534191', 2, 32);
INSERT INTO Personne VALUES (3, 'Tang', 'Floriane', 2004, '0793585796', 3, 32);
INSERT INTO Personne VALUES (4, 'Sansouci', 'Cammile', 1949, '0652940559', 1, 12);
INSERT INTO Personne VALUES (5, 'Beauchemin', 'Fauna', 1969, '0702991012', 2, 12);
INSERT INTO Personne VALUES (6, 'Vaillancourt', 'Warrane', 1977, '0740946254', 3, 20);
INSERT INTO Personne VALUES (7, 'Sylvain', 'Patrick', 1939, '0742561423', 1, 20);
INSERT INTO Personne VALUES (8, 'Archambault', 'Alice', 1988, '0626168138', 2, 12);
INSERT INTO Personne VALUES (9, 'Chesnay', 'Théophile', 1960, '0621897250', 3, 20);
INSERT INTO Personne VALUES (10, 'Béland', 'Romain', 1972, '0738701152', 1, 12);
INSERT INTO Personne VALUES (11, 'Laberge', 'Sidney', 2000, '0695358105', 2, 20);
INSERT INTO Personne VALUES (12, 'Couturier', 'Alacoque', 1985, '0753501975', 3, 12);
INSERT INTO Personne VALUES (13, 'Gour', 'Mandel', 1957, '0745458986', 1, 20);
INSERT INTO Personne VALUES (14, 'Béland', 'Lucas', 1953, '0723767384', 2, 12);
INSERT INTO Personne VALUES (15, 'Sorel', 'Bradamate', 1946, '0638470411', 3, 20);
INSERT INTO Personne VALUES (16, 'Carignan', 'Mirabelle', 1982, '0753773031', 1, 12);
INSERT INTO Personne VALUES (17, 'Lebel', 'Jesper', 1945, '0631639251', 2, 20);
INSERT INTO Personne VALUES (18, 'Bler', 'Sargent', 1992, '0773504442', 3, 12);
INSERT INTO Personne VALUES (19, 'Émond', 'Searlas', 1947, '0615086127', 1, 20);
INSERT INTO Personne VALUES (20, 'Fongemie', 'Marcel', 1968, '0738692191', 2, 12);
INSERT INTO Personne VALUES (21, 'Couture', 'Odo', 1946, '0681938226', 3, 12);
INSERT INTO Personne VALUES (22, 'Busson', 'Yves', 1993, '0655353665', 1, 12);
INSERT INTO Personne VALUES (23, 'Paradis', 'Fifine', 1946, '0739558779', 2, 20);
INSERT INTO Personne VALUES (24, 'Bourgouin', 'Brice', 1989, '0739415928', 3, 20);
INSERT INTO Personne VALUES (25, 'Thibault', 'Martine', 1997, '0713062144', 1, 20);
INSERT INTO Personne VALUES (26, 'Beaulieu', 'Cher', 1979, '0621559985', 2, 20);
INSERT INTO Personne VALUES (27, 'Noël', 'Arno', 1954, '0670382496', 3, 12);
INSERT INTO Personne VALUES (28, 'Tougas', 'Cendrillon', 1964, '0666509178');
INSERT INTO Personne VALUES (29, 'Martel', 'Burkett', 1941, '0603680993');
INSERT INTO Personne VALUES (30, 'Morin', 'Aceline', 1955, '0749266630');
INSERT INTO Personne VALUES (31, 'Houde', 'Minette', 1965, '0691373441');
INSERT INTO Personne VALUES (32, 'Goudreau', 'Maurelle', 1958, '0697339842');
INSERT INTO Personne VALUES (33, 'Bourget', 'Tanguy', 1980, '0731096448');
INSERT INTO Personne VALUES (34, 'Busson', 'Huette', 1982, '0771258033');
INSERT INTO Personne VALUES (35, 'Lafond', 'Benjamin', 1998, '0614931291');
INSERT INTO Personne VALUES (36, 'Lessard', 'Odette', 1973, '0683687722');
INSERT INTO Personne VALUES (37, 'Berger', 'Roch', 1995, '0671416976');
INSERT INTO Personne VALUES (38, 'Deserres', 'Blondelle', 1938, '0767597630');
INSERT INTO Personne VALUES (39, 'Pellerin', 'Louise', 2002, '0755750946');
INSERT INTO Personne VALUES (40, 'Mathieu', 'Voleta', 1982, '0716985518');
INSERT INTO Personne VALUES (41, 'Mailloux', 'Peverell', 1999, '0681355192');
INSERT INTO Personne VALUES (42, 'Lécuyer', 'Marcelle', 1992, '0713702259');
INSERT INTO Personne VALUES (43, 'Migneault', 'Sébastien', 1954, '0747751157');
INSERT INTO Personne VALUES (44, 'Drouin', 'Lundy', 1970, '0745544966');
INSERT INTO Personne VALUES (45, 'Riel', 'Rule', 1952, '0732067408');
INSERT INTO Personne VALUES (46, 'Coulombe', 'Louise', 1970, '0709882404');
INSERT INTO Personne VALUES (47, 'Margand', 'Christophe', 1952, '0628441433');
INSERT INTO Personne VALUES (48, 'Bilodeau', 'Patrice', 1968, '0675880837');
INSERT INTO Personne VALUES (49, 'Langlais', 'Fitz', 1944, '0658958998');
INSERT INTO Personne VALUES (50, 'Roussel', 'Mallory', 1955, '0600218275');
INSERT INTO Personne VALUES (51, 'Saucier', 'Adrien', 1990, '0629596640');
INSERT INTO Personne VALUES (52, 'Couturier', 'Thibaut', 1981, '0682495676');
INSERT INTO Personne VALUES (53, 'Beauchesne', 'Harcourt', 1941, '0607526781');
INSERT INTO Personne VALUES (54, 'Latourelle', 'Florence', 1981, '0674977628');
INSERT INTO Personne VALUES (55, 'Primeau', 'Donatien', 1946, '0656565220');
INSERT INTO Personne VALUES (56, 'Chouinard', 'Marlon', 1952, '0686409036');
INSERT INTO Personne VALUES (57, 'Savoie', 'Amaury', 1940, '0618230265');
INSERT INTO Personne VALUES (58, 'Potvin', 'Victor', 1955, '0796552661');
INSERT INTO Personne VALUES (59, 'Ferland', 'Babette', 1973, '0709088791');
INSERT INTO Personne VALUES (60, 'Gauthier', 'Sylvie', 1939, '0695057338');
INSERT INTO Personne VALUES (61, 'Laliberté', 'Brice', 1983, '0724543445');
INSERT INTO Personne VALUES (62, 'Compagnon', 'Alexandre', 1997, '0744080354');
INSERT INTO Personne VALUES (63, 'Louis', '"La Roux"', 1988, '0733068020');
INSERT INTO Personne VALUES (64, 'Lalonde', 'Josette', 1974, '0745785243');
INSERT INTO Personne VALUES (65, 'Ratté', 'Scoville', 1944, '0616090265');
INSERT INTO Personne VALUES (66, 'Guay', 'Delit', 1959, '0795109397');
INSERT INTO Personne VALUES (67, 'Chauvin', 'Didier', 1939, '0742278045');
INSERT INTO Personne VALUES (68, 'Leroux', 'Clémence', 1997, '0669120957');
INSERT INTO Personne VALUES (69, 'Durepos', 'Arthur', 1955, '0653242665');
INSERT INTO Personne VALUES (70, 'Paré', 'Felicien', 1947, '0742019685');
INSERT INTO Personne VALUES (71, 'Cyr', 'Henriette', 1978, '0781715050');
INSERT INTO Personne VALUES (72, 'Courcelle', 'Victorine', 1942, '0701784830');
INSERT INTO Personne VALUES (73, 'Bellemare', 'Philippine', 1988, '0796178488');
INSERT INTO Personne VALUES (74, 'Corbeil', 'Hugh', 1974, '0727702437');
INSERT INTO Personne VALUES (75, 'Duval', 'Florence', 1950, '0662694015');
INSERT INTO Personne VALUES (76, 'Legault', 'Théodore', 1939, '0712872422');
INSERT INTO Personne VALUES (77, 'Rocher', 'Lyle', 1995, '0662366129');
INSERT INTO Personne VALUES (78, 'Verreau', 'Paige', 1972, '0611853591');
INSERT INTO Personne VALUES (79, 'Lafrenière', 'Bernard', 1976, '0672813071');
INSERT INTO Personne VALUES (80, 'Lamour', 'Artus', 1956, '0712432890');
INSERT INTO Personne VALUES (81, 'St-Pierre', 'Michel', 1990, '0690840650');
INSERT INTO Personne VALUES (82, 'Croteau', 'Julienne', 1943, '0705673168');
INSERT INTO Personne VALUES (83, 'Marseau', 'Dorene', 1976, '0622381537');
INSERT INTO Personne VALUES (84, 'Deniger', 'Raoul', 1999, '0775335584');
INSERT INTO Personne VALUES (85, 'Paquin', 'Véronique', 1944, '0758079826');
INSERT INTO Personne VALUES (86, 'Moreau', 'Marie', 1991, '0759338199');
INSERT INTO Personne VALUES (87, 'Lamothe', 'Robinette', 1970, '0709946368');
INSERT INTO Personne VALUES (88, 'Coudert', 'Agrican', 1982, '0742523605');
INSERT INTO Personne VALUES (89, 'Dastous', 'Patrick', 1989, '0698140258');
INSERT INTO Personne VALUES (90, 'Leclerc', 'Creissant', 1960, '0744116277');
INSERT INTO Personne VALUES (91, 'Bienvenue', 'Troy', 1980, '0791632335');
INSERT INTO Personne VALUES (92, 'Gamelin', 'Dexter', 1956, '0670985612');
INSERT INTO Personne VALUES (93, 'Fouquet', 'Claudette', 1980, '0770354473');
INSERT INTO Personne VALUES (94, 'Rouleau', 'Gilles', 1990, '0789196933');
INSERT INTO Personne VALUES (95, 'Desruisseaux', 'Searlait', 1954, '0796963463');
INSERT INTO Personne VALUES (96, 'Marois', 'Ogier', 1977, '0647200721');
INSERT INTO Personne VALUES (97, 'Morin', 'Marsilius', 1942, '0664847843');
INSERT INTO Personne VALUES (98, 'Blanchard', 'Coralie', 1967, '0732414917');
INSERT INTO Personne VALUES (99, 'Meunier', 'Leverett', 1996, '0749858466');
INSERT INTO Personne VALUES (100, 'Fluet', 'Namo', 1952, '0637893831');
INSERT INTO Personne VALUES (101, 'Soucy', 'Brier', 2001, '0739100824');
INSERT INTO Personne VALUES (102, 'Gosselin', 'Berangaria', 1944, '0749523159');
INSERT INTO Personne VALUES (103, 'Thivierge', 'Esmeraude', 1982, '0737081424');
INSERT INTO Personne VALUES (104, 'Aucoin', 'Laetitia', 1985, '0672536394');
INSERT INTO Personne VALUES (105, 'Langelier', 'Royce', 1958, '0793791677');
INSERT INTO Personne VALUES (106, 'Fontaine', 'Namo', 1948, '0726391893');
INSERT INTO Personne VALUES (107, 'Baron', 'Léon', 1964, '0609264658');
INSERT INTO Personne VALUES (108, 'DeGrasse', 'Flordelis', 1952, '0741422823');
INSERT INTO Personne VALUES (109, 'Doucet', 'Courtland', 1964, '0774637526');
INSERT INTO Personne VALUES (110, 'Houde', 'Esperanza', 1995, '0763871655');
INSERT INTO Personne VALUES (111, 'Mercure', 'Claudette', 1973, '0666462255');
INSERT INTO Personne VALUES (112, 'Breton', 'Avice', 1938, '0769771462');
INSERT INTO Personne VALUES (113, 'Roux', 'Melodie', 1948, '0720737221');
INSERT INTO Personne VALUES (114, 'Mercier', 'Cher', 1974, '0618883316');
INSERT INTO Personne VALUES (115, 'Bérard', 'Antoine', 1967, '0761307045');
INSERT INTO Personne VALUES (116, 'Arpin', 'Loring', 2003, '0669420924');
INSERT INTO Personne VALUES (117, 'Gosselin', 'Roslyn', 2001, '0649311374');
INSERT INTO Personne VALUES (118, 'Jobin', 'Mavise', 1999, '0705256633');
INSERT INTO Personne VALUES (119, 'Jomphe', 'Amélie', 1958, '0661203174');
INSERT INTO Personne VALUES (120, 'Bellefeuille', 'Avenall', 1991, '0669512578');
INSERT INTO Personne VALUES (121, 'Roy', 'Maryse', 1977, '0776600863');
INSERT INTO Personne VALUES (122, 'Bussière', 'Claire', 1976, '0792205739');
INSERT INTO Personne VALUES (123, 'Vadeboncoeur', 'Jules', 1947, '0619940858');
INSERT INTO Personne VALUES (124, 'Riquier', 'Orane', 1969, '0759274491');
INSERT INTO Personne VALUES (125, 'Lagueux', 'Benoît', 1973, '0626078883');
INSERT INTO Personne VALUES (126, 'Morin', 'Sylvie', 1976, '0601423019');
INSERT INTO Personne VALUES (127, 'Longpré', 'Robinette', 1974, '0642793154');
INSERT INTO Personne VALUES (128, 'Ricard', 'Chapin', 1965, '0786220455');
INSERT INTO Personne VALUES (129, 'Gendron', 'Travers', 1947, '0690289411');
INSERT INTO Personne VALUES (130, 'Beausoleil', 'Avent', 1939, '0705995791');
INSERT INTO Personne VALUES (131, 'Ruest', 'Gay', 1945, '0627846254');
INSERT INTO Personne VALUES (132, 'Batard', 'Audrey', 1973, '0751392874');
INSERT INTO Personne VALUES (133, 'Leblanc', 'Pauline', 1992, '0636904329');
INSERT INTO Personne VALUES (134, 'Riquier', 'Sacripant', 1993, '0798583299');
INSERT INTO Personne VALUES (135, 'Gervais', 'Thomas', 1939, '0739059697');
INSERT INTO Personne VALUES (136, 'Caron', 'Océane', 1981, '0647138869');
INSERT INTO Personne VALUES (137, 'Bédard', 'Dreux', 1955, '0795195631');
INSERT INTO Personne VALUES (138, 'Moïse', 'Loring', 1961, '0701902352');
INSERT INTO Personne VALUES (139, 'Lafontaine', 'Byron', 1950, '0764441163');
INSERT INTO Personne VALUES (140, 'Perrault', 'Clementine', 1993, '0690043187');
INSERT INTO Personne VALUES (141, 'Gaillard', 'Bruce', 1959, '0720344080');
INSERT INTO Personne VALUES (142, 'Richard', 'Brier', 1994, '0710769997');
INSERT INTO Personne VALUES (143, 'Perreault', 'Ferrau', 1989, '0771370186');
INSERT INTO Personne VALUES (144, 'Benjamin', 'Archaimbau', 1959, '0654340629');
INSERT INTO Personne VALUES (145, 'Mercure', 'Aleron', 1943, '0709166686');
INSERT INTO Personne VALUES (146, 'Deschênes', 'Aurore', 1977, '0721233223');
INSERT INTO Personne VALUES (147, 'Turcotte', 'Marlon', 1952, '0777296225');
INSERT INTO Personne VALUES (148, 'Desjardins', 'Élodie', 1978, '0612925242');
INSERT INTO Personne VALUES (149, 'Boisvert', 'William', 1987, '0773265781');
INSERT INTO Personne VALUES (150, 'Chrétien', 'Norris', 1979, '0664907956');
INSERT INTO Personne VALUES (151, 'Aucoin', 'Étienne', 1963, '0654129821');
INSERT INTO Personne VALUES (152, 'Gamache', 'Fabien', 1987, '0742016080');
INSERT INTO Personne VALUES (153, 'Chassé', 'Tempeste', 1972, '0606050458');
INSERT INTO Personne VALUES (154, 'Doucet', 'Halette', 1984, '0733274144');
INSERT INTO Personne VALUES (155, 'Pichette', 'Juliette', 1975, '0618539299');
INSERT INTO Personne VALUES (156, 'Voisine', 'Claude', 1944, '0726426811');
INSERT INTO Personne VALUES (157, 'Norbert', 'Oliver', 1945, '0629262834');
INSERT INTO Personne VALUES (158, 'Barteaux', 'Denis', 1940, '0685949339');
INSERT INTO Personne VALUES (159, 'Lachapelle', 'Philippe', 1953, '0718807863');
INSERT INTO Personne VALUES (160, 'Poirier', 'Élise', 1990, '0636270404');
INSERT INTO Personne VALUES (161, 'Lépicier', 'Roslyn', 1990, '0601521204');
INSERT INTO Personne VALUES (162, 'Boutot', 'Channing', 1941, '0675515324');
INSERT INTO Personne VALUES (163, 'Fresne', 'Marshall', 1961, '0663106164');
INSERT INTO Personne VALUES (164, 'Lacroix', 'Carolos', 1991, '0627355434');
INSERT INTO Personne VALUES (165, 'Daigneault', 'Susanne', 1965, '0647069620');
INSERT INTO Personne VALUES (166, 'Durand', 'Valiant', 1950, '0754784112');
INSERT INTO Personne VALUES (167, 'Poissonnier', 'Josette', 1978, '0695800427');
INSERT INTO Personne VALUES (168, 'Fréchette', 'Jérôme', 1974, '0707128815');
INSERT INTO Personne VALUES (169, 'Bonsaint', 'Royden', 1975, '0748937739');
INSERT INTO Personne VALUES (170, 'Tremblay', 'Alain', 2004, '0603962273');
INSERT INTO Personne VALUES (171, 'Gour', 'Aya', 1978, '0713101052');
INSERT INTO Personne VALUES (172, 'Chnadonnet', 'Auguste', 1953, '0786355087');
INSERT INTO Personne VALUES (173, 'Pelchat', 'Amélie', 1987, '0636427541');
INSERT INTO Personne VALUES (174, 'Tachel', 'Anaïs', 1980, '0797740022');
INSERT INTO Personne VALUES (175, 'Leblanc', 'Antoine', 1955, '0746056743');
INSERT INTO Personne VALUES (176, 'Bernard', 'Mavise', 1960, '0642457686');
INSERT INTO Personne VALUES (177, 'Jalbert', 'Élise', 1992, '0785100718');
INSERT INTO Personne VALUES (178, 'Lévesque', 'Sumner', 1939, '0782985196');
INSERT INTO Personne VALUES (179, 'Meilleur', 'Christabel', 1976, '0779300221');
INSERT INTO Personne VALUES (180, 'Courcelle', 'Ninette', 1966, '0754338547');
INSERT INTO Personne VALUES (181, 'Metivier', 'Tearlach', 1982, '0674204255');
INSERT INTO Personne VALUES (182, 'Desnoyers', 'Orlene', 1952, '0620040789');
INSERT INTO Personne VALUES (183, 'Therrien', 'Latimer', 1958, '0727772075');
INSERT INTO Personne VALUES (184, 'Quirion', 'Dorothée', 1948, '0678794719');
INSERT INTO Personne VALUES (185, 'Brault', 'Aloin', 1944, '0623360440');
INSERT INTO Personne VALUES (186, 'Lagacé', 'Thiery', 1991, '0689042366');
INSERT INTO Personne VALUES (187, 'Lapointe', 'Bertrand', 1965, '0629902757');
INSERT INTO Personne VALUES (188, 'Beaulieu', 'Grégoire', 1972, '0629201007');
INSERT INTO Personne VALUES (189, 'Lemelin', 'Marshall', 1965, '0721194178');
INSERT INTO Personne VALUES (190, 'Labonté', 'Searlas', 2002, '0772760030');
INSERT INTO Personne VALUES (191, 'Benoit', 'Paige', 2004, '0622750764');
INSERT INTO Personne VALUES (192, 'Faucher', 'Verney', 1973, '0754169837');
INSERT INTO Personne VALUES (193, 'Fugère', 'Gilles', 1964, '0774058657');
INSERT INTO Personne VALUES (194, 'Robillard', 'Mignonette', 2003, '0786048416');
INSERT INTO Personne VALUES (195, 'Bélanger', 'Barry', 1997, '0741787526');
INSERT INTO Personne VALUES (196, 'Paimboeuf', 'Tyson', 1994, '0688762625');
INSERT INTO Personne VALUES (197, 'Rousseau', 'Medoro', 1939, '0747222793');
INSERT INTO Personne VALUES (198, 'Senneville', 'Françoise', 2001, '0707016230');
INSERT INTO Personne VALUES (199, 'L''Anglais', 'Fanette', 1993, '0786850709');
INSERT INTO Personne VALUES (200, 'Pelland', 'Didiane', 1954, '0636390213');
INSERT INTO Personne VALUES (201, 'Sarrazin', 'Denis', 1995, '0607538785');
INSERT INTO Personne VALUES (202, 'Beauchamp', 'Etoile', 1947, '0738319196');
INSERT INTO Personne VALUES (203, 'Goudreau', 'Talbot', 1993, '0743083248');
INSERT INTO Personne VALUES (204, 'Paiement', 'Beaufort', 1956, '0738732667');
INSERT INTO Personne VALUES (205, 'Chenard', 'Clarice', 1991, '0756534679');
INSERT INTO Personne VALUES (206, 'Viens', 'Denis', 1974, '0602721912');
INSERT INTO Personne VALUES (207, 'Bonenfant', 'Marlon', 1953, '0636978754');
INSERT INTO Personne VALUES (208, 'Chabot', 'Denise', 1943, '0749428089');
INSERT INTO Personne VALUES (209, 'St-Jean', 'Stéphanie', 1955, '0687672926');
INSERT INTO Personne VALUES (210, 'Caisse', 'Armand', 1974, '0673617626');
INSERT INTO Personne VALUES (211, 'Lachapelle', 'Alexandrin', 1999, '0720362571');
INSERT INTO Personne VALUES (212, 'Marleau', 'Fanchon', 2001, '0637819400');
INSERT INTO Personne VALUES (213, 'Mazuret', 'Ancelote', 1990, '0741163298');
INSERT INTO Personne VALUES (214, 'Migneault', 'Laurette', 1973, '0621138648');
INSERT INTO Personne VALUES (215, 'Denis', 'Toussaint', 2003, '0797595159');
INSERT INTO Personne VALUES (216, 'Durepos', 'Gemma', 1986, '0761308521');
INSERT INTO Personne VALUES (217, 'Faure', 'Martin', 1949, '0639695092');
INSERT INTO Personne VALUES (218, 'Robitaille', 'Adorlee', 2001, '0714358668');
INSERT INTO Personne VALUES (219, 'Hébert', 'Karlotta', 1986, '0748030192');
INSERT INTO Personne VALUES (220, 'Gaillou', 'Martin', 1967, '0654679265');
INSERT INTO Personne VALUES (221, 'Francoeur', 'Zacharie', 1996, '0687722319');
INSERT INTO Personne VALUES (222, 'Fortin', 'Cerise', 1969, '0646436685');
INSERT INTO Personne VALUES (223, 'Charpentier', 'Antoinette', 1954, '0618423467');
INSERT INTO Personne VALUES (224, 'Marois', 'Valérie', 1974, '0755563443');
INSERT INTO Personne VALUES (225, 'Pépin', 'Alexandre', 1964, '0770808993');
INSERT INTO Personne VALUES (226, 'Routhier', 'Romain', 1979, '0684109654');
INSERT INTO Personne VALUES (227, 'Gamelin', 'Noémi', 1953, '0628413663');
INSERT INTO Personne VALUES (228, 'Côté', 'Anaïs', 1968, '0648603731');
INSERT INTO Personne VALUES (229, 'Maheu', 'Faye', 1979, '0731925802');
INSERT INTO Personne VALUES (230, 'Paré', 'Archard', 1947, '0627258349');
INSERT INTO Personne VALUES (231, 'Lamour', 'Sennet', 1987, '0726783082');
INSERT INTO Personne VALUES (232, 'Théberge', 'Peppin', 1961, '0752983762');
INSERT INTO Personne VALUES (233, 'Vincent', 'Fauna', 1992, '0622086518');
INSERT INTO Personne VALUES (234, 'Courtemanche', 'Ray', 1992, '0607126586');
INSERT INTO Personne VALUES (235, 'Cinq-Mars', 'Guy', 2002, '0788237006');
INSERT INTO Personne VALUES (236, 'Audet', 'Troy', 1959, '0775827763');
INSERT INTO Personne VALUES (237, 'Beaudoin', 'Matilda', 1978, '0783378201');
INSERT INTO Personne VALUES (238, 'Charpie', 'Archard', 1963, '0771864421');
INSERT INTO Personne VALUES (239, 'Moïse', 'Huon', 1947, '0636284960');
INSERT INTO Personne VALUES (240, 'Crête', 'Gustave', 1996, '0640751437');
INSERT INTO Personne VALUES (241, 'Potvin', 'Mirabelle', 1966, '0696565309');
INSERT INTO Personne VALUES (242, 'Langelier', 'Isaac', 1993, '0675227553');
INSERT INTO Personne VALUES (243, 'Avare', 'Latimer', 1972, '0616855266');
INSERT INTO Personne VALUES (244, 'Beausoleil', 'Aymon', 1987, '0755105728');
INSERT INTO Personne VALUES (245, 'Frappier', 'Channing', 1980, '0751215073');
INSERT INTO Personne VALUES (246, 'Lemieux', 'Zdenek', 1985, '0653636544');
INSERT INTO Personne VALUES (247, 'Boulanger', 'Sumner', 1954, '0703549601');
INSERT INTO Personne VALUES (248, 'Aubé', 'Aubrey', 1957, '0742536916');
INSERT INTO Personne VALUES (249, 'Goddu', 'Jay', 1977, '0798810821');
INSERT INTO Personne VALUES (250, 'Rancourt', 'Dexter', 1996, '0602190398');
INSERT INTO Personne VALUES (251, 'Levasseur', 'Auriville', 2003, '0720504514');
INSERT INTO Personne VALUES (252, 'Douffet', 'Francis', 1959, '0744253226');
INSERT INTO Personne VALUES (253, 'Paquette', 'Peverell', 1989, '0606183436');
INSERT INTO Personne VALUES (254, 'Laforge', 'Paul', 1943, '0646105130');
INSERT INTO Personne VALUES (255, 'Demers', 'Emmanuelle', 1985, '0751339853');
INSERT INTO Personne VALUES (256, 'Louis', 'Barry', 1965, '0703606421');
INSERT INTO Personne VALUES (257, 'Barrière', 'Cheney', 1950, '0635899267');
INSERT INTO Personne VALUES (258, 'Cliche', 'Millard', 1998, '0775835310');
INSERT INTO Personne VALUES (259, 'Piedalue', 'Amber', 2004, '0678913769');
INSERT INTO Personne VALUES (260, 'Patry', 'David', 1983, '0617524067');
INSERT INTO Personne VALUES (261, 'Casgrain', 'Victor', 1962, '0787437087');
INSERT INTO Personne VALUES (262, 'Lajeunesse', 'Frontino', 1941, '0774447383');
INSERT INTO Personne VALUES (263, 'Fugère', 'Chapin', 1939, '0785314647');
INSERT INTO Personne VALUES (264, 'Guilmette', 'Christabel', 1971, '0657215582');
INSERT INTO Personne VALUES (265, 'Lamoureux', 'Arienne', 1959, '0748107039');
INSERT INTO Personne VALUES (266, 'Lachance', 'Thierry', 1992, '0662722440');
INSERT INTO Personne VALUES (267, 'Guibord', 'Noelle', 1992, '0719314453');
INSERT INTO Personne VALUES (268, 'Norbert', 'Yolette', 1969, '0734031214');
INSERT INTO Personne VALUES (269, 'Richer', 'Laetitia', 1953, '0636513814');
INSERT INTO Personne VALUES (270, 'Lapointe', 'Agathe', 1968, '0668840284');
INSERT INTO Personne VALUES (271, 'Thériault', 'Erembourg', 1943, '0655429178');
INSERT INTO Personne VALUES (272, 'Lachapelle', 'Honore', 1950, '0780176514');
INSERT INTO Personne VALUES (273, 'Corbin', 'Russell', 1943, '0744752308');
INSERT INTO Personne VALUES (274, 'Pomerleau', 'Margaux', 1957, '0708923437');
INSERT INTO Personne VALUES (275, 'LaCaille', 'Gano', 1985, '0622698650');
INSERT INTO Personne VALUES (276, 'Saindon', 'Henriette', 1960, '0709211584');
INSERT INTO Personne VALUES (277, 'Cinq-Mars', 'Angelette', 1989, '0644156802');
INSERT INTO Personne VALUES (278, 'Jodoin', 'Courtland', 1987, '0677587101');
INSERT INTO Personne VALUES (279, 'Laforge', 'Laurent', 1943, '0731755799');
INSERT INTO Personne VALUES (280, 'Bossé', 'Tanguy', 1941, '0660194659');
INSERT INTO Personne VALUES (281, 'Chrétien', 'Thomas', 1966, '0656560434');
INSERT INTO Personne VALUES (282, 'Bazin', 'Françoise', 1969, '0677039406');
INSERT INTO Personne VALUES (283, 'Riel', 'Allyriane', 1970, '0672378707');
INSERT INTO Personne VALUES (284, 'Faure', 'Philippe', 1992, '0644901622');
INSERT INTO Personne VALUES (285, 'Huard', 'Mason', 1987, '0607796784');
INSERT INTO Personne VALUES (286, 'Belisle', 'Emmeline', 1962, '0698791747');
INSERT INTO Personne VALUES (287, 'Loiseau', 'Anne', 1974, '0725979802');
INSERT INTO Personne VALUES (288, 'Dupuis', 'Gemma', 2003, '0775179154');
INSERT INTO Personne VALUES (289, 'Lepage', 'Gabriel', 1955, '0687783535');
INSERT INTO Personne VALUES (290, 'Descoteaux', 'Solaine', 1945, '0640177686');
INSERT INTO Personne VALUES (291, 'Leduc', 'Anne', 1995, '0626739859');
INSERT INTO Personne VALUES (292, 'Michaud', 'Maureen', 1967, '0749013922');
INSERT INTO Personne VALUES (293, 'Salois', 'Rosamonde', 1964, '0622250383');
INSERT INTO Personne VALUES (294, 'Cloutier', 'Leala', 1998, '0639450506');
INSERT INTO Personne VALUES (295, 'Cadieux', 'Arno', 1948, '0645381485');
INSERT INTO Personne VALUES (296, 'Proulx', 'Gaston', 1958, '0623879149');
INSERT INTO Personne VALUES (297, 'Duplessis', 'Medoro', 1995, '0790467894');
INSERT INTO Personne VALUES (298, 'Chatigny', 'Moore', 1951, '0627175748');
INSERT INTO Personne VALUES (299, 'Bonami', 'Jacqueline', 1975, '0646957810');
INSERT INTO Personne VALUES (300, 'Chesnay', 'Germaine', 1961, '0672246261');
INSERT INTO Personne VALUES (301, 'Dufour', 'Philippine', 1956, '0711882370');
INSERT INTO Personne VALUES (302, 'Melanson', 'Laurette', 1983, '0711261798');
INSERT INTO Personne VALUES (303, 'Lemelin', 'Donatien', 1991, '0610327077');
INSERT INTO Personne VALUES (304, 'Meunier', 'Martin', 1950, '0657866704');
INSERT INTO Personne VALUES (305, 'L''Heureux', 'Cerise', 1994, '0601583172');
INSERT INTO Personne VALUES (306, 'Landry', 'Alita', 1947, '0792488431');
INSERT INTO Personne VALUES (307, 'Parizeau', 'Warrane', 1944, '0683799169');
INSERT INTO Personne VALUES (308, 'Dupont', 'Mignonette', 1942, '0691847362');
INSERT INTO Personne VALUES (309, 'Goguen', 'Alexandrin', 1972, '0613760035');
INSERT INTO Personne VALUES (310, 'Pellerin', 'Arno', 1938, '0768993327');
INSERT INTO Personne VALUES (311, 'Guertin', 'Jewel', 1994, '0673635685');
INSERT INTO Personne VALUES (312, 'Rouleau', 'Maurice', 1966, '0633018932');
INSERT INTO Personne VALUES (313, 'Rouze', 'Dorene', 1959, '0666782530');
INSERT INTO Personne VALUES (314, 'Bouchard', 'Aubrette', 1954, '0735190762');
INSERT INTO Personne VALUES (315, 'Barjavel', 'Somerville', 1955, '0695659836');
INSERT INTO Personne VALUES (316, 'Couturier', 'Marthe', 1942, '0679325159');
INSERT INTO Personne VALUES (317, 'Arnoux', 'Zerbino', 1971, '0704766936');
INSERT INTO Personne VALUES (318, 'Dostie', 'Vachel', 1993, '0650385403');
INSERT INTO Personne VALUES (319, 'Miron', 'Charline', 1974, '0659188259');
INSERT INTO Personne VALUES (320, 'Landry', 'Karel', 1957, '0689870834');
INSERT INTO Personne VALUES (321, 'Charron', 'Satordi', 1951, '0686853392');
INSERT INTO Personne VALUES (322, 'Trottier', 'Crescent', 2005, '0603582966');
INSERT INTO Personne VALUES (323, 'Lesage', 'Orville', 1982, '0739403638');
INSERT INTO Personne VALUES (324, 'Saurel', 'Legget', 1993, '0781005845');
INSERT INTO Personne VALUES (325, 'Robitaille', 'Alexis', 1962, '0647454630');
INSERT INTO Personne VALUES (326, 'Brisette', 'Martine', 1978, '0718037573');
INSERT INTO Personne VALUES (327, 'Lavoie', 'Franck', 1971, '0644718734');
INSERT INTO Personne VALUES (328, 'Denis', 'Alexandrin', 1954, '0760072788');
INSERT INTO Personne VALUES (329, 'Michaud', 'Maslin', 1954, '0737925465');
INSERT INTO Personne VALUES (330, 'Dagenais', 'Varden', 1942, '0602736118');
INSERT INTO Personne VALUES (331, 'Authier', 'Favor', 1944, '0684410957');
INSERT INTO Personne VALUES (332, 'Boulé', 'André', 1949, '0609003743');
INSERT INTO Personne VALUES (333, 'Margand', 'Pierrette', 1957, '0602168628');
INSERT INTO Personne VALUES (334, 'Gagné', 'Blondelle', 1982, '0636687131');
INSERT INTO Personne VALUES (335, 'Audet', 'Leal', 1969, '0703787291');
INSERT INTO Personne VALUES (336, 'Deserres', 'Falerina', 1985, '0773176864');
INSERT INTO Personne VALUES (337, 'Leblanc', 'Marcel', 1973, '0689839830');
INSERT INTO Personne VALUES (338, 'Gabriaux', 'Angelette', 1950, '0745455498');
INSERT INTO Personne VALUES (339, 'Caron', 'Grosvenor', 1969, '0633068290');
INSERT INTO Personne VALUES (340, 'Rancourt', 'Anaïs', 1938, '0695549130');
INSERT INTO Personne VALUES (341, 'Guibord', 'Methena', 1980, '0619236898');
INSERT INTO Personne VALUES (342, 'Chenard', 'Anouk', 1981, '0725661925');
INSERT INTO Personne VALUES (343, 'Fluet', 'Anastasie', 1956, '0746365314');
INSERT INTO Personne VALUES (344, 'Durepos', 'Cosette', 1957, '0688016162');
INSERT INTO Personne VALUES (345, 'Roussel', 'Lyle', 1965, '0713331041');
INSERT INTO Personne VALUES (346, 'Pirouet', 'Byron', 1957, '0716091912');
INSERT INTO Personne VALUES (347, 'Blais', 'Barry', 1972, '0600714116');
INSERT INTO Personne VALUES (348, 'Beaujolie', 'Chapin', 1983, '0622893259');
INSERT INTO Personne VALUES (349, 'Parmentier', 'Ferrau', 1950, '0786765592');
INSERT INTO Personne VALUES (350, 'Perreault', 'Lorraine', 2002, '0663376526');
INSERT INTO Personne VALUES (351, 'Aucoin', 'Verrill', 1940, '0769706303');
INSERT INTO Personne VALUES (352, 'Artois', 'Vivienne', 1953, '0613976403');
INSERT INTO Personne VALUES (353, 'Lamontagne', 'Dexter', 1960, '0711513514');
INSERT INTO Personne VALUES (354, 'Pellerin', 'Genevre', 1952, '0697851480');
INSERT INTO Personne VALUES (355, 'Cinq-Mars', 'Avenall', 1943, '0778784459');
INSERT INTO Personne VALUES (356, 'Davignon', 'Julien', 1972, '0696335934');
INSERT INTO Personne VALUES (357, 'Tollmache', 'Brunella', 1994, '0747499363');
INSERT INTO Personne VALUES (358, 'Bélair', 'Sylvie', 1965, '0653318133');
INSERT INTO Personne VALUES (359, 'Caya', 'Paien', 1955, '0757351161');
INSERT INTO Personne VALUES (360, 'Quinn', 'Fealty', 1964, '0767236540');
INSERT INTO Personne VALUES (361, 'Lebel', 'Arnaude', 1951, '0606126088');
INSERT INTO Personne VALUES (362, 'Labbé', 'Ansel', 1992, '0603198214');
INSERT INTO Personne VALUES (363, 'Marier', 'Aceline', 2005, '0655909369');
INSERT INTO Personne VALUES (364, 'Lachapelle', 'Eleanor', 2002, '0655421112');
INSERT INTO Personne VALUES (365, 'Perreault', 'Christabel', 1973, '0736407289');
INSERT INTO Personne VALUES (366, 'Arsenault', 'Olympia', 1975, '0655575924');
INSERT INTO Personne VALUES (367, 'Lavallée', 'Agramant', 1983, '0647020709');
INSERT INTO Personne VALUES (368, 'Charest', 'Jeanne', 1995, '0702572435');
INSERT INTO Personne VALUES (369, 'Daigle', 'Mallory', 1982, '0675969582');
INSERT INTO Personne VALUES (370, 'Chassé', 'Avenall', 2004, '0698458385');
INSERT INTO Personne VALUES (371, 'Bédard', 'Ferrau', 1940, '0718235790');
INSERT INTO Personne VALUES (372, 'Despins', 'Alaine', 1971, '0797021425');
INSERT INTO Personne VALUES (373, 'Lagueux', 'Laure', 1962, '0735729475');
INSERT INTO Personne VALUES (374, 'Bordeleau', 'Donat', 1959, '0729796952');
INSERT INTO Personne VALUES (375, 'LeBatelier', 'Henriette', 1974, '0692188302');
INSERT INTO Personne VALUES (376, 'Michel', 'Marcel', 1995, '0680331034');
INSERT INTO Personne VALUES (377, 'Marcoux', 'Harcourt', 1952, '0613926230');
INSERT INTO Personne VALUES (378, 'Dagenais', 'Dorene', 1966, '0602823555');
INSERT INTO Personne VALUES (379, 'Goudreau', 'Porter', 1947, '0670349628');
INSERT INTO Personne VALUES (380, 'Fouquet', 'Maureen', 1977, '0769322447');
INSERT INTO Personne VALUES (381, 'Crête', 'Bellamy', 1966, '0710517380');
INSERT INTO Personne VALUES (382, 'Tisserand', 'Iva', 1941, '0676129297');
INSERT INTO Personne VALUES (383, 'Sylvain', 'Avice', 1944, '0750701514');
INSERT INTO Personne VALUES (384, 'Arsenault', 'Marc', 1998, '0659081277');
INSERT INTO Personne VALUES (385, 'Laux', 'Vincent', 1950, '0600474630');
INSERT INTO Personne VALUES (386, 'Beaulé', 'Alfred', 1960, '0610354606');
INSERT INTO Personne VALUES (387, 'Fluet', 'Logistilla', 1978, '0794693655');
INSERT INTO Personne VALUES (388, 'Sacré', 'Tabor', 1991, '0703865447');
INSERT INTO Personne VALUES (389, 'Dodier', 'Gallia', 1995, '0664181773');
INSERT INTO Personne VALUES (390, 'Goddu', 'Olivier', 1947, '0665726181');
INSERT INTO Personne VALUES (391, 'Monjeau', 'Harbin', 1963, '0721414846');
INSERT INTO Personne VALUES (392, 'Lafontaine', 'Didiane', 1946, '0776177118');
INSERT INTO Personne VALUES (393, 'Duperré', 'Fifi', 1999, '0674292823');
INSERT INTO Personne VALUES (394, '"De La Vergne"', 'Laurene', 1969, '0712007594');
INSERT INTO Personne VALUES (395, 'Lavallée', 'Eleanor', 1942, '0605198205');
INSERT INTO Personne VALUES (396, 'Melanson', 'Holly', 1984, '0691094780');
INSERT INTO Personne VALUES (397, 'Talon', 'Véronique', 1972, '0608328647');
INSERT INTO Personne VALUES (398, 'Létourneau', 'Tempeste', 1977, '0776292435');
INSERT INTO Personne VALUES (399, 'Houle', 'Ferrau', 2002, '0647058005');
INSERT INTO Personne VALUES (400, 'Corbin', 'Agathe', 1999, '0751205756');
INSERT INTO Personne VALUES (401, 'Arpin', 'Lothair', 1991, '0692975991');
INSERT INTO Personne VALUES (402, 'Goudreau', 'Pensee', 1950, '0647711872');
INSERT INTO Personne VALUES (403, 'Doyon', 'Vail', 1995, '0699303063');
INSERT INTO Personne VALUES (404, 'Pichette', 'Mireille', 1983, '0616802745');
INSERT INTO Personne VALUES (405, 'Beaupré', 'Yves', 1940, '0608131816');
INSERT INTO Personne VALUES (406, 'Laframboise', 'Anton', 1973, '0689349442');
INSERT INTO Personne VALUES (407, 'Dodier', 'Elita', 1985, '0627441290');
INSERT INTO Personne VALUES (408, 'Pellerin', 'Curtis', 1974, '0775657884');
INSERT INTO Personne VALUES (409, 'Rocheleau', 'Vignette', 1953, '0741152114');
INSERT INTO Personne VALUES (410, 'Covillon', 'Burrell', 1955, '0763851735');
INSERT INTO Personne VALUES (411, 'Montminy', 'Serge', 1973, '0797027301');
INSERT INTO Personne VALUES (412, 'Béland', 'Turner', 1988, '0706846465');
INSERT INTO Personne VALUES (413, 'Favreau', 'Marsilius', 1957, '0720228753');
INSERT INTO Personne VALUES (414, 'Henrichon', 'Jesper', 1950, '0790816096');
INSERT INTO Personne VALUES (415, 'Pouchard', 'Fayette', 1942, '0624613511');
INSERT INTO Personne VALUES (416, 'Labelle', 'Blondelle', 1953, '0759069045');
INSERT INTO Personne VALUES (417, 'Faucher', 'Algernon', 1939, '0730590262');
INSERT INTO Personne VALUES (418, 'Labrecque', 'Maureen', 1994, '0663482070');
INSERT INTO Personne VALUES (419, 'Tachel', 'Melusina', 1960, '0680284439');
INSERT INTO Personne VALUES (420, 'Vaillancour', 'Loring', 1983, '0621794900');
INSERT INTO Personne VALUES (421, 'Ayot', 'Guerin', 1944, '0666770598');
INSERT INTO Personne VALUES (422, 'Duval', 'Monique', 1942, '0742798181');
INSERT INTO Personne VALUES (423, 'Chaussée', 'Noël', 1988, '0695899469');
INSERT INTO Personne VALUES (424, 'Forest', 'Huon', 1987, '0734623944');
INSERT INTO Personne VALUES (425, 'Lapresse', 'Elita', 2003, '0629322044');
INSERT INTO Personne VALUES (426, 'Gamache', 'Valérie', 2002, '0616063510');
INSERT INTO Personne VALUES (427, 'Riel', 'Francis', 1991, '0617958396');
INSERT INTO Personne VALUES (428, 'Lamoureux', 'Ogier', 1955, '0617313681');
INSERT INTO Personne VALUES (429, 'Brousseau', 'Agnès', 1995, '0696109750');
INSERT INTO Personne VALUES (430, 'Morel', 'Albertine', 1947, '0623755656');
INSERT INTO Personne VALUES (431, 'Desroches', 'Iva', 2000, '0637375902');
INSERT INTO Personne VALUES (432, 'Sauvé', 'Eloise', 1952, '0627741893');
INSERT INTO Personne VALUES (433, 'Beaudry', 'Émilie', 1942, '0745140319');
INSERT INTO Personne VALUES (434, 'Artois', 'Aimé', 1947, '0694039129');
INSERT INTO Personne VALUES (435, 'Bernier', 'Prunella', 1997, '0652089415');
INSERT INTO Personne VALUES (436, 'Audet', 'Ambra', 1963, '0793029006');
INSERT INTO Personne VALUES (437, 'Barrière', 'Cendrillon', 1990, '0698974831');
INSERT INTO Personne VALUES (438, 'Chassé', 'Yvette', 1983, '0674892980');
INSERT INTO Personne VALUES (439, 'Gousse', 'Stéphane', 1976, '0689833493');
INSERT INTO Personne VALUES (440, 'Primeau', 'Belda', 1973, '0743810177');
INSERT INTO Personne VALUES (441, 'Arsenault', 'Guerin', 2002, '0700699867');
INSERT INTO Personne VALUES (442, 'Généreux', 'Francis', 1967, '0771921186');
INSERT INTO Personne VALUES (443, 'Coulombe', 'Ophelia', 1940, '0688602422');
INSERT INTO Personne VALUES (444, 'Baril', 'Timothée', 1984, '0770889498');
INSERT INTO Personne VALUES (445, 'Chaloux', 'Rule', 1963, '0744948292');
INSERT INTO Personne VALUES (446, 'Grenier', 'Millicent', 1952, '0680711160');
INSERT INTO Personne VALUES (447, 'Roy', 'Fiacre', 1989, '0719942030');
INSERT INTO Personne VALUES (448, 'Doyon', 'Rive', 1992, '0612914930');
INSERT INTO Personne VALUES (449, 'Ailleboust', 'Pinabel', 1967, '0679100182');
INSERT INTO Personne VALUES (450, 'Bourgeau', 'Jesper', 1965, '0763087739');
INSERT INTO Personne VALUES (451, 'Lessard', 'Searlas', 1941, '0712111037');
INSERT INTO Personne VALUES (452, 'Gagné', 'Philip', 1985, '0728934195');
INSERT INTO Personne VALUES (453, 'Barteaux', 'Aubrey', 1943, '0728427991');
INSERT INTO Personne VALUES (454, 'Brisette', 'Allyriane', 1948, '0785308050');
INSERT INTO Personne VALUES (455, 'Sciverit', 'Bradamate', 1939, '0713314748');
INSERT INTO Personne VALUES (456, 'Therriault', 'Sophie', 1985, '0782116498');
INSERT INTO Personne VALUES (457, 'Carignan', 'Somerville', 2000, '0603249274');
INSERT INTO Personne VALUES (458, 'Piedalue', 'Hélène', 1969, '0653696550');
INSERT INTO Personne VALUES (459, 'Lamoureux', 'Stéphane', 1971, '0690245394');
INSERT INTO Personne VALUES (460, 'Boivin', 'Roxanne', 1998, '0630377226');
INSERT INTO Personne VALUES (461, 'Bériault', 'Matthieu', 1948, '0689027953');
INSERT INTO Personne VALUES (462, 'Carrière', 'Martin', 1991, '0721432644');
INSERT INTO Personne VALUES (463, 'Denis', 'Robinette', 1943, '0617894368');
INSERT INTO Personne VALUES (464, 'Josseaume', 'Dorene', 1976, '0748838758');
INSERT INTO Personne VALUES (465, 'Cinq-Mars', 'Marmion', 1986, '0695534519');
INSERT INTO Personne VALUES (466, 'Croteau', 'Gill', 1961, '0706804737');
INSERT INTO Personne VALUES (467, 'D''Aubigné', 'Jay', 1950, '0654803533');
INSERT INTO Personne VALUES (468, 'Chatigny', 'Jeoffroi', 1979, '0703831965');
INSERT INTO Personne VALUES (469, 'Chabot', 'Viollette', 2002, '0791727473');
INSERT INTO Personne VALUES (470, 'Turgeon', 'Faustin', 1955, '0732510785');
INSERT INTO Personne VALUES (471, 'Landry', 'Quennel', 1941, '0756633006');
INSERT INTO Personne VALUES (472, 'Berthiaume', 'Alice', 1944, '0741452985');
INSERT INTO Personne VALUES (473, 'Barrette', 'Laure', 1956, '0608382734');
INSERT INTO Personne VALUES (474, 'Lefèbvre', 'Manville', 1989, '0669491821');
INSERT INTO Personne VALUES (475, 'Martel', 'Calandre', 1967, '0646459532');
INSERT INTO Personne VALUES (476, 'L''Hiver', 'Roslyn', 1973, '0764446959');
INSERT INTO Personne VALUES (477, 'Thériault', 'Ranger', 1988, '0710112863');
INSERT INTO Personne VALUES (478, 'Paquette', 'Artus', 1969, '0610227136');
INSERT INTO Personne VALUES (479, 'Vaillancour', 'Valérie', 1950, '0794922943');
INSERT INTO Personne VALUES (480, 'Blondlot', 'Vivienne', 1964, '0725025237');
INSERT INTO Personne VALUES (481, 'Charrette', 'Astrid', 1976, '0647532061');
INSERT INTO Personne VALUES (482, 'Desilets', 'Grosvenor', 2000, '0761852490');
INSERT INTO Personne VALUES (483, 'LaGarde', 'Lucille', 1952, '0631756649');
INSERT INTO Personne VALUES (484, 'Echeverri', 'Amarante', 1997, '0730538351');
INSERT INTO Personne VALUES (485, 'Cantin', 'Eleanor', 1981, '0673566068');
INSERT INTO Personne VALUES (486, 'Charpentier', 'Delmare', 1984, '0758043879');
INSERT INTO Personne VALUES (487, 'Cotuand', 'Tanguy', 1974, '0699275955');
INSERT INTO Personne VALUES (488, 'Huard', 'Gaetan', 2005, '0662265362');
INSERT INTO Personne VALUES (489, 'Labrecque', 'Adrienne', 1994, '0686755876');
INSERT INTO Personne VALUES (490, 'Thibodeau', 'Charlot', 1970, '0792462951');
INSERT INTO Personne VALUES (491, 'Givry', 'Merle', 1969, '0789329870');
INSERT INTO Personne VALUES (492, 'Riquier', 'Merle', 2005, '0641968887');
INSERT INTO Personne VALUES (493, 'Ducharme', 'Clothilde', 1971, '0714480431');
INSERT INTO Personne VALUES (494, 'Mothé', 'Delmar', 1967, '0764203857');
INSERT INTO Personne VALUES (495, 'Daoust', 'Valentine', 1965, '0655393899');
INSERT INTO Personne VALUES (496, 'Adler', 'Alphonse', 1987, '0703798560');
INSERT INTO Personne VALUES (497, 'David', 'Delit', 1965, '0740911252');
INSERT INTO Personne VALUES (498, 'Gendron', 'Auda', 1959, '0736780853');
INSERT INTO Personne VALUES (499, 'Montminy', 'Langley', 1985, '0780476928');
INSERT INTO Personne VALUES (500, 'Larocque', 'Alice', 1979, '0674477803');
INSERT INTO Personne VALUES (501, 'Paimboeuf', 'Clementine', 2003, '0700274748');
INSERT INTO Personne VALUES (502, 'Poulin', 'Alexandre', 1941, '0752679404');
INSERT INTO Personne VALUES (503, 'Langlois', 'Garland', 1978, '0762394078');
INSERT INTO Personne VALUES (504, 'Mailhot', 'Lyle', 1941, '0771228847');
INSERT INTO Personne VALUES (505, 'Chandonnet', 'Damiane', 1975, '0759640568');
INSERT INTO Personne VALUES (506, 'Patel', 'Paige', 1991, '0758866738');
INSERT INTO Personne VALUES (507, 'Lanteigne', 'Tyson', 1945, '0742931228');
INSERT INTO Personne VALUES (508, 'Babin', 'Searlait', 1942, '0616419980');
INSERT INTO Personne VALUES (509, 'Gagné', 'Claire', 1999, '0714984072');
INSERT INTO Personne VALUES (510, 'Renaud', 'Parnella', 1948, '0609812690');
INSERT INTO Personne VALUES (511, 'Rouleau', 'Stéphane', 1941, '0781191471');
INSERT INTO Personne VALUES (512, 'Verreau', 'Clothilde', 1972, '0648572518');
INSERT INTO Personne VALUES (513, 'Thériault', 'Hamilton', 1989, '0720758262');
INSERT INTO Personne VALUES (514, 'Lacombe', 'Hilaire', 1992, '0638951985');
INSERT INTO Personne VALUES (515, 'Fugère', 'Michel', 1993, '0677533030');
INSERT INTO Personne VALUES (516, 'Proulx', 'Sargent', 1986, '0696333060');
INSERT INTO Personne VALUES (517, 'Bourgouin', 'Jessamine', 1947, '0616819925');
INSERT INTO Personne VALUES (518, 'Dastous', 'Matilda', 1988, '0679462257');
INSERT INTO Personne VALUES (519, 'Arpin', 'Chapin', 1974, '0705526621');
INSERT INTO Personne VALUES (520, 'Grimard', 'Millicent', 1991, '0721719351');
INSERT INTO Personne VALUES (521, 'Chalut', 'Burnell', 1946, '0734802431');
INSERT INTO Personne VALUES (522, 'Ruel', 'Aceline', 2004, '0637904825');
INSERT INTO Personne VALUES (523, 'Plaisance', 'Élisabeth', 1982, '0777243785');
INSERT INTO Personne VALUES (524, 'Paquin', 'Prewitt', 2000, '0661581630');
INSERT INTO Personne VALUES (525, 'Huard', 'Arthur', 1954, '0667612795');
INSERT INTO Personne VALUES (526, 'Charlesbois', 'Pénélope', 1991, '0668593542');
INSERT INTO Personne VALUES (527, 'Mazuret', 'Parnella', 1946, '0646618328');
INSERT INTO Personne VALUES (528, 'Robert', 'Quincy', 1984, '0668115601');
INSERT INTO Personne VALUES (529, 'Bourdette', 'Fifi', 1989, '0792668845');
INSERT INTO Personne VALUES (530, 'Dupuy', 'Jacqueline', 1968, '0645693428');
INSERT INTO Personne VALUES (531, 'Beaudouin', 'Linette', 1940, '0792143766');
INSERT INTO Personne VALUES (532, 'Boileau', 'Gaston', 1944, '0650535528');
INSERT INTO Personne VALUES (533, 'Boivin', 'Brice', 1980, '0644165214');
INSERT INTO Personne VALUES (534, 'Sansouci', 'Joy', 1951, '0657269815');
INSERT INTO Personne VALUES (535, 'Guilmette', 'Zdenek', 1994, '0726922352');
INSERT INTO Personne VALUES (536, 'Joly', 'Dominique', 1964, '0636394852');
INSERT INTO Personne VALUES (537, 'Plaisance', 'Josephe', 1983, '0735221588');
INSERT INTO Personne VALUES (538, 'Chnadonnet', 'Armand', 1984, '0641340182');
INSERT INTO Personne VALUES (539, 'Boisvert', 'Angelique', 2000, '0744184255');
INSERT INTO Personne VALUES (540, 'Paradis', 'Alacoque', 1962, '0627247490');
INSERT INTO Personne VALUES (541, 'Fluet', 'Paien', 1984, '0608811105');
INSERT INTO Personne VALUES (542, 'Roux', 'Elita', 1984, '0783671971');
INSERT INTO Personne VALUES (543, 'Croquetaigne', 'Luce', 1940, '0778310299');
INSERT INTO Personne VALUES (544, 'Morin', 'Lotye', 1970, '0610428586');
INSERT INTO Personne VALUES (545, 'Rousseau', 'Arber', 1972, '0641681172');
INSERT INTO Personne VALUES (546, 'D''Avis', 'Bertrand', 1984, '0703927108');
INSERT INTO Personne VALUES (547, 'Blanc', 'Édith', 1975, '0728058527');
INSERT INTO Personne VALUES (548, 'Parrot', 'Orva', 1952, '0609765780');
INSERT INTO Personne VALUES (549, 'Charette', 'Valentine', 1959, '0779255842');
INSERT INTO Personne VALUES (550, 'Desruisseaux', 'Aubert', 1961, '0664571030');
INSERT INTO Personne VALUES (551, 'Courtemanche', 'Clovis', 1973, '0689149978');
INSERT INTO Personne VALUES (552, 'Berthiaume', 'Carolos', 1982, '0612021514');
INSERT INTO Personne VALUES (553, 'Lamy', 'Gaetan', 1952, '0620965788');
INSERT INTO Personne VALUES (554, 'Aupry', 'Anne', 1987, '0742435108');
INSERT INTO Personne VALUES (555, 'LaGrande', 'Henry', 1995, '0786400225');
INSERT INTO Personne VALUES (556, 'Briard', 'Natalie', 1938, '0664993983');
INSERT INTO Personne VALUES (557, 'Perillard', 'Émile', 1950, '0786582580');
INSERT INTO Personne VALUES (558, 'Bordeaux', 'Eugenia', 1982, '0662688407');
INSERT INTO Personne VALUES (559, 'Trottier', 'Methena', 1947, '0614890012');
INSERT INTO Personne VALUES (560, 'Bisaillon', 'Benjamin', 1964, '0739611458');
INSERT INTO Personne VALUES (561, 'Francoeur', 'Zerbino', 1986, '0646985949');
INSERT INTO Personne VALUES (562, 'Phaneuf', 'Brice', 1949, '0715346765');
INSERT INTO Personne VALUES (563, 'Cantin', 'Emmanuel', 2001, '0658099774');
INSERT INTO Personne VALUES (564, 'Bonami', 'Perrin', 1996, '0603220269');
INSERT INTO Personne VALUES (565, 'Langlais', 'Aubert', 1974, '0607059141');
INSERT INTO Personne VALUES (566, 'Audet', 'Arnaude', 1941, '0681423915');
INSERT INTO Personne VALUES (567, 'Gervais', 'Yseult', 1977, '0659460568');
INSERT INTO Personne VALUES (568, 'Jacques', 'Montague', 1989, '0639235115');
INSERT INTO Personne VALUES (569, 'Lefèbvre', 'Tanguy', 1963, '0730267341');
INSERT INTO Personne VALUES (570, 'Lebel', 'Evrard', 1992, '0797643553');
INSERT INTO Personne VALUES (571, 'Lamontagne', 'Loring', 1972, '0673462963');
INSERT INTO Personne VALUES (572, 'Guédry', 'Archard', 1984, '0782350834');
INSERT INTO Personne VALUES (573, 'Pinneau', 'Porter', 1984, '0678685272');
INSERT INTO Personne VALUES (574, 'Bouchard', 'Sophie', 1967, '0643077286');
INSERT INTO Personne VALUES (575, 'Harquin', 'Margaux', 1997, '0670567414');
INSERT INTO Personne VALUES (576, 'Laramée', 'Carine', 1970, '0627421367');
INSERT INTO Personne VALUES (577, 'Bonsaint', 'Florence', 2002, '0753069251');
INSERT INTO Personne VALUES (578, 'Petit', 'Gilles', 1963, '0751298294');
INSERT INTO Personne VALUES (579, 'Gousse', 'Hugh', 1954, '0799605111');
INSERT INTO Personne VALUES (580, 'Faure', 'Emmanuelle', 1957, '0759367436');
INSERT INTO Personne VALUES (581, 'Rochefort', 'Olympia', 1941, '0659053725');
INSERT INTO Personne VALUES (582, 'Mercure', 'Oliver', 1996, '0616611698');
INSERT INTO Personne VALUES (583, 'Tremblay', 'Leverett', 1990, '0718489697');
INSERT INTO Personne VALUES (584, 'Mathieu', 'Aya', 2004, '0625547830');
INSERT INTO Personne VALUES (585, 'CinqMars', 'Armand', 1946, '0604962192');
INSERT INTO Personne VALUES (586, 'Marcheterre', 'Gill', 1995, '0668254274');
INSERT INTO Personne VALUES (587, 'Hébert', 'Amaury', 1944, '0763645609');
INSERT INTO Personne VALUES (588, 'Pelletier', 'Telford', 1963, '0722595391');
INSERT INTO Personne VALUES (589, 'Bériault', 'Robert', 1972, '0643620879');
INSERT INTO Personne VALUES (590, 'Garceau', 'Luc', 1945, '0641912510');
INSERT INTO Personne VALUES (591, 'Laforge', 'Warrane', 1978, '0640837461');
INSERT INTO Personne VALUES (592, '"Du Trieux"', 'Adrien', 1946, '0673351628');
INSERT INTO Personne VALUES (593, 'Lacasse', 'Vail', 1938, '0740249694');
INSERT INTO Personne VALUES (594, 'Lamare', 'Audric', 1978, '0677127349');
INSERT INTO Personne VALUES (595, 'Duplanty', 'Soren', 1997, '0714560296');
INSERT INTO Personne VALUES (596, 'Lalonde', 'Paulette', 1968, '0768048468');
INSERT INTO Personne VALUES (597, 'Fresne', 'Orville', 1945, '0668331224');
INSERT INTO Personne VALUES (598, 'Barrientos', 'Raymond', 1969, '0600491682');
INSERT INTO Personne VALUES (599, 'Tanguay', 'Pansy', 1993, '0798128677');
INSERT INTO Personne VALUES (600, 'Desroches', 'Fanchon', 1961, '0790083272');
INSERT INTO Personne VALUES (601, 'Camus', 'Lorraine', 1981, '0740485239');
INSERT INTO Personne VALUES (602, 'Desjardins', 'Ophelia', 1952, '0750220588');
INSERT INTO Personne VALUES (603, 'Boutot', 'Ignace', 1966, '0648370545');
INSERT INTO Personne VALUES (604, 'D''Aubigné', 'David', 1981, '0746109023');
INSERT INTO Personne VALUES (605, 'Blondlot', 'Manon', 1957, '0698668269');
INSERT INTO Personne VALUES (606, 'Pouliotte', 'Frontino', 1941, '0749267222');
INSERT INTO Personne VALUES (607, 'Laux', 'Ancelote', 1969, '0705855728');
INSERT INTO Personne VALUES (608, 'Grondin', 'Ruby', 1992, '0656818129');
INSERT INTO Personne VALUES (609, 'Pichette', 'Fantina', 1939, '0633978860');
INSERT INTO Personne VALUES (610, 'Course', 'Adorlee', 1958, '0713220287');
INSERT INTO Personne VALUES (611, 'Dumont', 'Christelle', 1950, '0718781958');
INSERT INTO Personne VALUES (612, 'Bisaillon', 'Barry', 1955, '0789482562');
INSERT INTO Personne VALUES (613, 'Brunault', 'Melville', 1985, '0616527782');
INSERT INTO Personne VALUES (614, 'Grimard', 'Cher', 1954, '0789431038');
INSERT INTO Personne VALUES (615, 'Goudreau', 'Quincy', 1984, '0679900355');
INSERT INTO Personne VALUES (616, 'Croteau', 'Hortense', 1938, '0618444171');
INSERT INTO Personne VALUES (617, 'Duhamel', 'Raoul', 1997, '0639858016');
INSERT INTO Personne VALUES (618, 'Louis', 'Belisarda', 1971, '0777549355');
INSERT INTO Personne VALUES (619, 'Bélanger', 'Isaac', 1947, '0644521760');
INSERT INTO Personne VALUES (620, 'Duffet', 'Artus', 1985, '0737306627');
INSERT INTO Personne VALUES (621, 'Souplet', 'Norris', 1988, '0658473973');
INSERT INTO Personne VALUES (622, 'Fugère', 'Victoire', 1968, '0614699070');
INSERT INTO Personne VALUES (623, 'Quessy', 'Grégoire', 1998, '0658585307');
INSERT INTO Personne VALUES (624, 'Arpin', 'Eugène', 1992, '0688238667');
INSERT INTO Personne VALUES (625, 'Monty', 'Pinabel', 1986, '0730488536');
INSERT INTO Personne VALUES (626, 'Gaulin', 'Daniel', 1988, '0666640735');
INSERT INTO Personne VALUES (627, 'Therrien', 'Patience', 1953, '0690453590');
INSERT INTO Personne VALUES (628, 'Lacombe', 'Théodore', 1944, '0691704732');
INSERT INTO Personne VALUES (629, 'Brousse', 'D''Arcy', 1955, '0788797642');
INSERT INTO Personne VALUES (630, 'Houle', 'Luc', 1957, '0754756037');
INSERT INTO Personne VALUES (631, 'Moquin', 'Cammile', 1971, '0721519644');
INSERT INTO Personne VALUES (632, 'Rodrigue', 'Somerville', 1999, '0604720161');
INSERT INTO Personne VALUES (633, 'Édouard', 'Brice', 1986, '0681283376');
INSERT INTO Personne VALUES (634, 'Veronneau', 'Éric', 1975, '0692268359');
INSERT INTO Personne VALUES (635, 'Dandonneau', 'Bayard', 1992, '0638259805');
INSERT INTO Personne VALUES (636, 'Deslauriers', 'Turner', 1938, '0777830865');
INSERT INTO Personne VALUES (637, 'Franchet', 'Felicien', 1972, '0614233186');
INSERT INTO Personne VALUES (638, 'Angélil', 'Florence', 1956, '0778834298');
INSERT INTO Personne VALUES (639, 'Leclair', 'Catherine', 1986, '0731790718');
INSERT INTO Personne VALUES (640, 'L''Heureux', 'Iven', 1958, '0623826927');
INSERT INTO Personne VALUES (641, 'Ruais', 'Ambra', 1992, '0729726813');
INSERT INTO Personne VALUES (642, 'Lachance', 'Annot', 1998, '0799176674');
INSERT INTO Personne VALUES (643, 'Binet', 'Marc', 1955, '0781193524');
INSERT INTO Personne VALUES (644, 'Hughes', 'Falerina', 1982, '0701393879');
INSERT INTO Personne VALUES (645, 'Chatigny', 'Isaac', 1998, '0746945183');
INSERT INTO Personne VALUES (646, 'Patry', 'Vedette', 1996, '0698559800');
INSERT INTO Personne VALUES (647, 'Harquin', 'Frontino', 1958, '0788136625');
INSERT INTO Personne VALUES (648, 'Langelier', 'Patience', 1958, '0681464379');
INSERT INTO Personne VALUES (649, 'Hachée', 'Damiane', 1943, '0772296138');
INSERT INTO Personne VALUES (650, 'Phaneuf', 'Émilie', 1951, '0636904608');
INSERT INTO Personne VALUES (651, 'Dubeau', 'Lucas', 1940, '0693185553');
INSERT INTO Personne VALUES (652, 'Pépin', 'Burrell', 1950, '0771926264');
INSERT INTO Personne VALUES (653, 'Achin', 'Michèle', 1969, '0777688753');
INSERT INTO Personne VALUES (654, 'Leroux', 'Marcel', 1958, '0757885370');
INSERT INTO Personne VALUES (655, 'Sanschagrin', 'Édith', 1952, '0700594095');
INSERT INTO Personne VALUES (656, 'Masson', 'Fayme', 1960, '0620936419');
INSERT INTO Personne VALUES (657, 'Dandonneau', 'Laverne', 1939, '0782761349');
INSERT INTO Personne VALUES (658, 'Savoie', 'Morgana', 1981, '0628837885');
INSERT INTO Personne VALUES (659, 'Cailot', 'Merle', 1988, '0758285124');
INSERT INTO Personne VALUES (660, 'Jacques', 'Davet', 1973, '0788222876');
INSERT INTO Personne VALUES (661, 'Gaulin', 'Jeanette', 1975, '0637851018');
INSERT INTO Personne VALUES (662, 'Dubé', 'Grégoire', 1950, '0697359357');
INSERT INTO Personne VALUES (663, 'Binet', 'Senapus', 1978, '0689980572');
INSERT INTO Personne VALUES (664, 'Pichette', 'Platt', 1966, '0610178319');
INSERT INTO Personne VALUES (665, 'Franchet', 'Adèle', 1956, '0711334273');
INSERT INTO Personne VALUES (666, 'Vadnais', 'Anaïs', 2003, '0784475292');
INSERT INTO Personne VALUES (667, 'Royer', 'Warrane', 1999, '0678678829');
INSERT INTO Personne VALUES (668, 'Sciverit', 'David', 1945, '0648253345');
INSERT INTO Personne VALUES (669, 'Dubois', 'Michèle', 1958, '0797516217');
INSERT INTO Personne VALUES (670, 'Vaillancourt', 'Louise', 2005, '0663901126');
INSERT INTO Personne VALUES (671, 'Chevrette', 'Théodore', 1947, '0796034426');
INSERT INTO Personne VALUES (672, 'Blondlot', 'Pascal', 1979, '0647367155');
INSERT INTO Personne VALUES (673, 'Rossignol', 'Cendrillon', 1998, '0605804103');
INSERT INTO Personne VALUES (674, 'Plante', 'Loring', 1956, '0758601634');
INSERT INTO Personne VALUES (675, 'Lang', 'Adrienne', 1989, '0765793725');
INSERT INTO Personne VALUES (676, 'LaCaille', 'Agrican', 1955, '0764066067');
INSERT INTO Personne VALUES (677, 'Cartier', 'Bruno', 1944, '0651907857');
INSERT INTO Personne VALUES (678, '"de Launay"', 'Lance', 1977, '0629041058');
INSERT INTO Personne VALUES (679, 'Charbonneau', 'Varden', 1966, '0721145746');
INSERT INTO Personne VALUES (680, 'Labelle', 'Damiane', 1995, '0795792947');
INSERT INTO Personne VALUES (681, 'Bourque', 'Tabor', 1951, '0787350428');
INSERT INTO Personne VALUES (682, 'Brasseur', 'Bruce', 1994, '0710499151');
INSERT INTO Personne VALUES (683, 'Pouliotte', 'Luce', 1944, '0711324766');
INSERT INTO Personne VALUES (684, 'Lizotte', 'Vallis', 1989, '0622279934');
INSERT INTO Personne VALUES (685, 'Givry', 'Didiane', 1984, '0653893264');
INSERT INTO Personne VALUES (686, 'Chrétien', 'Monique', 1985, '0735678807');
INSERT INTO Personne VALUES (687, 'Jodion', 'Roux', 1971, '0788395439');
INSERT INTO Personne VALUES (688, 'Guertin', 'Donatien', 1965, '0656399356');
INSERT INTO Personne VALUES (689, 'Foucault', 'Fabien', 1976, '0666174497');
INSERT INTO Personne VALUES (690, 'Bisaillon', 'Yolette', 1959, '0621389660');
INSERT INTO Personne VALUES (691, 'Masson', 'Anne', 2001, '0726711546');
INSERT INTO Personne VALUES (692, 'Baril', 'Agate', 1946, '0602494558');
INSERT INTO Personne VALUES (693, 'Dupont', 'Marlon', 1967, '0668508912');
INSERT INTO Personne VALUES (694, 'Compagnon', 'Audric', 1975, '0711317906');
INSERT INTO Personne VALUES (695, 'Chaloux', 'Ignace', 1964, '0703095807');
INSERT INTO Personne VALUES (696, 'Guilmette', 'Melodie', 1949, '0601112892');
INSERT INTO Personne VALUES (697, 'Vachon', 'Ansel', 1951, '0614442063');
INSERT INTO Personne VALUES (698, 'Bonnet', 'Alfred', 1949, '0600236742');
INSERT INTO Personne VALUES (699, 'Echeverri', 'Quennel', 1955, '0768417846');
INSERT INTO Personne VALUES (700, 'Gosselin', 'Soren', 1938, '0616959820');
INSERT INTO Personne VALUES (701, 'Bertrand', 'Marsilius', 1975, '0713294146');
INSERT INTO Personne VALUES (702, 'Desforges', 'Philip', 1968, '0682918677');
INSERT INTO Personne VALUES (703, 'Lécuyer', 'Albracca', 1942, '0629537847');
INSERT INTO Personne VALUES (704, 'Pitre', 'Sabine', 1991, '0650323617');
INSERT INTO Personne VALUES (705, 'Lejeune', 'Desire', 1955, '0601910600');
INSERT INTO Personne VALUES (706, 'Mainville', 'Patience', 1943, '0727149267');
INSERT INTO Personne VALUES (707, 'Senneville', 'Colette', 1959, '0665250888');
INSERT INTO Personne VALUES (708, 'Gingras', 'Mavise', 1951, '0793347203');
INSERT INTO Personne VALUES (709, 'Perreault', 'Denis', 1989, '0725467818');
INSERT INTO Personne VALUES (710, 'Bergeron', 'Vallis', 2002, '0731177433');
INSERT INTO Personne VALUES (711, 'Bler', 'Favor', 1946, '0791046448');
INSERT INTO Personne VALUES (712, 'Garreau', 'Luc', 1949, '0657714931');
INSERT INTO Personne VALUES (713, 'Leclerc', 'Leala', 1969, '0620860179');
INSERT INTO Personne VALUES (714, 'Labbé', 'Adèle', 1991, '0636328473');
INSERT INTO Personne VALUES (715, 'Bousquet', 'Burkett', 2000, '0614954795');
INSERT INTO Personne VALUES (716, 'René', 'Gaetane', 1946, '0639005625');
INSERT INTO Personne VALUES (717, 'Courcelle', 'Patience', 1975, '0721102510');
INSERT INTO Personne VALUES (718, 'Jacques', 'Faye', 1957, '0631278602');
INSERT INTO Personne VALUES (719, 'Goguen', 'Jesper', 1984, '0693977572');
INSERT INTO Personne VALUES (720, 'Poulin', 'Roch', 1984, '0667486894');
INSERT INTO Personne VALUES (721, 'Audibert', 'Archaimbau', 1948, '0631048248');
INSERT INTO Personne VALUES (722, 'Déziel', 'Christabel', 1957, '0613367279');
INSERT INTO Personne VALUES (723, 'Goddu', 'Dielle', 1957, '0713017941');
INSERT INTO Personne VALUES (724, 'Coulombe', 'Sibyla', 1993, '0665847581');
INSERT INTO Personne VALUES (725, 'Rhéaume', 'Laurene', 1940, '0740176797');
INSERT INTO Personne VALUES (726, 'Collin', 'Guy', 1980, '0781407152');
INSERT INTO Personne VALUES (727, 'Charron', 'Fantina', 1978, '0717353180');
INSERT INTO Personne VALUES (728, 'Cotuand', 'Cloridan', 1949, '0632295695');
INSERT INTO Personne VALUES (729, 'Généreux', 'Orane', 1959, '0770127886');
INSERT INTO Personne VALUES (730, 'Boisclair', 'Gay', 1985, '0759454652');
INSERT INTO Personne VALUES (731, 'Théberge', 'Luce', 1985, '0650822923');
INSERT INTO Personne VALUES (732, 'Martineau', 'Babette', 1978, '0770978553');
INSERT INTO Personne VALUES (733, 'Tessier', 'Aurore', 1975, '0705514668');
INSERT INTO Personne VALUES (734, 'Therrien', 'Talon', 1941, '0651624147');
INSERT INTO Personne VALUES (735, 'Marseau', 'Legget', 1949, '0732448333');
INSERT INTO Personne VALUES (736, 'Marier', 'Pierpont', 1977, '0631373766');
INSERT INTO Personne VALUES (737, 'Lejeune', 'Christien', 1980, '0639155229');
INSERT INTO Personne VALUES (738, 'Clément', 'Ranger', 1975, '0668129841');
INSERT INTO Personne VALUES (739, 'Allaire', 'Arlette', 1996, '0778929648');
INSERT INTO Personne VALUES (740, 'Gougeon', 'Claudette', 1991, '0685207155');
INSERT INTO Personne VALUES (741, 'Massé', 'Jeoffroi', 1983, '0683845242');
INSERT INTO Personne VALUES (742, 'Meunier', 'Marthe', 1958, '0745850893');
INSERT INTO Personne VALUES (743, 'Lefèbvre', 'Amarante', 1938, '0628888951');
INSERT INTO Personne VALUES (744, 'Gour', 'Aubrey', 1944, '0774573833');
INSERT INTO Personne VALUES (745, 'Lapierre', 'Royce', 1942, '0619889055');
INSERT INTO Personne VALUES (746, 'Bourgeois', 'Iva', 1939, '0692602886');
INSERT INTO Personne VALUES (747, 'Bondy', 'Jay', 1954, '0775361479');
INSERT INTO Personne VALUES (748, 'Bois', 'Armand', 1982, '0687014511');
INSERT INTO Personne VALUES (749, 'Briard', 'Dalmace', 1984, '0699728752');
INSERT INTO Personne VALUES (750, 'Parent', 'Agate', 1990, '0650088010');
INSERT INTO Personne VALUES (751, 'Authier', 'René', 1962, '0665387193');
INSERT INTO Personne VALUES (752, 'Daigneault', 'Searlas', 1958, '0701435313');
INSERT INTO Personne VALUES (753, 'Lapierre', 'Donat', 1964, '0664075479');
INSERT INTO Personne VALUES (754, 'Gladu', 'Vick', 1959, '0636170269');
INSERT INTO Personne VALUES (755, 'Patry', 'Clothilde', 1951, '0792621756');
INSERT INTO Personne VALUES (756, 'Daigle', 'Clothilde', 1957, '0745486926');
INSERT INTO Personne VALUES (757, 'Fecteau', 'Platt', 1953, '0664631275');
INSERT INTO Personne VALUES (758, 'Plouffe', 'Claudette', 1949, '0752226174');
INSERT INTO Personne VALUES (759, 'Baron', 'Malagigi', 1973, '0785456465');
INSERT INTO Personne VALUES (760, 'Gamache', 'Virginie', 1940, '0735845182');
INSERT INTO Personne VALUES (761, 'Rouze', 'France', 1962, '0664557001');
INSERT INTO Personne VALUES (762, 'Pouliotte', 'Iva', 1979, '0652719694');
INSERT INTO Personne VALUES (763, 'David', 'Gabrielle', 1974, '0707526585');
INSERT INTO Personne VALUES (764, 'Blondlot', 'Arthur', 1967, '0679760587');
INSERT INTO Personne VALUES (765, 'DeGrasse', 'Clothilde', 1959, '0627977525');
INSERT INTO Personne VALUES (766, 'Ruest', 'Pierrette', 2003, '0627784535');
INSERT INTO Personne VALUES (767, 'Bazinet', 'Gaspar', 1977, '0784488309');
INSERT INTO Personne VALUES (768, 'Blanchard', 'Lance', 1997, '0648709189');
INSERT INTO Personne VALUES (769, 'Sabourin', 'Eleanor', 1947, '0647148686');
INSERT INTO Personne VALUES (770, 'Auclair', 'Chantal', 1981, '0634308793');
INSERT INTO Personne VALUES (771, 'Bourgouin', 'Bradamate', 1940, '0662739219');
INSERT INTO Personne VALUES (772, 'Dubois', 'Maureen', 1975, '0696321944');
INSERT INTO Personne VALUES (773, 'Lévesque', 'Peppin', 1952, '0714638230');
INSERT INTO Personne VALUES (774, 'Grandpré', 'Liane', 1951, '0611909730');
INSERT INTO Personne VALUES (775, 'Querry', 'Merle', 1966, '0787582337');
INSERT INTO Personne VALUES (776, 'Rivière', 'Seymour', 1946, '0654831188');
INSERT INTO Personne VALUES (777, 'Pépin', 'Turner', 1974, '0779018493');
INSERT INTO Personne VALUES (778, 'Arsenault', 'Yvette', 2001, '0795136355');
INSERT INTO Personne VALUES (779, 'Giguère', 'Margaux', 1941, '0739493716');
INSERT INTO Personne VALUES (780, 'Lafontaine', 'Dominique', 1971, '0725755293');
INSERT INTO Personne VALUES (781, 'Clavet', 'Legget', 1947, '0671027417');
INSERT INTO Personne VALUES (782, 'Gosselin', 'Pénélope', 2001, '0686967718');
INSERT INTO Personne VALUES (783, 'Chauvet', 'Babette', 1981, '0624075419');
INSERT INTO Personne VALUES (784, 'Marquis', 'Marlon', 1972, '0734133034');
INSERT INTO Personne VALUES (785, 'Pépin', 'Virginie', 2005, '0703240618');
INSERT INTO Personne VALUES (786, 'Huard', 'Delphine', 1973, '0628133010');
INSERT INTO Personne VALUES (787, 'Mercier', 'Fusberta', 1983, '0647945678');
INSERT INTO Personne VALUES (788, 'Franchet', 'Olivier', 1952, '0665213911');
INSERT INTO Personne VALUES (789, 'Charette', 'Royale', 1954, '0639653170');
INSERT INTO Personne VALUES (790, 'Chicoine', 'Latimer', 1964, '0695878174');
INSERT INTO Personne VALUES (791, 'Hervieux', 'Ferragus', 1999, '0784207866');
INSERT INTO Personne VALUES (792, 'Tessier', 'Aubrey', 1947, '0645992610');
INSERT INTO Personne VALUES (793, 'Lanoie', 'Lance', 1980, '0615995823');
INSERT INTO Personne VALUES (794, 'LaCaille', 'Brice', 1953, '0764068079');
INSERT INTO Personne VALUES (795, 'Chauvin', 'Mirabelle', 1997, '0606204993');
INSERT INTO Personne VALUES (796, 'L''Angelier', 'Florence', 1978, '0686974734');
INSERT INTO Personne VALUES (797, 'Larocque', 'Chandler', 1995, '0776117866');
INSERT INTO Personne VALUES (798, 'Landry', 'Francis', 1957, '0651717115');
INSERT INTO Personne VALUES (799, 'Bédard', 'D''Arcy', 1993, '0795162600');
INSERT INTO Personne VALUES (800, 'Leroy', 'Bevis', 1948, '0684052581');
INSERT INTO Personne VALUES (801, 'Lambert', 'Pensee', 1976, '0755081503');
INSERT INTO Personne VALUES (802, 'Jalbert', 'Édouard', 1955, '0672878591');
INSERT INTO Personne VALUES (803, 'Berthelette', 'Hélène', 1948, '0671031297');
INSERT INTO Personne VALUES (804, 'Poissonnier', 'Searlas', 1997, '0612361573');
INSERT INTO Personne VALUES (805, 'Fresne', 'Crescent', 1981, '0705972770');
INSERT INTO Personne VALUES (806, 'Richer', 'Fiacre', 1983, '0635182836');
INSERT INTO Personne VALUES (807, 'Bousquet', 'Amorette', 1975, '0736404640');
INSERT INTO Personne VALUES (808, 'Duffet', 'Harbin', 1942, '0698178346');
INSERT INTO Personne VALUES (809, 'Laboissonnière', 'Marsilius', 1962, '0638852336');
INSERT INTO Personne VALUES (810, 'Mouet', 'Lotye', 1974, '0639934786');
INSERT INTO Personne VALUES (811, 'Thibault', 'Suzette', 1984, '0650429726');
INSERT INTO Personne VALUES (812, 'Hétu', 'Amorette', 2003, '0682336305');
INSERT INTO Personne VALUES (813, 'Bossé', 'Fayette', 2000, '0680878520');
INSERT INTO Personne VALUES (814, 'Doucet', 'Alphonse', 1990, '0777616466');
INSERT INTO Personne VALUES (815, 'Dumont', 'Erembourg', 1980, '0776859471');
INSERT INTO Personne VALUES (816, 'Gaillou', 'Dominique', 1997, '0791712567');
INSERT INTO Personne VALUES (817, 'Brisebois', 'Cammile', 1984, '0670527625');
INSERT INTO Personne VALUES (818, 'Panetier', 'Luc', 1941, '0651690844');
INSERT INTO Personne VALUES (819, 'Lamothe', 'Jesper', 1984, '0723002951');
INSERT INTO Personne VALUES (820, 'D''Avis', 'William', 1940, '0797262061');
INSERT INTO Personne VALUES (821, 'Reault', 'Fanchon', 1951, '0622036372');
INSERT INTO Personne VALUES (822, 'Achin', 'Astolpho', 1982, '0723465503');
INSERT INTO Personne VALUES (823, 'Couturier', 'Quincy', 1967, '0600310552');
INSERT INTO Personne VALUES (824, 'Gabriaux', 'Romaine', 1976, '0706854090');
INSERT INTO Personne VALUES (825, 'Brousse', 'Ogier', 1998, '0694746633');
INSERT INTO Personne VALUES (826, 'Petit', 'Berangaria', 1960, '0788919362');
INSERT INTO Personne VALUES (827, 'Plaisance', 'Heloise', 1980, '0651012714');
INSERT INTO Personne VALUES (828, 'Course', 'Mason', 1988, '0678571992');
INSERT INTO Personne VALUES (829, 'Clavette', 'Nicolette', 1958, '0782016819');
INSERT INTO Personne VALUES (830, 'Goudreau', 'Afrodille', 1945, '0626090070');
INSERT INTO Personne VALUES (831, 'Coulombe', 'Clémence', 1946, '0741590518');
INSERT INTO Personne VALUES (832, 'Grandbois', 'Fanchon', 1952, '0707257040');
INSERT INTO Personne VALUES (833, 'Godin', 'Gabrielle', 1960, '0751317103');
INSERT INTO Personne VALUES (834, 'Dumont', 'Arthur', 1968, '0632945608');
INSERT INTO Personne VALUES (835, 'Saurel', 'Desire', 1954, '0677735494');
INSERT INTO Personne VALUES (836, 'Monty', 'Clarimunda', 1972, '0724077775');
INSERT INTO Personne VALUES (837, 'Sauriol', 'Chappell', 1978, '0780318559');
INSERT INTO Personne VALUES (838, 'Gregoire', 'Marcel', 1991, '0689807649');
INSERT INTO Personne VALUES (839, 'Rocher', 'Aubin', 1993, '0727628324');
INSERT INTO Personne VALUES (840, 'Rochefort', 'Liane', 1979, '0637066312');
INSERT INTO Personne VALUES (841, 'Gour', 'Chandler', 1959, '0767926160');
INSERT INTO Personne VALUES (842, 'Gauvin', 'Harbin', 1985, '0706880271');
INSERT INTO Personne VALUES (843, 'Courcelle', 'Fitz', 2003, '0720532764');
INSERT INTO Personne VALUES (844, 'Desilets', 'Leone', 1987, '0624995738');
INSERT INTO Personne VALUES (845, 'Coulombe', 'Cendrillon', 1976, '0754935898');
INSERT INTO Personne VALUES (846, 'Adler', 'Yvon', 2002, '0688761842');
INSERT INTO Personne VALUES (847, 'Lessard', 'Granville', 1943, '0778104676');
INSERT INTO Personne VALUES (848, 'Rocheleau', 'Inès', 1983, '0662318722');
INSERT INTO Personne VALUES (849, 'Ricard', 'Oliver', 1948, '0744797428');
INSERT INTO Personne VALUES (850, 'Plouffe', 'Daniel', 1952, '0655850244');
INSERT INTO Personne VALUES (851, 'Martel', 'Charlot', 1946, '0608782236');
INSERT INTO Personne VALUES (852, 'Laforest', 'Bellamy', 1981, '0630118265');
INSERT INTO Personne VALUES (853, 'D''Aubigné', 'Halette', 1966, '0742428770');
INSERT INTO Personne VALUES (854, 'Ducharme', 'Morgana', 1976, '0789696774');
INSERT INTO Personne VALUES (855, 'Vaillancourt', 'Hedvige', 1968, '0693021882');
INSERT INTO Personne VALUES (856, 'Laprise', 'Jérôme', 1994, '0642834662');
INSERT INTO Personne VALUES (857, 'Trépanier', 'Raymond', 1980, '0788005020');
INSERT INTO Personne VALUES (858, 'Sarrazin', 'Marphisa', 1997, '0691619753');
INSERT INTO Personne VALUES (859, 'Gareau', 'Malagigi', 1952, '0673659238');
INSERT INTO Personne VALUES (860, 'Vernadeau', 'Raoul', 2005, '0642493718');
INSERT INTO Personne VALUES (861, 'Duranseau', 'Montague', 1989, '0611234896');
INSERT INTO Personne VALUES (862, 'Corbeil', 'Ferrau', 1942, '0637878609');
INSERT INTO Personne VALUES (863, 'Généreux', 'Élise', 1974, '0660332985');
INSERT INTO Personne VALUES (864, 'Caron', 'Coralie', 1970, '0699476563');
INSERT INTO Personne VALUES (865, 'Labossière', 'Eloise', 1963, '0603027784');
INSERT INTO Personne VALUES (866, 'Duplanty', 'Paul', 1965, '0714693593');
INSERT INTO Personne VALUES (867, 'Daigle', 'Arlette', 1985, '0611552144');
INSERT INTO Personne VALUES (868, 'Blanchard', 'Belisarda', 1965, '0748351214');
INSERT INTO Personne VALUES (869, 'Blondlot', 'Brice', 1979, '0666885937');
INSERT INTO Personne VALUES (870, 'Charrette', 'Pansy', 1959, '0688679905');
INSERT INTO Personne VALUES (871, 'Douffet', 'Leal', 1950, '0707214937');
INSERT INTO Personne VALUES (872, 'Migneault', 'Gaetan', 1992, '0711218351');
INSERT INTO Personne VALUES (873, 'Douffet', 'Angelique', 1966, '0649047979');
INSERT INTO Personne VALUES (874, 'Jobin', 'Arnaud', 1967, '0639946317');
INSERT INTO Personne VALUES (875, 'Langlais', 'Yvette', 1969, '0677808142');
INSERT INTO Personne VALUES (876, 'Breton', 'Vincent', 1978, '0688512324');
INSERT INTO Personne VALUES (877, 'Lazure', 'Cinderella', 2004, '0624463708');
INSERT INTO Personne VALUES (878, 'Adler', 'Caresse', 1992, '0737665455');
INSERT INTO Personne VALUES (879, 'Lanctot', 'Lothair', 1979, '0749878675');
INSERT INTO Personne VALUES (880, 'Lagacé', 'Daniel', 1995, '0745688080');
INSERT INTO Personne VALUES (881, 'Cloutier', 'Vincent', 1978, '0648004650');
INSERT INTO Personne VALUES (882, 'Daigle', 'Odo', 1955, '0779262747');
INSERT INTO Personne VALUES (883, 'Dennis', 'Perrin', 1965, '0720390740');
INSERT INTO Personne VALUES (884, 'Norbert', 'Cloridan', 1969, '0640294189');
INSERT INTO Personne VALUES (885, 'Parent', 'Astrid', 1952, '0750811641');
INSERT INTO Personne VALUES (886, 'Boucher', 'Ancelote', 1970, '0757165377');
INSERT INTO Personne VALUES (887, 'Begin', 'Lucas', 1994, '0612710814');
INSERT INTO Personne VALUES (888, 'Labrie', 'Honoré', 1992, '0716919611');
INSERT INTO Personne VALUES (889, 'Morneau', 'Minette', 1969, '0620886570');
INSERT INTO Personne VALUES (890, 'Bilodeau', 'Yseult', 1995, '0672392754');
INSERT INTO Personne VALUES (891, 'Carrière', 'Mercer', 1999, '0715265025');
INSERT INTO Personne VALUES (892, 'Doyon', 'Estelle', 1974, '0646888190');
INSERT INTO Personne VALUES (893, 'Migneault', 'Martin', 1967, '0768263345');
INSERT INTO Personne VALUES (894, 'Angélil', 'Fifi', 1961, '0663235741');
INSERT INTO Personne VALUES (895, 'St-Pierre', 'Daisi', 1950, '0791241483');
INSERT INTO Personne VALUES (896, 'Vadnais', 'Marine', 1988, '0695413586');
INSERT INTO Personne VALUES (897, 'Gervais', 'Hortense', 1989, '0616319000');
INSERT INTO Personne VALUES (898, 'Cadieux', 'Nicholas', 1938, '0622190398');
INSERT INTO Personne VALUES (899, 'Ayot', 'Robinette', 1952, '0795921117');
INSERT INTO Personne VALUES (900, 'Trudeau', 'Lyle', 1947, '0748147232');
INSERT INTO Personne VALUES (901, 'Bourgeau', 'Sabine', 1960, '0796432906');
INSERT INTO Personne VALUES (902, 'Gosselin', 'Harcourt', 1954, '0622973200');
INSERT INTO Personne VALUES (903, 'Allard', 'Amber', 1980, '0694302179');
INSERT INTO Personne VALUES (904, 'Gendron', 'Fusberta', 1942, '0610594974');
INSERT INTO Personne VALUES (905, 'Guay', 'Olympia', 1981, '0752703536');
INSERT INTO Personne VALUES (906, 'Thibodeau', 'Blondelle', 1959, '0685938382');
INSERT INTO Personne VALUES (907, 'Barteaux', 'Charlotte', 1997, '0693243414');
INSERT INTO Personne VALUES (908, 'Giguère', 'Wyatt', 1980, '0689819928');
INSERT INTO Personne VALUES (909, 'Huppé', 'René', 1987, '0742092040');
INSERT INTO Personne VALUES (910, 'Parizeau', 'Carolos', 1962, '0722206571');
INSERT INTO Personne VALUES (911, 'Trottier', 'Gano', 1946, '0755237508');
INSERT INTO Personne VALUES (912, 'Piedalue', 'Brier', 1963, '0706734980');
INSERT INTO Personne VALUES (913, 'Charrette', 'Adélaïde', 1948, '0738237676');
INSERT INTO Personne VALUES (914, 'Parrot', 'Patricia', 1990, '0658780352');
INSERT INTO Personne VALUES (915, 'Beaudouin', 'Mavise', 1944, '0687011227');
INSERT INTO Personne VALUES (916, 'Béland', 'Peverell', 1955, '0635367805');
INSERT INTO Personne VALUES (917, 'Barjavel', 'Marveille', 1979, '0686763085');
INSERT INTO Personne VALUES (918, 'Blondlot', 'Maureen', 1970, '0626184682');
INSERT INTO Personne VALUES (919, 'Beaudouin', 'Saber', 1977, '0757228441');
INSERT INTO Personne VALUES (920, 'Hébert', 'Manville', 1970, '0706752120');
INSERT INTO Personne VALUES (921, 'Quiron', 'Caroline', 1981, '0743813619');
INSERT INTO Personne VALUES (922, 'Fournier', 'Dreux', 1941, '0715180545');
INSERT INTO Personne VALUES (923, 'Rancourt', 'Louis', 1963, '0745160055');
INSERT INTO Personne VALUES (924, 'Couet', 'Isaac', 1955, '0647677519');
INSERT INTO Personne VALUES (925, 'Fresne', 'Gradasso', 1992, '0740126555');
INSERT INTO Personne VALUES (926, 'Boutot', 'Pansy', 1944, '0751958943');
INSERT INTO Personne VALUES (927, 'Langlais', 'Mignonette', 1995, '0745188623');
INSERT INTO Personne VALUES (928, 'Crête', 'Marlon', 1996, '0762874308');
INSERT INTO Personne VALUES (929, 'Lacombe', 'Honoré', 1979, '0650395672');
INSERT INTO Personne VALUES (930, 'Bordeaux', 'Cloridan', 1972, '0668488704');
INSERT INTO Personne VALUES (931, 'Ayot', 'Margaux', 1980, '0606830451');
INSERT INTO Personne VALUES (932, 'Patel', 'Michel', 1949, '0786203220');
INSERT INTO Personne VALUES (933, 'Thibodeau', 'Michel', 1942, '0744969924');
INSERT INTO Personne VALUES (934, 'Leblanc', 'Landers', 1998, '0660592114');
INSERT INTO Personne VALUES (935, 'Lanteigne', 'Karel', 1972, '0761269880');
INSERT INTO Personne VALUES (936, 'Bernard', 'Lucas', 1938, '0707022814');
INSERT INTO Personne VALUES (937, 'Bisson', 'Raoul', 1993, '0634985514');
INSERT INTO Personne VALUES (938, 'Fortin', 'Minette', 1955, '0666671091');
INSERT INTO Personne VALUES (939, 'Paquet', 'Maurelle', 1977, '0664143527');
INSERT INTO Personne VALUES (940, 'Bordeaux', 'Fleurette', 1975, '0693311787');
INSERT INTO Personne VALUES (941, 'Phaneuf', 'Falerina', 1994, '0607807679');
INSERT INTO Personne VALUES (942, 'Therrien', 'Laverne', 1950, '0758934228');
INSERT INTO Personne VALUES (943, 'Chaloux', 'Prewitt', 2004, '0645255655');
INSERT INTO Personne VALUES (944, 'Potvin', 'Audric', 1992, '0660439079');
INSERT INTO Personne VALUES (945, 'Larocque', 'Felicienne', 1940, '0755268570');
INSERT INTO Personne VALUES (946, 'Aubin', 'Telford', 1984, '0656374523');
INSERT INTO Personne VALUES (947, 'Lampron', 'Adèle', 1991, '0624865639');
INSERT INTO Personne VALUES (948, 'Migneault', 'Jolie', 1996, '0661768995');
INSERT INTO Personne VALUES (949, 'Camus', 'Richard', 1961, '0647925923');
INSERT INTO Personne VALUES (950, 'Roy', 'Étienne', 1964, '0771356998');
INSERT INTO Personne VALUES (951, 'Provencher', 'Clothilde', 2000, '0756044020');
INSERT INTO Personne VALUES (952, 'Lamarre', 'Christiane', 1992, '0682659312');
INSERT INTO Personne VALUES (953, 'Descoteaux', 'Daisi', 1987, '0708926738');
INSERT INTO Personne VALUES (954, 'L''Heureux', 'Marlon', 1967, '0642669149');
INSERT INTO Personne VALUES (955, 'Perrault', 'Benoît', 1940, '0692970975');
INSERT INTO Personne VALUES (956, 'Mercier', 'Searlas', 1954, '0637308906');
INSERT INTO Personne VALUES (957, 'Pomerleau', 'Arienne', 1970, '0626095838');
INSERT INTO Personne VALUES (958, 'Arcouet', 'Dominic', 1984, '0708435077');
INSERT INTO Personne VALUES (959, 'Thivierge', 'Marshall', 1988, '0767468305');
INSERT INTO Personne VALUES (960, 'Desrosiers', 'Campbell', 1938, '0728292487');
INSERT INTO Personne VALUES (961, 'Mainville', 'Garland', 1969, '0787097596');
INSERT INTO Personne VALUES (962, 'Course', 'Claire', 1991, '0663175415');
INSERT INTO Personne VALUES (963, 'René', 'Philippe', 1946, '0615810457');
INSERT INTO Personne VALUES (964, 'Gour', 'Brie', 1990, '0793715939');
INSERT INTO Personne VALUES (965, 'Racine', 'Flordelis', 1955, '0706819168');
INSERT INTO Personne VALUES (966, 'Guimond', 'Mallory', 1991, '0715064077');
INSERT INTO Personne VALUES (967, 'Gareau', 'Favor', 1980, '0667032779');
INSERT INTO Personne VALUES (968, 'Bouchard', 'Belda', 1953, '0731071883');
INSERT INTO Personne VALUES (969, 'Tanguay', 'Élisabeth', 1952, '0693583815');
INSERT INTO Personne VALUES (970, 'Lamothe', 'Legget', 1991, '0609603450');
INSERT INTO Personne VALUES (971, 'Savoie', 'Jeanette', 1990, '0671254934');
INSERT INTO Personne VALUES (972, 'Lanoie', 'Fitz', 2003, '0700605795');
INSERT INTO Personne VALUES (973, 'Dubois', 'Francis', 1949, '0631417945');
INSERT INTO Personne VALUES (974, 'Archambault', 'Nathalie', 1983, '0669313141');
INSERT INTO Personne VALUES (975, 'Busque', 'Fusberta', 1947, '0699967452');
INSERT INTO Personne VALUES (976, 'Souplet', 'Roslyn', 1973, '0695445134');
INSERT INTO Personne VALUES (977, 'Barrientos', 'Slainie', 1946, '0712696179');
INSERT INTO Personne VALUES (978, 'Marchesseault', 'Pénélope', 1963, '0673702259');
INSERT INTO Personne VALUES (979, 'Vernadeau', 'Pierre', 1942, '0743237232');
INSERT INTO Personne VALUES (980, 'Pirouet', 'Pansy', 1985, '0799793936');
INSERT INTO Personne VALUES (981, 'Théberge', 'Oliver', 1974, '0695393187');
INSERT INTO Personne VALUES (982, 'Talon', 'Aubrey', 1956, '0731341515');
INSERT INTO Personne VALUES (983, 'Doyon', 'Gano', 1945, '0729168165');
INSERT INTO Personne VALUES (984, 'Bolduc', 'Élise', 1998, '0633661882');
INSERT INTO Personne VALUES (985, 'Chabot', 'Frédéric', 1984, '0696833342');
INSERT INTO Personne VALUES (986, 'Auclair', 'Legget', 1970, '0710071630');
INSERT INTO Personne VALUES (987, 'Querry', 'Raina', 1950, '0605013962');
INSERT INTO Personne VALUES (988, 'Rousseau', 'Adorlee', 1999, '0729836518');
INSERT INTO Personne VALUES (989, 'LaGarde', 'Avril', 1997, '0751700175');
INSERT INTO Personne VALUES (990, 'Méthot', 'Alphonse', 1988, '0705698370');
INSERT INTO Personne VALUES (991, 'Barjavel', 'Capucine', 1983, '0790426460');
INSERT INTO Personne VALUES (992, 'Gour', 'Ambra', 1978, '0638643447');
INSERT INTO Personne VALUES (993, 'Carrière', 'Céline', 1966, '0742473606');
INSERT INTO Personne VALUES (994, 'Lauzier', 'Delmar', 1990, '0656773461');
INSERT INTO Personne VALUES (995, 'Perillard', 'Annot', 1978, '0607294490');
INSERT INTO Personne VALUES (996, 'Chauvet', 'Merlin', 1969, '0710670549');
INSERT INTO Personne VALUES (997, 'Grandpré', 'Brie', 1965, '0683555590');
INSERT INTO Personne VALUES (998, 'Deserres', 'Estelle', 1987, '0721667943');
INSERT INTO Personne VALUES (999, 'Lapointe', 'Gilles', 1953, '0752215952');
INSERT INTO Personne VALUES (1000, 'Pelland', 'Ray', 1959, '0755715156');
INSERT INTO Personne VALUES (1001, 'Bob', 'Mauranne', NULL, '0607080910');
INSERT INTO Personne VALUES (1002, 'Serge', 'Martinot', 1955, '0666666669');
INSERT INTO Personne VALUES (1003, 'Serge', 'Martinot', 2001, '0000000000');
INSERT INTO Personne VALUES (1004, 'Serge', 'Martin', NULL, '0000000000');

-- Content from file Sport --
INSERT INTO Sport VALUES (1, 'Basketball');
INSERT INTO Sport VALUES (2, 'Handball');
INSERT INTO Sport VALUES (3, 'Football');
INSERT INTO Sport VALUES (4, 'Lancer de troncs d''arbres');
INSERT INTO Sport VALUES (5, 'Porter de femme');
INSERT INTO Sport VALUES (6, 'Course d''orientation en sac');
INSERT INTO Sport VALUES (7, 'Breakdance');
INSERT INTO Sport VALUES (8, 'Hockey sur Gazon');
INSERT INTO Sport VALUES (9, 'Pétanque');
INSERT INTO Sport VALUES (10, 'Molkky');
INSERT INTO Sport VALUES (11, 'Tennis de table');
INSERT INTO Sport VALUES (12, 'Judo');

-- Content from file Gymnase --
--INSERT INTO Gymnase VALUES (1, 'Gymnase Municipal de Mourenx', '64150 Rue Gaston de Foix, 64150 Mourenx', 250);
--INSERT INTO Gymnase VALUES (123, 'Gymnase InShape', '64150 Rue de Tibo, 64150 Mourenx', 150);
INSERT INTO Gymnase VALUES (44, 'Sieges rouges', 'salle de spectable de Mou, 64150 Mourenx', 64);
INSERT INTO Gymnase VALUES (43, 'Le mix', 'salle de spectacle de Mou, 64150 Mourenx', 92);
INSERT INTO Gymnase VALUES (15, 'Salle principale', '16 place de la Liberté', 28);
INSERT INTO Gymnase VALUES (14, 'Terasse', '16 place de la Liberté', 12);
INSERT INTO Gymnase VALUES (41, 'Salle des fetes', 'Place du fronton 64520 Bidache', 80);
INSERT INTO Gymnase VALUES (42, 'Salle polyvalente', 'Place du fronton 64520 Bidache', 120);

-- Content from file SportGymnase --
INSERT INTO SportGymnase VALUES (44,1);
INSERT INTO SportGymnase VALUES (44,5);
INSERT INTO SportGymnase VALUES (44,6);
INSERT INTO SportGymnase VALUES (44,7);
INSERT INTO SportGymnase VALUES (44,9);
INSERT INTO SportGymnase VALUES (44,10);
INSERT INTO SportGymnase VALUES (44,11);
INSERT INTO SportGymnase VALUES (43,1);
INSERT INTO SportGymnase VALUES (43,4);
INSERT INTO SportGymnase VALUES (43,5);
INSERT INTO SportGymnase VALUES (43,6);
INSERT INTO SportGymnase VALUES (43,7);
INSERT INTO SportGymnase VALUES (43,9);
INSERT INTO SportGymnase VALUES (43,10);
INSERT INTO SportGymnase VALUES (43,11);
INSERT INTO SportGymnase VALUES (43,12);
INSERT INTO SportGymnase VALUES (15,1);
INSERT INTO SportGymnase VALUES (15,2);
INSERT INTO SportGymnase VALUES (15,3);
INSERT INTO SportGymnase VALUES (15,7);
INSERT INTO SportGymnase VALUES (15,12);
INSERT INTO SportGymnase VALUES (14,4);
INSERT INTO SportGymnase VALUES (14,5);
INSERT INTO SportGymnase VALUES (14,6);
INSERT INTO SportGymnase VALUES (14,7);
INSERT INTO SportGymnase VALUES (14,8);
INSERT INTO SportGymnase VALUES (14,9);
INSERT INTO SportGymnase VALUES (14,10);
INSERT INTO SportGymnase VALUES (14,11);
INSERT INTO SportGymnase VALUES (14,12);
INSERT INTO SportGymnase VALUES (41,1);
INSERT INTO SportGymnase VALUES (41,2);
INSERT INTO SportGymnase VALUES (41,3);
INSERT INTO SportGymnase VALUES (41,4);
INSERT INTO SportGymnase VALUES (41,5);
INSERT INTO SportGymnase VALUES (41,6);
INSERT INTO SportGymnase VALUES (41,7);
INSERT INTO SportGymnase VALUES (41,9);
INSERT INTO SportGymnase VALUES (41,10);
INSERT INTO SportGymnase VALUES (41,11);
INSERT INTO SportGymnase VALUES (41,12);
INSERT INTO SportGymnase VALUES (42,1);
INSERT INTO SportGymnase VALUES (42,2);
INSERT INTO SportGymnase VALUES (42,3);
INSERT INTO SportGymnase VALUES (42,6);
INSERT INTO SportGymnase VALUES (42,7);
INSERT INTO SportGymnase VALUES (42,8);
INSERT INTO SportGymnase VALUES (42,9);
INSERT INTO SportGymnase VALUES (42,10);
INSERT INTO SportGymnase VALUES (42,11);
INSERT INTO SportGymnase VALUES (42,12);
-- Content from file Competition --
-- Mettre les orga avant et savoir leurs id, ca va etre important
INSERT INTO Competition VALUES (1, 'Ball Busters', 120, '2024-06-22 14:00:00', 1, 32, 4, 8, 1, 43);
INSERT INTO Competition VALUES (12, 'Ball Busters', 120, '2024-06-23 14:00:00', 1, 32, 4, 8, 1, 42);
INSERT INTO Competition VALUES (13, 'Ball Busters', 120, '2024-06-24 14:00:00', 1, 32, 4, 8, 1, 43);
INSERT INTO Competition VALUES (21, 'Ball Busters', 120, '2024-06-24 08:00:00', 1, 32, 4, 8, 1, 41);

INSERT INTO Competition VALUES (2, 'Hand''s off', 120, '2024-06-20 08:00:00', 2, 40, 4, 10, 2, 42);
INSERT INTO Competition VALUES (14, 'Hand''s off', 120, '2024-06-21 08:00:00', 2, 40, 4, 10, 2, 42);
INSERT INTO Competition VALUES (15, 'Hand''s off', 120, '2024-06-22 08:00:00', 2, 40, 4, 10, 2, 42);

INSERT INTO Competition VALUES (3, 'Soccer Royale', 120, '2024-06-24 14:00:00', 1, 24, 3, 12, 3, 42);
INSERT INTO Competition VALUES (16, 'Soccer Royale', 120, '2024-06-25 14:00:00', 3, 24, 3, 12, 3, 42);
INSERT INTO Competition VALUES (17, 'Soccer Royale', 120, '2024-06-26 14:00:00', 1, 24, 3, 12, 3, 42);

INSERT INTO Competition VALUES (4, 'Lancer de troncs d''arbre', 120, '2024-06-20 08:00:00', 3, 5, 1, 5, 4, 14);

INSERT INTO Competition VALUES (5, 'Porter de femme', 120, '2024-06-21 08:00:00', 3, 10, 1, 10, 5, 44);

INSERT INTO Competition VALUES (6, 'Sacathlon', 120, '2024-06-22 08:00:00', 3, 5, 1, 5, 6, 14);

INSERT INTO Competition VALUES (7, 'Breakdance', 120, '2024-06-23 08:00:00', 2, 10, 3, 5, 7, 42);
INSERT INTO Competition VALUES (18, 'Breakdance', 120, '2024-06-24 08:00:00', 2, 10, 3, 5, 7, 42);

INSERT INTO Competition VALUES (8, 'Hockey sur gazon', 120,'2024-06-25 08:00:00', 3, 2, 2, 10, 8, 14);

INSERT INTO Competition VALUES (9, 'Pétanque', 120, '2024-06-25 08:00:00', 1, 5, 2, 3, 9, 42);

INSERT INTO Competition VALUES (20, 'Molkky', 120, '2024-06-25 08:00:00', 1, 5, 2, 3,10,41);

INSERT INTO Competition VALUES (10, 'Tennis de Table', 120, '2024-06-26 08:00:00', 2, 6, 2, 3, 11, 42);

INSERT INTO Competition VALUES (11, 'Judo', 120, '2024-06-26 14:00:00', 1, 6, 2, 3, 12, 41);
INSERT INTO Competition VALUES (19, 'Judo', 120, '2024-06-26 08:00:00', 3, 6, 2, 3, 12, 41);


-- Content from file Role --
--compet 1 : 4 arbitres | 32 sportifs | Places restantes : 56 (le 22/06 à 14h)
INSERT INTO Role VALUES (1,1,0,1,1);

INSERT INTO Role VALUES (4,1,0,1,0);
INSERT INTO Role VALUES (5,1,0,1,0);
INSERT INTO Role VALUES (8,1,0,1,0);

INSERT INTO Role VALUES (983, 1, 1, 0, 0);
INSERT INTO Role VALUES (843, 1, 1, 0, 0);
INSERT INTO Role VALUES (134, 1, 1, 0, 0);
INSERT INTO Role VALUES (770, 1, 1, 0, 0);
INSERT INTO Role VALUES (742, 1, 1, 0, 0);
INSERT INTO Role VALUES (642, 1, 1, 0, 0);
INSERT INTO Role VALUES (112, 1, 1, 0, 0);
INSERT INTO Role VALUES (648, 1, 1, 0, 0);
INSERT INTO Role VALUES (610, 1, 1, 0, 0);
INSERT INTO Role VALUES (252, 1, 1, 0, 0);
INSERT INTO Role VALUES (626, 1, 1, 0, 0);
INSERT INTO Role VALUES (924, 1, 1, 0, 0);
INSERT INTO Role VALUES (639, 1, 1, 0, 0);
INSERT INTO Role VALUES (999, 1, 1, 0, 0);
INSERT INTO Role VALUES (689, 1, 1, 0, 0);
INSERT INTO Role VALUES (822, 1, 1, 0, 0);
INSERT INTO Role VALUES (302, 1, 1, 0, 0);
INSERT INTO Role VALUES (284, 1, 1, 0, 0);
INSERT INTO Role VALUES (478, 1, 1, 0, 0);
INSERT INTO Role VALUES (104, 1, 1, 0, 0);
INSERT INTO Role VALUES (6, 1, 1, 0, 0);
INSERT INTO Role VALUES (58, 1, 1, 0, 0);
INSERT INTO Role VALUES (707, 1, 1, 0, 0);
INSERT INTO Role VALUES (562, 1, 1, 0, 0);
INSERT INTO Role VALUES (936, 1, 1, 0, 0);
INSERT INTO Role VALUES (39, 1, 1, 0, 0);
INSERT INTO Role VALUES (279, 1, 1, 0, 0);
INSERT INTO Role VALUES (497, 1, 1, 0, 0);
INSERT INTO Role VALUES (70, 1, 1, 0, 0);
INSERT INTO Role VALUES (150, 1, 1, 0, 0);
INSERT INTO Role VALUES (704, 1, 1, 0, 0);
INSERT INTO Role VALUES (558, 1, 1, 0, 0);

--compet 2 : 4 arbitres | 40 sportifs | Places restantes : 76 (le 20/06 à 8h)
INSERT INTO Role VALUES (2,2,0,1,1);

INSERT INTO Role VALUES (10,2,0,1,0);
INSERT INTO Role VALUES (12,2,0,1,0);
INSERT INTO Role VALUES (4,2,0,1,0);

INSERT INTO Role VALUES (536, 2, 1, 0, 0);
INSERT INTO Role VALUES (212, 2, 1, 0, 0);
INSERT INTO Role VALUES (701, 2, 1, 0, 0);
INSERT INTO Role VALUES (56, 2, 1, 0, 0);
INSERT INTO Role VALUES (169, 2, 1, 0, 0);
INSERT INTO Role VALUES (713, 2, 1, 0, 0);
INSERT INTO Role VALUES (956, 2, 1, 0, 0);
INSERT INTO Role VALUES (839, 2, 1, 0, 0);
INSERT INTO Role VALUES (653, 2, 1, 0, 0);
INSERT INTO Role VALUES (710, 2, 1, 0, 0);
INSERT INTO Role VALUES (815, 2, 1, 0, 0);
INSERT INTO Role VALUES (331, 2, 1, 0, 0);
INSERT INTO Role VALUES (288, 2, 1, 0, 0);
INSERT INTO Role VALUES (249, 2, 1, 0, 0);
INSERT INTO Role VALUES (582, 2, 1, 0, 0);
INSERT INTO Role VALUES (327, 2, 1, 0, 0);
INSERT INTO Role VALUES (72, 2, 1, 0, 0);
INSERT INTO Role VALUES (68, 2, 1, 0, 0);
INSERT INTO Role VALUES (720, 2, 1, 0, 0);
INSERT INTO Role VALUES (479, 2, 1, 0, 0);
INSERT INTO Role VALUES (374, 2, 1, 0, 0);
INSERT INTO Role VALUES (500, 2, 1, 0, 0);
INSERT INTO Role VALUES (534, 2, 1, 0, 0);
INSERT INTO Role VALUES (865, 2, 1, 0, 0);
INSERT INTO Role VALUES (728, 2, 1, 0, 0);
INSERT INTO Role VALUES (59, 2, 1, 0, 0);
INSERT INTO Role VALUES (888, 2, 1, 0, 0);
INSERT INTO Role VALUES (643, 2, 1, 0, 0);
INSERT INTO Role VALUES (420, 2, 1, 0, 0);
INSERT INTO Role VALUES (25, 2, 1, 0, 0);
INSERT INTO Role VALUES (329, 2, 1, 0, 0);
INSERT INTO Role VALUES (309, 2, 1, 0, 0);
INSERT INTO Role VALUES (494, 2, 1, 0, 0);
INSERT INTO Role VALUES (412, 2, 1, 0, 0);
INSERT INTO Role VALUES (591, 2, 1, 0, 0);
INSERT INTO Role VALUES (807, 2, 1, 0, 0);
INSERT INTO Role VALUES (527, 2, 1, 0, 0);
INSERT INTO Role VALUES (290, 2, 1, 0, 0);
INSERT INTO Role VALUES (181, 2, 1, 0, 0);
INSERT INTO Role VALUES (120, 2, 1, 0, 0);

--compet 3 : 3 arbitres | 24 sportifs | Places restantes : 93 (le 24/06 à 14h)
INSERT INTO Role VALUES (1,3,0,1,1);

INSERT INTO Role VALUES (14,3,0,1,0);
INSERT INTO Role VALUES (16,3,0,1,0);

INSERT INTO Role VALUES (805, 3, 1, 0, 0);
INSERT INTO Role VALUES (549, 3, 1, 0, 0);
INSERT INTO Role VALUES (396, 3, 1, 0, 0);
INSERT INTO Role VALUES (683, 3, 1, 0, 0);
INSERT INTO Role VALUES (801, 3, 1, 0, 0);
INSERT INTO Role VALUES (135, 3, 1, 0, 0);
INSERT INTO Role VALUES (971, 3, 1, 0, 0);
INSERT INTO Role VALUES (655, 3, 1, 0, 0);
INSERT INTO Role VALUES (961, 3, 1, 0, 0);
INSERT INTO Role VALUES (163, 3, 1, 0, 0);
INSERT INTO Role VALUES (51, 3, 1, 0, 0);
INSERT INTO Role VALUES (315, 3, 1, 0, 0);
INSERT INTO Role VALUES (367, 3, 1, 0, 0);
INSERT INTO Role VALUES (732, 3, 1, 0, 0);
INSERT INTO Role VALUES (392, 3, 1, 0, 0);
INSERT INTO Role VALUES (921, 3, 1, 0, 0);
INSERT INTO Role VALUES (78, 3, 1, 0, 0);
INSERT INTO Role VALUES (866, 3, 1, 0, 0);
INSERT INTO Role VALUES (916, 3, 1, 0, 0);
INSERT INTO Role VALUES (769, 3, 1, 0, 0);
INSERT INTO Role VALUES (951, 3, 1, 0, 0);
INSERT INTO Role VALUES (638, 3, 1, 0, 0);
INSERT INTO Role VALUES (305, 3, 1, 0, 0);
INSERT INTO Role VALUES (116, 3, 1, 0, 0);

--compet 4 : 1 arbitres | 5 sportifs | Places restantes : 6 (le 20/06 à 8h)
INSERT INTO Role VALUES (3,4,0,1,1);

INSERT INTO Role VALUES (733, 4, 1, 0, 0);
INSERT INTO Role VALUES (371, 4, 1, 0, 0);
INSERT INTO Role VALUES (816, 4, 1, 0, 0);
INSERT INTO Role VALUES (611, 4, 1, 0, 0);
INSERT INTO Role VALUES (468, 4, 1, 0, 0);

--compet 5 : 1 arbitres | 10 sportifs | Places restantes : 53 (le 21/06 à 8h)
INSERT INTO Role VALUES (3,5,0,1,1);

INSERT INTO Role VALUES (878, 5, 1, 0, 0);
INSERT INTO Role VALUES (143, 5, 1, 0, 0);
INSERT INTO Role VALUES (423, 5, 1, 0, 0);
INSERT INTO Role VALUES (100, 5, 1, 0, 0);
INSERT INTO Role VALUES (510, 5, 1, 0, 0);
INSERT INTO Role VALUES (563, 5, 1, 0, 0);
INSERT INTO Role VALUES (893, 5, 1, 0, 0);
INSERT INTO Role VALUES (795, 5, 1, 0, 0);
INSERT INTO Role VALUES (375, 5, 1, 0, 0);
INSERT INTO Role VALUES (73, 5, 1, 0, 0);

--compet 6 : 1 arbitres | 5 sportifs | Places restantes : 6 (le 22/06 à 8h)
INSERT INTO Role VALUES (3,6,0,1,1);

INSERT INTO Role VALUES (915, 6, 1, 0, 0);
INSERT INTO Role VALUES (934, 6, 1, 0, 0);
INSERT INTO Role VALUES (263, 6, 1, 0, 0);
INSERT INTO Role VALUES (656, 6, 1, 0, 0);
INSERT INTO Role VALUES (291, 6, 1, 0, 0);

--compet 7 : 3 arbitres | 10 sportifs | Places restantes : 107  (le 23/06 à 8h)
INSERT INTO Role VALUES (2,7,0,1,1);

INSERT INTO Role VALUES (18,7,0,1,0);
INSERT INTO Role VALUES (20,7,0,1,0);

INSERT INTO Role VALUES (179, 7, 1, 0, 0);
INSERT INTO Role VALUES (711, 7, 1, 0, 0);
INSERT INTO Role VALUES (182, 7, 1, 0, 0);
INSERT INTO Role VALUES (991, 7, 1, 0, 0);
INSERT INTO Role VALUES (280, 7, 1, 0, 0);
INSERT INTO Role VALUES (998, 7, 1, 0, 0);
INSERT INTO Role VALUES (465, 7, 1, 0, 0);
INSERT INTO Role VALUES (357, 7, 1, 0, 0);
INSERT INTO Role VALUES (298, 7, 1, 0, 0);
INSERT INTO Role VALUES (629, 7, 1, 0, 0);

--compet 8 : 2 arbitres | 2 sportifs | Places restantes : 8  (le 25/06 à 8h)
INSERT INTO Role VALUES (3,8,0,1,1);

INSERT INTO Role VALUES (21,8,0,1,0);

INSERT INTO Role VALUES (513, 8, 1, 0, 0);
INSERT INTO Role VALUES (518, 8, 1, 0, 0);

--compet 9 : 2 arbitres | 5 sportifs | Places restantes : 113  (le 25/06 à 8h) 
INSERT INTO Role VALUES (1,9,0,1,1);

INSERT INTO Role VALUES (22,9,0,1,0);

INSERT INTO Role VALUES (986, 9, 1, 0, 0);
INSERT INTO Role VALUES (817, 9, 1, 0, 0);
INSERT INTO Role VALUES (530, 9, 1, 0, 0);
INSERT INTO Role VALUES (410, 9, 1, 0, 0);
INSERT INTO Role VALUES (119, 9, 1, 0, 0);

--compet 10 : 2 arbitres | 6 sportifs | Places restantes : 112  (le 26/06 à 8h)
INSERT INTO Role VALUES (2,10,0,1,1);

INSERT INTO Role VALUES (27,10,0,1,0);

INSERT INTO Role VALUES (227, 10, 1, 0, 0);
INSERT INTO Role VALUES (205, 10, 1, 0, 0);
INSERT INTO Role VALUES (982, 10, 1, 0, 0);
INSERT INTO Role VALUES (441, 10, 1, 0, 0);
INSERT INTO Role VALUES (85, 10, 1, 0, 0);
INSERT INTO Role VALUES (953, 10, 1, 0, 0);

--compet 11 : 2 arbitres | 6 sportifs | Places restantes : 72  (le 26/06 à 14h)
INSERT INTO Role VALUES (1,11,0,1,1);

INSERT INTO Role VALUES (4,11,0,1,0);

INSERT INTO Role VALUES (353, 11, 1, 0, 0);
INSERT INTO Role VALUES (690, 11, 1, 0, 0);
INSERT INTO Role VALUES (336, 11, 1, 0, 0);
INSERT INTO Role VALUES (293, 11, 1, 0, 0);
INSERT INTO Role VALUES (781, 11, 1, 0, 0);
INSERT INTO Role VALUES (621, 11, 1, 0, 0);

--compet 12 : 4 arbitres | 32 sportifs | Places restantes : 84  (le 23/06 à 14h)
INSERT INTO Role VALUES (1,12,0,1,1);

INSERT INTO Role VALUES (5,12,0,1,0);
INSERT INTO Role VALUES (8,12,0,1,0);
INSERT INTO Role VALUES (10,12,0,1,0);

INSERT INTO Role VALUES (211, 12, 1, 0, 0);
INSERT INTO Role VALUES (910, 12, 1, 0, 0);
INSERT INTO Role VALUES (421, 12, 1, 0, 0);
INSERT INTO Role VALUES (406, 12, 1, 0, 0);
INSERT INTO Role VALUES (210, 12, 1, 0, 0);
INSERT INTO Role VALUES (525, 12, 1, 0, 0);
INSERT INTO Role VALUES (165, 12, 1, 0, 0);
INSERT INTO Role VALUES (385, 12, 1, 0, 0);
INSERT INTO Role VALUES (230, 12, 1, 0, 0);
INSERT INTO Role VALUES (255, 12, 1, 0, 0);
INSERT INTO Role VALUES (42, 12, 1, 0, 0);
INSERT INTO Role VALUES (925, 12, 1, 0, 0);
INSERT INTO Role VALUES (432, 12, 1, 0, 0);
INSERT INTO Role VALUES (572, 12, 1, 0, 0);
INSERT INTO Role VALUES (764, 12, 1, 0, 0);
INSERT INTO Role VALUES (523, 12, 1, 0, 0);
INSERT INTO Role VALUES (727, 12, 1, 0, 0);
INSERT INTO Role VALUES (102, 12, 1, 0, 0);
INSERT INTO Role VALUES (766, 12, 1, 0, 0);
INSERT INTO Role VALUES (761, 12, 1, 0, 0);
INSERT INTO Role VALUES (40, 12, 1, 0, 0);
INSERT INTO Role VALUES (136, 12, 1, 0, 0);
INSERT INTO Role VALUES (765, 12, 1, 0, 0);
INSERT INTO Role VALUES (697, 12, 1, 0, 0);
INSERT INTO Role VALUES (980, 12, 1, 0, 0);
INSERT INTO Role VALUES (206, 12, 1, 0, 0);
INSERT INTO Role VALUES (323, 12, 1, 0, 0);
INSERT INTO Role VALUES (98, 12, 1, 0, 0);
INSERT INTO Role VALUES (320, 12, 1, 0, 0);
INSERT INTO Role VALUES (384, 12, 1, 0, 0);
INSERT INTO Role VALUES (544, 12, 1, 0, 0);
INSERT INTO Role VALUES (559, 12, 1, 0, 0);

--compet 13 : 4 arbitres | 32 sportifs | Places restantes : 56  (le 24/06 à 14h)
INSERT INTO Role VALUES (1,13,0,1,1);

INSERT INTO Role VALUES (12,13,0,1,0);
INSERT INTO Role VALUES (18,13,0,1,0);
INSERT INTO Role VALUES (20,13,0,1,0);

INSERT INTO Role VALUES (481, 13, 1, 0, 0);
INSERT INTO Role VALUES (550, 13, 1, 0, 0);
INSERT INTO Role VALUES (545, 13, 1, 0, 0);
INSERT INTO Role VALUES (989, 13, 1, 0, 0);
INSERT INTO Role VALUES (170, 13, 1, 0, 0);
INSERT INTO Role VALUES (342, 13, 1, 0, 0);
INSERT INTO Role VALUES (904, 13, 1, 0, 0);
INSERT INTO Role VALUES (564, 13, 1, 0, 0);
INSERT INTO Role VALUES (975, 13, 1, 0, 0);
INSERT INTO Role VALUES (845, 13, 1, 0, 0);
INSERT INTO Role VALUES (183, 13, 1, 0, 0);
INSERT INTO Role VALUES (830, 13, 1, 0, 0);
INSERT INTO Role VALUES (162, 13, 1, 0, 0);
INSERT INTO Role VALUES (931, 13, 1, 0, 0);
INSERT INTO Role VALUES (1000, 13, 1, 0, 0);
INSERT INTO Role VALUES (758, 13, 1, 0, 0);
INSERT INTO Role VALUES (231, 13, 1, 0, 0);
INSERT INTO Role VALUES (79, 13, 1, 0, 0);
INSERT INTO Role VALUES (264, 13, 1, 0, 0);
INSERT INTO Role VALUES (234, 13, 1, 0, 0);
INSERT INTO Role VALUES (735, 13, 1, 0, 0);
INSERT INTO Role VALUES (985, 13, 1, 0, 0);
INSERT INTO Role VALUES (787, 13, 1, 0, 0);
INSERT INTO Role VALUES (173, 13, 1, 0, 0);
INSERT INTO Role VALUES (318, 13, 1, 0, 0);
INSERT INTO Role VALUES (808, 13, 1, 0, 0);
INSERT INTO Role VALUES (786, 13, 1, 0, 0);
INSERT INTO Role VALUES (203, 13, 1, 0, 0);
INSERT INTO Role VALUES (492, 13, 1, 0, 0);
INSERT INTO Role VALUES (34, 13, 1, 0, 0);
INSERT INTO Role VALUES (215, 13, 1, 0, 0);
INSERT INTO Role VALUES (274, 13, 1, 0, 0);

--compet 14 : 4 arbitres | 40 sportifs | Places restantes : 76  (le 21/06 à 8h)
INSERT INTO Role VALUES (2,14,0,1,1);

INSERT INTO Role VALUES (14,14,0,1,0);
INSERT INTO Role VALUES (16,14,0,1,0);
INSERT INTO Role VALUES (21,14,0,1,0);

INSERT INTO Role VALUES (538, 14, 1, 0, 0);
INSERT INTO Role VALUES (244, 14, 1, 0, 0);
INSERT INTO Role VALUES (31, 14, 1, 0, 0);
INSERT INTO Role VALUES (520, 14, 1, 0, 0);
INSERT INTO Role VALUES (594, 14, 1, 0, 0);
INSERT INTO Role VALUES (973, 14, 1, 0, 0);
INSERT INTO Role VALUES (547, 14, 1, 0, 0);
INSERT INTO Role VALUES (825, 14, 1, 0, 0);
INSERT INTO Role VALUES (966, 14, 1, 0, 0);
INSERT INTO Role VALUES (373, 14, 1, 0, 0);
INSERT INTO Role VALUES (754, 14, 1, 0, 0);
INSERT INTO Role VALUES (370, 14, 1, 0, 0);
INSERT INTO Role VALUES (391, 14, 1, 0, 0);
INSERT INTO Role VALUES (397, 14, 1, 0, 0);
INSERT INTO Role VALUES (853, 14, 1, 0, 0);
INSERT INTO Role VALUES (250, 14, 1, 0, 0);
INSERT INTO Role VALUES (788, 14, 1, 0, 0);
INSERT INTO Role VALUES (632, 14, 1, 0, 0);
INSERT INTO Role VALUES (430, 14, 1, 0, 0);
INSERT INTO Role VALUES (870, 14, 1, 0, 0);
INSERT INTO Role VALUES (869, 14, 1, 0, 0);
INSERT INTO Role VALUES (489, 14, 1, 0, 0);
INSERT INTO Role VALUES (292, 14, 1, 0, 0);
INSERT INTO Role VALUES (671, 14, 1, 0, 0);
INSERT INTO Role VALUES (172, 14, 1, 0, 0);
INSERT INTO Role VALUES (389, 14, 1, 0, 0);
INSERT INTO Role VALUES (340, 14, 1, 0, 0);
INSERT INTO Role VALUES (418, 14, 1, 0, 0);
INSERT INTO Role VALUES (958, 14, 1, 0, 0);
INSERT INTO Role VALUES (428, 14, 1, 0, 0);
INSERT INTO Role VALUES (127, 14, 1, 0, 0);
INSERT INTO Role VALUES (152, 14, 1, 0, 0);
INSERT INTO Role VALUES (968, 14, 1, 0, 0);
INSERT INTO Role VALUES (709, 14, 1, 0, 0);
INSERT INTO Role VALUES (757, 14, 1, 0, 0);
INSERT INTO Role VALUES (461, 14, 1, 0, 0);
INSERT INTO Role VALUES (200, 14, 1, 0, 0);
INSERT INTO Role VALUES (819, 14, 1, 0, 0);
INSERT INTO Role VALUES (287, 14, 1, 0, 0);
INSERT INTO Role VALUES (714, 14, 1, 0, 0);

--compet 15 : 4 arbitres | 40 sportifs | Places restantes : 76  (le 22/06 à 8h)
INSERT INTO Role VALUES (2,15,0,1,1);

INSERT INTO Role VALUES (22,15,0,1,0);
INSERT INTO Role VALUES (27,15,0,1,0);
INSERT INTO Role VALUES (4,15,0,1,0);

INSERT INTO Role VALUES (191, 15, 1, 0, 0);
INSERT INTO Role VALUES (616, 15, 1, 0, 0);
INSERT INTO Role VALUES (522, 15, 1, 0, 0);
INSERT INTO Role VALUES (589, 15, 1, 0, 0);
INSERT INTO Role VALUES (491, 15, 1, 0, 0);
INSERT INTO Role VALUES (813, 15, 1, 0, 0);
INSERT INTO Role VALUES (670, 15, 1, 0, 0);
INSERT INTO Role VALUES (913, 15, 1, 0, 0);
INSERT INTO Role VALUES (140, 15, 1, 0, 0);
INSERT INTO Role VALUES (918, 15, 1, 0, 0);
INSERT INTO Role VALUES (552, 15, 1, 0, 0);
INSERT INTO Role VALUES (740, 15, 1, 0, 0);
INSERT INTO Role VALUES (627, 15, 1, 0, 0);
INSERT INTO Role VALUES (118, 15, 1, 0, 0);
INSERT INTO Role VALUES (844, 15, 1, 0, 0);
INSERT INTO Role VALUES (121, 15, 1, 0, 0);
INSERT INTO Role VALUES (326, 15, 1, 0, 0);
INSERT INTO Role VALUES (404, 15, 1, 0, 0);
INSERT INTO Role VALUES (723, 15, 1, 0, 0);
INSERT INTO Role VALUES (677, 15, 1, 0, 0);
INSERT INTO Role VALUES (387, 15, 1, 0, 0);
INSERT INTO Role VALUES (927, 15, 1, 0, 0);
INSERT INTO Role VALUES (348, 15, 1, 0, 0);
INSERT INTO Role VALUES (688, 15, 1, 0, 0);
INSERT INTO Role VALUES (130, 15, 1, 0, 0);
INSERT INTO Role VALUES (736, 15, 1, 0, 0);
INSERT INTO Role VALUES (744, 15, 1, 0, 0);
INSERT INTO Role VALUES (123, 15, 1, 0, 0);
INSERT INTO Role VALUES (509, 15, 1, 0, 0);
INSERT INTO Role VALUES (570, 15, 1, 0, 0);
INSERT INTO Role VALUES (345, 15, 1, 0, 0);
INSERT INTO Role VALUES (857, 15, 1, 0, 0);
INSERT INTO Role VALUES (238, 15, 1, 0, 0);
INSERT INTO Role VALUES (992, 15, 1, 0, 0);
INSERT INTO Role VALUES (920, 15, 1, 0, 0);
INSERT INTO Role VALUES (512, 15, 1, 0, 0);
INSERT INTO Role VALUES (739, 15, 1, 0, 0);
INSERT INTO Role VALUES (726, 15, 1, 0, 0);
INSERT INTO Role VALUES (429, 15, 1, 0, 0);
INSERT INTO Role VALUES (776, 15, 1, 0, 0);

--compet 16 : 3 arbitres | 24 sportifs | Places restantes : 92  (le 25/06 à 14h)
INSERT INTO Role VALUES (3,16,0,1,1);

INSERT INTO Role VALUES (5,16,0,1,0);
INSERT INTO Role VALUES (8,16,0,1,0);

INSERT INTO Role VALUES (117, 16, 1, 0, 0);
INSERT INTO Role VALUES (289, 16, 1, 0, 0);
INSERT INTO Role VALUES (324, 16, 1, 0, 0);
INSERT INTO Role VALUES (101, 16, 1, 0, 0);
INSERT INTO Role VALUES (729, 16, 1, 0, 0);
INSERT INTO Role VALUES (791, 16, 1, 0, 0);
INSERT INTO Role VALUES (196, 16, 1, 0, 0);
INSERT INTO Role VALUES (654, 16, 1, 0, 0);
INSERT INTO Role VALUES (294, 16, 1, 0, 0);
INSERT INTO Role VALUES (811, 16, 1, 0, 0);
INSERT INTO Role VALUES (734, 16, 1, 0, 0);
INSERT INTO Role VALUES (202, 16, 1, 0, 0);
INSERT INTO Role VALUES (962, 16, 1, 0, 0);
INSERT INTO Role VALUES (923, 16, 1, 0, 0);
INSERT INTO Role VALUES (62, 16, 1, 0, 0);
INSERT INTO Role VALUES (88, 16, 1, 0, 0);
INSERT INTO Role VALUES (748, 16, 1, 0, 0);
INSERT INTO Role VALUES (339, 16, 1, 0, 0);
INSERT INTO Role VALUES (443, 16, 1, 0, 0);
INSERT INTO Role VALUES (388, 16, 1, 0, 0);
INSERT INTO Role VALUES (422, 16, 1, 0, 0);
INSERT INTO Role VALUES (129, 16, 1, 0, 0);
INSERT INTO Role VALUES (242, 16, 1, 0, 0);
INSERT INTO Role VALUES (660, 16, 1, 0, 0);

--compet 17 : 3 arbitres | 24 sportifs | Places restantes : 92  (le 26/06 à 14h)
INSERT INTO Role VALUES (1,17,0,1,1);

INSERT INTO Role VALUES (10,17,0,1,0);
INSERT INTO Role VALUES (12,17,0,1,0);

INSERT INTO Role VALUES (146, 17, 1, 0, 0);
INSERT INTO Role VALUES (835, 17, 1, 0, 0);
INSERT INTO Role VALUES (46, 17, 1, 0, 0);
INSERT INTO Role VALUES (944, 17, 1, 0, 0);
INSERT INTO Role VALUES (456, 17, 1, 0, 0);
INSERT INTO Role VALUES (658, 17, 1, 0, 0);
INSERT INTO Role VALUES (401, 17, 1, 0, 0);
INSERT INTO Role VALUES (314, 17, 1, 0, 0);
INSERT INTO Role VALUES (988, 17, 1, 0, 0);
INSERT INTO Role VALUES (963, 17, 1, 0, 0);
INSERT INTO Role VALUES (184, 17, 1, 0, 0);
INSERT INTO Role VALUES (49, 17, 1, 0, 0);
INSERT INTO Role VALUES (737, 17, 1, 0, 0);
INSERT INTO Role VALUES (313, 17, 1, 0, 0);
INSERT INTO Role VALUES (661, 17, 1, 0, 0);
INSERT INTO Role VALUES (316, 17, 1, 0, 0);
INSERT INTO Role VALUES (551, 17, 1, 0, 0);
INSERT INTO Role VALUES (793, 17, 1, 0, 0);
INSERT INTO Role VALUES (674, 17, 1, 0, 0);
INSERT INTO Role VALUES (464, 17, 1, 0, 0);
INSERT INTO Role VALUES (907, 17, 1, 0, 0);
INSERT INTO Role VALUES (91, 17, 1, 0, 0);
INSERT INTO Role VALUES (77, 17, 1, 0, 0);
INSERT INTO Role VALUES (586, 17, 1, 0, 0);

--compet 18 : 3 arbitres | 10 sportifs | Places restantes : 107  (le 24/06 à 8h)
INSERT INTO Role VALUES (2,18,0,1,1);

INSERT INTO Role VALUES (14,18,0,1,0);
INSERT INTO Role VALUES (16,18,0,1,0);

INSERT INTO Role VALUES (485, 18, 1, 0, 0);
INSERT INTO Role VALUES (52, 18, 1, 0, 0);
INSERT INTO Role VALUES (556, 18, 1, 0, 0);
INSERT INTO Role VALUES (303, 18, 1, 0, 0);
INSERT INTO Role VALUES (803, 18, 1, 0, 0);
INSERT INTO Role VALUES (581, 18, 1, 0, 0);
INSERT INTO Role VALUES (496, 18, 1, 0, 0);
INSERT INTO Role VALUES (198, 18, 1, 0, 0);
INSERT INTO Role VALUES (647, 18, 1, 0, 0);
INSERT INTO Role VALUES (462, 18, 1, 0, 0);

--compet 19 : 2 arbitres | 6 sportifs | Places restantes : 72  (le 26/06 à 8h)
INSERT INTO Role VALUES (3,19,0,1,1);

INSERT INTO Role VALUES (18,19,0,1,0);

INSERT INTO Role VALUES (362, 19, 1, 0, 0);
INSERT INTO Role VALUES (700, 19, 1, 0, 0);
INSERT INTO Role VALUES (82, 19, 1, 0, 0);
INSERT INTO Role VALUES (187, 19, 1, 0, 0);
INSERT INTO Role VALUES (762, 19, 1, 0, 0);
INSERT INTO Role VALUES (573, 19, 1, 0, 0);

--compet 20 : 2 arbitres | 5 sportifs | Places restantes : 73 (le 25/06 à 8h) 
INSERT INTO Role VALUES (1,20,0,1,1);

INSERT INTO Role VALUES (20,20,0,1,0);

INSERT INTO Role VALUES (553, 20, 1, 0, 0);
INSERT INTO Role VALUES (180, 20, 1, 0, 0);
INSERT INTO Role VALUES (174, 20, 1, 0, 0);
INSERT INTO Role VALUES (360, 20, 1, 0, 0);
INSERT INTO Role VALUES (201, 20, 1, 0, 0);

--compet 21 : 4 arbitres | 32 sportifs | Places restantes : 44  (le 24/06 à 8h)
--Pour suivre la 2e étapes du mail, sera identique à la compet 1 dans un autre gymnase, jour et horaire
--Aucun spectateur !!!!
INSERT INTO Role VALUES (1,21,0,1,1);

INSERT INTO Role VALUES (4,21,0,1,0);
INSERT INTO Role VALUES (5,21,0,1,0);
INSERT INTO Role VALUES (8,21,0,1,0);

INSERT INTO Role VALUES (861, 21, 1, 0, 0);
INSERT INTO Role VALUES (317, 21, 1, 0, 0);
INSERT INTO Role VALUES (306, 21, 1, 0, 0);
INSERT INTO Role VALUES (579, 21, 1, 0, 0);
INSERT INTO Role VALUES (682, 21, 1, 0, 0);
INSERT INTO Role VALUES (132, 21, 1, 0, 0);
INSERT INTO Role VALUES (248, 21, 1, 0, 0);
INSERT INTO Role VALUES (319, 21, 1, 0, 0);
INSERT INTO Role VALUES (297, 21, 1, 0, 0);
INSERT INTO Role VALUES (55, 21, 1, 0, 0);
INSERT INTO Role VALUES (408, 21, 1, 0, 0);
INSERT INTO Role VALUES (537, 21, 1, 0, 0);
INSERT INTO Role VALUES (154, 21, 1, 0, 0);
INSERT INTO Role VALUES (147, 21, 1, 0, 0);
INSERT INTO Role VALUES (258, 21, 1, 0, 0);
INSERT INTO Role VALUES (379, 21, 1, 0, 0);
INSERT INTO Role VALUES (806, 21, 1, 0, 0);
INSERT INTO Role VALUES (574, 21, 1, 0, 0);
INSERT INTO Role VALUES (23, 21, 1, 0, 0);
INSERT INTO Role VALUES (48, 21, 1, 0, 0);
INSERT INTO Role VALUES (378, 21, 1, 0, 0);
INSERT INTO Role VALUES (350, 21, 1, 0, 0);
INSERT INTO Role VALUES (569, 21, 1, 0, 0);
INSERT INTO Role VALUES (157, 21, 1, 0, 0);
INSERT INTO Role VALUES (782, 21, 1, 0, 0);
INSERT INTO Role VALUES (541, 21, 1, 0, 0);
INSERT INTO Role VALUES (849, 21, 1, 0, 0);
INSERT INTO Role VALUES (476, 21, 1, 0, 0);
INSERT INTO Role VALUES (725, 21, 1, 0, 0);
INSERT INTO Role VALUES (832, 21, 1, 0, 0);
INSERT INTO Role VALUES (528, 21, 1, 0, 0);
INSERT INTO Role VALUES (863, 21, 1, 0, 0);

INSERT INTO Role VALUES (1001, 13, 1);




-- Content from file Spectateur --
-- 92 incrit à la compétion 1 (Ball Busters)
-- Il n'y a que 56 places si on décompte les sportifs et arbitres

/*INSERT INTO Spectateur VALUES (5,1);
INSERT INTO Spectateur VALUES (520,1);
INSERT INTO Spectateur VALUES (9,1);
INSERT INTO Spectateur VALUES (12,1);
INSERT INTO Spectateur VALUES (276,1);
INSERT INTO Spectateur VALUES (20,1);
INSERT INTO Spectateur VALUES (25,1);
INSERT INTO Spectateur VALUES (539,1);
INSERT INTO Spectateur VALUES (286,1);
INSERT INTO Spectateur VALUES (546,1);
INSERT INTO Spectateur VALUES (291,1);
INSERT INTO Spectateur VALUES (808,1);
INSERT INTO Spectateur VALUES (552,1);
INSERT INTO Spectateur VALUES (558,1);
INSERT INTO Spectateur VALUES (50,1);
INSERT INTO Spectateur VALUES (306,1);
INSERT INTO Spectateur VALUES (308,1);
INSERT INTO Spectateur VALUES (822,1);
INSERT INTO Spectateur VALUES (315,1);
INSERT INTO Spectateur VALUES (65,1);
INSERT INTO Spectateur VALUES (321,1);
INSERT INTO Spectateur VALUES (67,1);
INSERT INTO Spectateur VALUES (838,1);
INSERT INTO Spectateur VALUES (327,1);
INSERT INTO Spectateur VALUES (328,1);
INSERT INTO Spectateur VALUES (73,1);
INSERT INTO Spectateur VALUES (585,1);
INSERT INTO Spectateur VALUES (80,1);
INSERT INTO Spectateur VALUES (603,1);
INSERT INTO Spectateur VALUES (606,1);
INSERT INTO Spectateur VALUES (610,1);
INSERT INTO Spectateur VALUES (100,1);
INSERT INTO Spectateur VALUES (872,1);
INSERT INTO Spectateur VALUES (618,1);
INSERT INTO Spectateur VALUES (622,1);
INSERT INTO Spectateur VALUES (623,1);*/
INSERT INTO Spectateur VALUES (630,1);
INSERT INTO Spectateur VALUES (890,1);
INSERT INTO Spectateur VALUES (892,1);
INSERT INTO Spectateur VALUES (389,1);
INSERT INTO Spectateur VALUES (396,1);
INSERT INTO Spectateur VALUES (398,1);
INSERT INTO Spectateur VALUES (911,1);
INSERT INTO Spectateur VALUES (142,1);
INSERT INTO Spectateur VALUES (144,1);
INSERT INTO Spectateur VALUES (660,1);
INSERT INTO Spectateur VALUES (150,1);
INSERT INTO Spectateur VALUES (663,1);
INSERT INTO Spectateur VALUES (665,1);
INSERT INTO Spectateur VALUES (670,1);
INSERT INTO Spectateur VALUES (161,1);
INSERT INTO Spectateur VALUES (675,1);
INSERT INTO Spectateur VALUES (420,1);
INSERT INTO Spectateur VALUES (676,1);
INSERT INTO Spectateur VALUES (419,1);
INSERT INTO Spectateur VALUES (932,1);
INSERT INTO Spectateur VALUES (168,1);
INSERT INTO Spectateur VALUES (426,1);
INSERT INTO Spectateur VALUES (682,1);
INSERT INTO Spectateur VALUES (684,1);
INSERT INTO Spectateur VALUES (685,1);
INSERT INTO Spectateur VALUES (428,1);
INSERT INTO Spectateur VALUES (174,1);
INSERT INTO Spectateur VALUES (688,1);
INSERT INTO Spectateur VALUES (689,1);
INSERT INTO Spectateur VALUES (176,1);
INSERT INTO Spectateur VALUES (440,1);
INSERT INTO Spectateur VALUES (965,1);
INSERT INTO Spectateur VALUES (201,1);
INSERT INTO Spectateur VALUES (459,1);
INSERT INTO Spectateur VALUES (461,1);
INSERT INTO Spectateur VALUES (465,1);
INSERT INTO Spectateur VALUES (212,1);
INSERT INTO Spectateur VALUES (471,1);
INSERT INTO Spectateur VALUES (728,1);
INSERT INTO Spectateur VALUES (217,1);
INSERT INTO Spectateur VALUES (473,1);
INSERT INTO Spectateur VALUES (474,1);
INSERT INTO Spectateur VALUES (987,1);
INSERT INTO Spectateur VALUES (221,1);
INSERT INTO Spectateur VALUES (734,1);
INSERT INTO Spectateur VALUES (993,1);
INSERT INTO Spectateur VALUES (737,1);
INSERT INTO Spectateur VALUES (738,1);
INSERT INTO Spectateur VALUES (995,1);
INSERT INTO Spectateur VALUES (229,1);
INSERT INTO Spectateur VALUES (232,1);
INSERT INTO Spectateur VALUES (235,1);
INSERT INTO Spectateur VALUES (494,1);
INSERT INTO Spectateur VALUES (495,1);
INSERT INTO Spectateur VALUES (752,1);
INSERT INTO Spectateur VALUES (763,1);

-- 3 incrits à la compétition 12 (Ball Busters)

INSERT INTO Spectateur VALUES (911,12);
INSERT INTO Spectateur VALUES (859,12);
INSERT INTO Spectateur VALUES (615,12);

-- O inscrits  la compétition 21 (Ball Busters)
INSERT INTO Spectateur VALUES (1002, 13), (1003, 13);

