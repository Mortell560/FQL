-- On retire toutes les tables si elles existent deja
-- Marche en postgresql uniquement
--DROP SCHEMA public CASCADE;
--CREATE SCHEMA public;
--GRANT ALL ON SCHEMA public TO postgres;
--GRANT ALL ON SCHEMA public TO public;

DROP TABLE Spectateur CASCADE;
DROP TABLE SportGymnase CASCADE;
DROP TABLE SportCompetition CASCADE;
DROP TABLE Competition CASCADE;
DROP TABLE Role CASCADE;
DROP TABLE Sport CASCADE;
DROP TABLE Gymnase CASCADE;
DROP TABLE Personne CASCADE;


-- Schema

CREATE TABLE Personne(
  NumPersonne BIGINT PRIMARY KEY NOT NULL, 
  NomPersonne VARCHAR(100) NOT NULL,
  PrenomPersonne VARCHAR(100) NOT NULL,
  anneeNaissancePersonne INT NOT NULL,
  TelPersonne VARCHAR(16) NOT NULL,
  NumEmployeurPrincipal BIGINT,
  salaireHoraireMini NUMERIC(9,2),
  FOREIGN KEY(NumEmployeurPrincipal) REFERENCES Personne(NumPersonne)
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
  FOREIGN KEY(NumChef) REFERENCES Personne(NumPersonne)
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

CREATE TABLE SportGymnase (
  NumGymnase BIGINT NOT NULL,
  NumSport BIGINT NOT NULL,
  FOREIGN KEY(NumGymnase) REFERENCES Gymnase(NumGymnase),
  FOREIGN KEY(NumSport) REFERENCES Sport(NumSport),
  PRIMARY KEY(NumGymnase, NumSport)
);

CREATE TABLE SportCompetition(
  NumCompetition BIGINT NOT NULL,
  NumSport BIGINT NOT NULL,
  NumGymnase BIGINT NOT NULL,
  FOREIGN KEY(NumCompetition) REFERENCES Competition(NumCompetition),
  FOREIGN KEY(NumSport) REFERENCES Sport(NumSport),
  FOREIGN KEY(NumGymnase) REFERENCES Gymnase(NumGymnase),
  PRIMARY KEY(NumCompetition, NumSport)
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


