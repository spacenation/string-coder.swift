import Foundation
import Functional

public func match(_ s: String) -> StringDecoder<String> {
    switch List(s) {
    case .empty:
        return .pure("")
    case let .nonEmpty(list):
        return match(list.head)
            .discardThen(match(String(list.tail)))
            .discardThen(.pure(s))
    }
}




