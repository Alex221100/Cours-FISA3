import math
import timeit
from math import floor, ceil

from numpy import random

#TP1

def hanoi(n, A, B, C):
     # A : départ, B: intermédiaire, C : Arrivée;
     if n != 1:
         hanoi(n - 1, A, C, B)
         hanoi(n - 1, B, A, C)


# for n in range(1, 10):
#     print(n)
#     print(timeit.timeit("hanoi(%i, 'A', 'B', 'C')" % n, globals=globals(), number=1))
#
#
def fibo_ite(n):
     first = 0
     second = 1
     for i in range(1, n):
         tmp = first + second
         first = second
         second = tmp
     return first
#
#
# for n in range(1, 50):
#     print(n)
#     print(timeit.timeit("fibo_ite(%i)" % n, globals=globals(), number=1))
#
#
def fibo_rec(n):
     if n == 0:
         return 0
     else:
         if n == 1:
             return 1
         else:
            return fibo_rec(n - 1) + fibo_rec(n - 2)


#for n in range(1, 50):
#     print(n)
#     print(timeit.timeit("fibo_rec(%i)" % n, globals=globals(), number=1))
from typing import List, Tuple


def calc_fibonacci_iteratif(n: int) -> int:
    u: int = 0
    v: int = 1

    for i in range(2, n):
        t = u + v
        u = v
        v = t

    return v


for n in range(1, 50):
    print(n)
    print(timeit.timeit("calc_fibonacci_iteratif(%i)" % n, globals=globals(), number=1))


def calc_fibonacci_recurrence(n: int) -> int:
    if n == 0 or n == 1:
        return 1
    else:
        return calc_fibonacci_recurrence(n - 1) + calc_fibonacci_recurrence(n - 2)


def calc_fibonacci_log(n: int) -> List[int]:
    if n == 0:
        result = [0, 1]
    elif n == 1:
        result = [1, 1]
    else:
        v: List[int]
        u: List[int]

        if n % 2 == 1:
            v = calc_fibonacci_log(floor((n - 1) / 2))
            result = [v[0] ** 2 + v[1] ** 2, (2 * v[0] + v[1]) * v[1]]
        else:
            v = calc_fibonacci_log(floor(n / 2))
            result = [(2 * v[1] - v[0]) * v[0], v[0] ** 2 + v[1] ** 2]

    return result


# for i in range(20):
#     print("n =", i)
#     print(calc_fibonacci_recurrence(i))
#     print(calc_fibonacci_iteratif(i + 2))
#     print(calc_fibonacci_log(i)[1])
#     print("-"*50)


def Supprimer_multiples(i, tableau):
    for x in tableau:
        if x > i and x % i == 0:
            tableau.remove(x)


def Crible(N):
    tableau = [i for i in range(1, N)]
    for i in tableau:
        Supprimer_multiples(i, tableau)
    return tableau


# tableau = Crible(100)
# print(tableau)

# TP 2
def creer_tableau_aleatoire(taille: int, max_valeur: int) -> List[int]:
    result: List[int] = [0] * taille

    for i in range(taille):
        result[i] = random.randint(max_valeur)

    return result


def permuter(tableau: List[int], index_case1: int, index_case2: int) -> List[int]:
    tmp = tableau[index_case1]
    tableau[index_case1] = tableau[index_case2]
    tableau[index_case2] = tmp


def tri_selection(tableau: List[int]) -> List[int]:
    for i in range(len(tableau)):
        min: int = 0
        j: int = 0
        for j in range(i + 1, len(tableau)):
            if tableau[j] < tableau[min]:
                min = j

        if min != j:
            permuter(tableau, i, min)

    return tableau


m: int = 1
print("Tri sélection : "+str(tri_selection(creer_tableau_aleatoire(100, 500))))
for n in range(1, 1000, 100):
     print(str(n) + '     ' + str(timeit.timeit("tri_selection(creer_tableau_aleatoire(%i, 500))" % (n*m), globals=globals(), number=1)).replace(',', '.'))


