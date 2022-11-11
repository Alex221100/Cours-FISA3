import Swift

class Tache {
    var titre : String
    var etat : Bool
init(_ titre: String, _ etat: Bool) {
        self.titre = titre
        self.etat = etat
    }
}

let taches = [Tache("Faire les courses", false),Tache("Prendre rendez-vous médecin", true),Tache("Nettoyer la salle de bain", false)]

for tache in taches{
    if tache.etat == true{
        print("[X] \(tache.titre)");
    }else{
        print("[] \(tache.titre)");
    }
}