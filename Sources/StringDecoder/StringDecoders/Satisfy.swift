import Foundation
import Decoder

public func satisfy(_ predicate: @escaping (Character) -> Bool) -> Decoder<String, Character, CharacterDecodingFailure> {
    Decoder { input in
        if let (head, tail) = input.characters.deconstructed, predicate(head) {
            return .success((head, String(tail)))
        } else {
            return .failure(.mismatchedCharacter)
        }
    }
}
