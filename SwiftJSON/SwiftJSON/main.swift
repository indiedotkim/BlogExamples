// Source code for the blog post: "Swift: JSON and the Argonauts"
// https://indie.kim/post/6-swift-json

import Foundation

struct GameCharacter: Codable {
    var name: String
    var title: String?
    var skillLevel: Int
}

let character = GameCharacter(name: "Kim", title: "Makai White Mage", skillLevel: 100)

// Prints:
// {"name":"Kim","title":"Makai White Mage","skillLevel":100}
let encoder = JSONEncoder()
print(String(data: try encoder.encode(character), encoding: .utf8)!)

// Prints:
// {"name":"Kim","skillLevel":100,"title":"Makai White Mage"}
encoder.outputFormatting = .sortedKeys
print(String(data: try encoder.encode(character), encoding: .utf8)!)

// Prints:
// {
//   "name" : "Kim",
//   "title" : "Makai White Mage",
//   "skillLevel" : 100
// }
encoder.outputFormatting = .prettyPrinted
print(String(data: try encoder.encode(character), encoding: .utf8)!)

// Prints:
// {
//   "name" : "Kim",
//   "skillLevel" : 100,
//   "title" : "Makai White Mage"
// }
encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
print(String(data: try encoder.encode(character), encoding: .utf8)!)

// Prints:
// {
//   "name" : "Kim",
//   "skill_level" : 100,
//   "title" : "Makai White Mage"
// }
encoder.keyEncodingStrategy = .convertToSnakeCase
print(String(data: try encoder.encode(character), encoding: .utf8)!)

// Prints:
// GameCharacter(name: "Kim", title: Optional("Makai White Mage"), skillLevel: 100)
let jsonString = """
{
  "name" : "Kim",
  "skill_level" : 100,
  "title" : "Makai White Mage"
}
""".data(using: .utf8)
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let characterFromJSON = try decoder.decode(GameCharacter.self, from: jsonString!)
print(characterFromJSON)
