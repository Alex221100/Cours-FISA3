class Tache {
    var titre : String
    var realise : Bool

    init(_ titre: String, _ realise: Bool) {
        self.titre = titre
        self.realise = realise
    }
}

let taches = [
    Tache("Faire les courses", false),
    Tache("Faire la vaisselle", true)
]

for tache in taches {
    if tache.realise {
        print("[X] \(tache.titre)")
    } else {
        print("[ ] \(tache.titre)")
    }
}
