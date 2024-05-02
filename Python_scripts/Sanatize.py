from DataGen import *
import random


def init_dict(filename):
    d = {}
    with open(filename) as f:
        lines = f.readlines()
        lines = lines[1:]
        for line in lines:
            id, nom, prenom, phone, birthday = line.strip().split(',')
            birthday = birthday[-4:]
            phone = generate_telephone()
            id = int(id)
            d[id] = [nom, prenom, phone, birthday]
    return d


def write_as_sql_order(filename, dictio, qte=100, rand=0):
    with open(filename, 'w') as f:
        seen_id = []
        while len(seen_id) != qte and rand:
            id = random.choice(list(dictio.keys()))
            if id not in seen_id:
                seen_id.append(id)
        if not rand:
            seen_id = [i for i in range(1, qte+1)]

        for id in seen_id:
            nom, prenom, phone, birthday = dictio[id]
            nom, prenom = nom.replace("'", "''"), prenom.replace("'", "''")
            f.write(
                f"INSERT INTO Personne VALUES ({id}, '{nom}', '{prenom}', {birthday}, '{phone}');\n")


if __name__ == '__main__':
    SQL_OUT = "Personne.sql"
    CSV_IN = "FakeNameGenerator.com_aa16686f.csv"
    dictio = init_dict(CSV_IN)
    # print(dictio)
    write_as_sql_order(SQL_OUT, dictio)
