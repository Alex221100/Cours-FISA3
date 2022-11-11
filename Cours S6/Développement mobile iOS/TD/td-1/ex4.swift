func estPair(_ n: Int) -> Bool {
    return n % 2 == 0
}

print("5 est pair = \(estPair(5))")
print("12 est pair = \(estPair(12))")

func fib(_ n : Int) -> Int {
    if n == 0 || n == 1 {
        return n
    } else {
        return fib(n - 1) + fib(n - 2)
    }
}

print("fib(5) = \(fib(5))")
print("fib(10) = \(fib(10))")

func moyenne(_ valeurs: [Int]) -> Int {
    valeurs.reduce(0, { acc, valeur in
        acc + valeur
    }) / valeurs.count
}

// Si jamais vous souhaité avoir une moyenne réelle
//
// func moyenne(_ valeurs: [Int]) -> Double {
//     valeurs.reduce(0.0, { acc, valeur in
//         acc + Double(valeur)
//     }) / Double(valeurs.count)
// }

print("moyenne = \(moyenne([1, 2, 3, 4, 6]))")

func max(_ valeurs: [Int]) -> Int {
    var max = -1

    for valeur in valeurs {
        if valeur > max {
            max = valeur
        }
    }

    return max
}

print("Valeur maximale : \(max([1, 5, 7, 2, 3]))")
