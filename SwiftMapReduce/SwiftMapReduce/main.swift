// Source code for the blog post: "Swift: MapReduce, Closures, and Other Sorcery"
// https://indie.kim/post/5-swift-map-reduce

let input = [ "Hello", "World", "!" ]

let mapped = input.map { $0.count }
let reduced = mapped.reduce(0, { x, y in x + y })

// Output:
// ["Hello", "World", "!"]
// 11
print(input)
print(reduced)

let isEven = [ 1, 2, 3, 4, 5 ].map { ($0, $0 % 2 == 0) }

// Output:
// [(1, false), (2, true), (3, false), (4, true), (5, false)]
print(isEven)

// Output:
// [(2, true), (4, true)]
print(isEven.filter { $0.1 })

struct Parity {
    let even: Int
    let odd: Int
}

// Output:
// Parity(even: 2, odd: 3)
print(isEven.reduce(Parity(even: 0, odd: 0), {
    parity, tuple in Parity(even: parity.even + (tuple.1 ? 1 : 0),
                            odd: parity.odd + (tuple.1 ? 0 : 1))
}))
