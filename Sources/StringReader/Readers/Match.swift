import Foundation

public func match(_ s: String) -> StringReader<String> {
    if let (head, tail) = Array(s).deconstructed {
        return match(head)
            .discardThen(match(String(tail)))
            .discardThen(.pure(s))
    } else {
        return .pure("")
    }
}