def tri_insertion(tableau: List[int]) -> List[int]:
    for j in range(0, len(tableau)):
        cle: int = tableau[j]
        i: int = j - 1

        while i >= 0 and tableau[i] > cle:
            tableau[i + 1] = tableau[i]
            i -= 1

        tableau[i + 1] = cle

    return tableau


print("Tri insertion : "+str(tri_insertion(creer_tableau_aleatoire(100, 500))))


def tri_bulles(tableau: List[int]) -> List[int]:
    echange: bool = True

    while echange:
        echange = False
        for i in range(1, len(tableau) - 1):
            if tableau[i] > tableau[i + 1]:
                permuter(tableau, i, i + 1)
                echange = True

    return tableau


print("Tri bubules : "+str(tri_bulles(creer_tableau_aleatoire(100, 500))))



def tri_fusion_recursif(L):
    n = len(L)
    if n > 1:
        p = int(n / 2)
        L1 = L[0:p]
        L2 = L[p:n]
        tri_fusion_recursif(L1)
        tri_fusion_recursif(L2)
        L[:] = fusion(L1, L2)


def fusion(L1, L2):
    n1 = len(L1)
    n2 = len(L2)
    L12 = [0] * (n1 + n2)
    i1 = 0
    i2 = 0
    i = 0
    while i1 < n1 and i2 < n2:
        if L1[i1] < L2[i2]:
            L12[i] = L1[i1]
            i1 += 1
        else:
            L12[i] = L2[i2]
            i2 += 1
        i += 1
    while i1 < n1:
        L12[i] = L1[i1]
        i1 += 1
        i += 1
    while i2 < n2:
        L12[i] = L2[i2]
        i2 += 1
        i += 1
    return L12


def tri_fusion(L):
    M = list(L)
    tri_fusion_recursif(M)
    return M



tabFusion = creer_tableau_aleatoire(100, 500)
print("Tri fusion : "+str(tri_fusion(tabFusion)))

# TP3

Calculer = {'+': lambda a, b: a + b,
            '*': lambda a, b: a * b,
            '-': lambda a, b: a - b if a - b > 0 else 0,
            '/': lambda a, b: a / b}

Inverser = {'+': '-', '-': '+', '*': '/', '/': '*'}


def exploration(resultat_attendu: int, plaquettes: List[int]) -> List[Tuple[str, str, int]]:
    result: List[Tuple[str, str, int]] = []

    if len(plaquettes) == 1:
        result = [int(resultat_attendu)] if resultat_attendu == plaquettes[0] else []
    else:
        for nombre in plaquettes:
            for operateur in '+-*/':
                try:
                    pn_moins_un = Calculer[Inverser[operateur]](resultat_attendu, nombre)

                    for solution in exploration(pn_moins_un, [pn for pn in plaquettes if pn != nombre]):
                        result.append((operateur, solution, int(nombre)))
                except ZeroDivisionError:
                    pass

    return result


def afficher_resultat(res) -> str:
    if isinstance(res, int):
        result = str(res)
    else:
        op, a, b = res

        if isinstance(a, int):
            result = "{} {} {}".format(a, op, b)
        else:
            result = "({}) {} {}".format(afficher_resultat(a), op, b)

    return result


def generer_debut_aleatoire(nb_plaquettes: int) -> Tuple[int, List[int]]:
    plaquettes: List[int] = []
    for i in range(nb_plaquettes):
        plaquettes.append(random.randint(100))

    return random.randint(899) + 100, plaquettes


# for solution in exploration(120, [2, 10, 100]):
#     print("120 =", afficher_resultat(solution))

# test: Tuple[int, List[int]] = generer_debut_aleatoire(6)
# solutions = exploration(test[0], test[1])
# if len(solutions) > 0:
#     for solution in solutions:
#         print(test[0], "=", afficher_resultat(solution))
# else:
#     print("Pas de solution pour :", test[0], "avec les plaquettes :", test[1])
