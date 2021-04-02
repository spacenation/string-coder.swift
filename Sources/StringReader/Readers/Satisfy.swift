import Foundation

public func satisfy(_ predicate: @escaping (Character) -> Bool) -> StringReader<Character> {
    StringReader { input in
        if let (head, tail) = input.characters.deconstructed, predicate(head) {
            return .success((head, String(tail)))
        } else {
            return .failure(.mismatchedCharacter)
        }
    }
}
