def load_db(filenames: list, out: str = "../SQL_scripts/out.sql"):
    """Comme les nettoyants 4 en 1, ca fusionne tout ensemble
    Mettez les fichiers dans l'ordre par contre
    """
    try:
        with open(out, 'w') as f:
            for file in filenames:
                with open(file) as c:
                    f.write(f"-- Content from file {file.split("/")[-1][:-4]} --\n") # je recup juste le nom du fichier sans le .sql, ca a l'air complique si on est pas bien pose
                    f.writelines(c.readlines())
                    f.write("\n")
    except FileNotFoundError:
        print("File doesn't exist")
    except IsADirectoryError:
        print("Problem of path")



if __name__ == "__main__":
    filenames = ["../SQL_scripts/init.sql", "../SQL_scripts/Personne.sql", "../SQL_scripts/Sport.sql", "../SQL_scripts/Gymnase.sql", "../SQL_scripts/Competition.sql", "../SQL_scripts/Role.sql", "../SQL_scripts/SportGymnase.sql", "../SQL_scripts/SportCompetition.sql", "../SQL_scripts/Spectateur.sql"]
    load_db(filenames)
