import random

__NUMEROS_EXISTANTS = []

def _get_numero():
    return '0' + str(random.randint(6, 7)) + "".join([str(random.randint(0, 9)) for _ in range(8)])

def generate_telephone():   
    """ Generes un numero de telephone aleatoire qui n'existe pas """
    global __NUMEROS_EXISTANTS
    numero = _get_numero()
    while numero in __NUMEROS_EXISTANTS:
        numero = _get_numero()
    __NUMEROS_EXISTANTS.append(numero)
    return numero

if __name__ == "__main__":
    for i in range(42):
        print(generate_telephone())
    print("Taille :", len(__NUMEROS_EXISTANTS))
