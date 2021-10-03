//
// This code supplements the blog post:
// "wift: Strings, Unicode, and a Touch of Magic"
// https://indie.kim/post/3-strings
//


// These example are refined versions of the examples provided at:
// https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html


//
// Unicode Basics
//

// Examples of Unicode scalars:
// See also: https://unicode.org/glossary/#unicode_scalar_value
let dollarSign = "$"
let blackHeart = "♥"      // Unicode scalar U+2665, Swift alternative: "\u{2665}".
let sparklingHeart = "💖" // Unicode scalar U+1F496, Swift alternative: "\u{1F496}".

// Creating a string from characters:
let characters: [Character] = [ "$", "\u{2665}", "\u{1F496}" ]
var symbols = String(characters)

// Copy-on-write:
var symbolsCopy = symbols

symbols += symbols.reversed()

print(symbols)
print(symbolsCopy)

// Character iteration:
for character in symbols {
    print(character)
}

// String interpolation:
let x = 123
print("x is \(x). Is x greater than 2? \(x > 2)!") // x is 123. Is x greater than 2? true!


//
// Unicode Graphene Clusters
//

// A string of mixed-length characters:
let mixedLengthCharacters = "$♥💖"

print("String length: \(mixedLengthCharacters.count)") // String length: 3

// String length: 4 both times due to extended grapheme clusters.
// But because of that: `count` is O(n), n being the string length.
// More about extended (and legacy) grapheme clusters:
// https://unicode.org/reports/tr29/
var word = "cafe"

print(word)
print("String length: \(word.count)") // String length: 4

word += "\u{301}" // cafe becomes café

print(word)
print("String length: \(word.count)") // String length: 4

// Strings are equivalent, if their extended graphene clusters are
// canonically equivalent.

// "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

print(eAcuteQuestion == combinedEAcuteQuestion) // true

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"

print(latinCapitalLetterA == cyrillicCapitalLetterA) // false

// Encoding
let utf8 = symbols.utf8.map { "\($0)" }
let utf16 = symbols.utf16.map { "\($0)" }

print("UTF-8 code points: \(utf8.count) -- Bytes used: \(utf8.count)") // UTF-8 code points: 16 -- Bytes used: 16
print(utf8.joined(separator: ", "))
print("UTF-16 code points: \(utf16.count) -- Bytes used: \(utf16.count * 2)") // UTF-16 code points: 8 -- Bytes used: 16
print(utf16.joined(separator: ", "))
