import Foundation

public func match(_ s: String) -> StringDecoder<String> {
    if let (head, tail) = Array(s).deconstructed {
        return match(head)
            .discardThen(match(String(tail)))
            .discardThen(.pure(s))
    } else {
        return .pure("")
    }
}




