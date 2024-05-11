def insert(tablename: str, values: list[list]) -> str:
    """Permet d'ecrire les requetes pour insert dans une table donnee"""
    out = f"INSERT INTO {tablename} VALUES "
    for value in values:
        to_add = "("
        for v in value:
            to_add += str(v) + ","
        to_add = to_add[:-1] + ")"
        out += to_add + ", "

        # les -1 ou -2 c'est pour retirer les char en trop
    return out[:-2] + ";"


if __name__ == "__main__":
    t = insert("test", [[1,'\'test\'', 3], [2, '\'test2\'', 6], [3, '\'test4\'', 1234]])
    print(t)

    # TODO: Pensez à sanatize les inputs avec les '' qui peuvent mettre le chaos 
