from DataGen import *
import random


def init_dict(filename):
    """Passage de CSV a un dictionnaire python qui a comme cle un id"""
    d = {}
    with open(filename) as f:
        lines = f.readlines()
        lines = lines[1:] # on retire l'entete
        for line in lines:
            id, nom, prenom, phone, birthday = line.strip().split(',')
            birthday = birthday[-4:] # on prend l'annee de naissance
            phone = generate_telephone() # les nums de telephone sont pas assez realistes donc on le fait nous meme
            id = int(id) # Oui c'est un string sinon
            d[id] = [nom, prenom, phone, birthday]
    return d


def write_as_sql_order(filename, dictio, qte=100, rand=False):
    """retourne les requetes d'insertion pour les gens"""
    with open(filename, 'w') as f:
        seen_id = []
        # pour les id au pif
        while len(seen_id) != qte and rand:
            id = random.choice(list(dictio.keys()))
            if id not in seen_id:
                seen_id.append(id)
        # pour les id dans l'ordre d'apparition dans le CSV
        if not rand:
            seen_id = [i for i in range(1, qte+1)]

        for id in seen_id:
            nom, prenom, phone, birthday = dictio[id]
            nom, prenom = nom.replace("'", "''"), prenom.replace("'", "''") # On se premunit des gens avec des apostrophes dans leur nom
            f.write(
                f"INSERT INTO Personne VALUES ({id}, '{nom}', '{prenom}', {birthday}, '{phone}');\n")


if __name__ == '__main__':
    SQL_OUT = "../SQL_scripts/Personne.sql"
    CSV_IN = "FakeNameGenerator.com_aa16686f.csv"
    dictio = init_dict(CSV_IN)
    # print(dictio)
    write_as_sql_order(SQL_OUT, dictio, 1000)
