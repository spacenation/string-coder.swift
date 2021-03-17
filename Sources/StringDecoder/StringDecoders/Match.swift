import Foundation
import Decoder

public extension Decoder where Input == String, Element == String, Failure == CharacterDecodingFailure {
    static func match(_ s: String) -> Self {
        if let (head, tail) = Array(s).deconstructed {
            return Decoder<String, Character, CharacterDecodingFailure>
                .match(head)
                .discardThen(.match(String(tail)))
                .discardThen(.pure(s))
        } else {
            return .pure("")
        }
    }
}




