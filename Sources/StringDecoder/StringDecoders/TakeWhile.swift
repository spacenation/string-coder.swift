import Foundation
import Decoder

public func takeWhile(_ predicate: @escaping (Character) -> Bool) -> Decoder<String, String, CharacterDecodingFailure> {
    Decoder { input in
        let (first, second) = input.characters.span(predicate)
        return .success((String(first), String(second)))
    }
}


