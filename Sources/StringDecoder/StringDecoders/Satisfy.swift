import Foundation
import Decoder

public extension Decoder where Input == String, Element == Character, Failure == CharacterDecodingFailure {
    static func satisfy(_ predicate: @escaping (Character) -> Bool) -> Self {
        Decoder { input in
            if let (head, tail) = input.characters.deconstructed, predicate(head) {
                return .success((head, String(tail)))
            } else {
                return .failure(.mismatchedCharacter)
            }
        }
    }
}
