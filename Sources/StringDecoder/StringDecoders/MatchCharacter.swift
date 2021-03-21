import Foundation
import Decoder

public func match(_ c: Character) -> Decoder<String, Character, CharacterDecodingFailure> {
    satisfy { $0 == c }
}
