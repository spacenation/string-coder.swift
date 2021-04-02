import Foundation

public func match(_ c: Character) -> StringReader<Character> {
    satisfy { $0 == c }
}
