def insert(tablename: str, values: list[list]) -> str:
    """Permet d'ecrire les requetes pour insert dans une table donnee"""
    out = f"INSERT INTO {tablename} VALUES "
    for value in values:
        to_add = "("
        for v in value:
            if isinstance(v, str):
                v = v.replace("'", "''")
            to_add += str(v) + ","
        to_add = to_add[:-1] + ")"
        out += to_add + ", "

        # les -1 c'est pour retirer les char en trop
    return out[:-1] + ";"


if __name__ == "__main__":
    insert("test", [[1,'test', 3], [2, 'test2', 6]])

