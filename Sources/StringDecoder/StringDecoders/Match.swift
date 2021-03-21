import Foundation
import Decoder

public func match(_ s: String) -> Decoder<String, String, CharacterDecodingFailure> {
    if let (head, tail) = Array(s).deconstructed {
        return match(head)
            .discardThen(match(String(tail)))
            .discardThen(.pure(s))
    } else {
        return .pure("")
    }
}




