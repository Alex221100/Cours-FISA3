enum Etat {
    case nouvelle
    case encours
    case finie
}

class Tache {
    var titre : String
    var etat : Etat

    init(_ titre: String, _ etat: Etat) {
        self.titre = titre
        self.etat = etat
    }
}

let taches = [
    Tache("Faire les courses", .nouvelle),
    Tache("Faire la vaisselle", .encours)
]

enum FibonacciErreur : Error {
    case mauvaisInterval(valeur: Int)
}

func fib(_ n : Int) throws -> Int {
    guard n >= 0 else {
        throw FibonacciErreur.mauvaisInterval(valeur: n)
    }

    if n == 0 || n == 1 {
        return n
    } else {
        return try fib(n - 1) + fib(n - 2)
    }
}

do {
    print(try fib(-2))
} catch FibonacciErreur.mauvaisInterval(let valeur) {
    print("Vous devez passer une valeur positive ou nulle : \(valeur) a été fourni")
}
