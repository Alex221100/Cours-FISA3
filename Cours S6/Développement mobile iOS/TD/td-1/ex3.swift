class Note {
    var valeur : Int
    var coefficient : Int

    init(valeur: Int, coefficient: Int) {
        self.valeur = valeur
        self.coefficient = coefficient
    }
}

let notes = [
    Note(valeur: 19, coefficient: 1),
    Note(valeur: 10, coefficient: 2)
]

let notesCoefficientees = notes.map {
    note in
    note.valeur * note.coefficient
}

print(notesCoefficientees)

let somme = notesCoefficientees.reduce(0, { acc, note in
        acc + note
    })

print(somme)

print(somme / notes.count)
