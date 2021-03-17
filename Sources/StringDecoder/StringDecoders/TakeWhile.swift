import Foundation
import Decoder

public extension Decoder where Input == String, Element == String {
    static func takeWhile(_ predicate: @escaping (Character) -> Bool) -> Self {
        Decoder { input in
            let (first, second) = input.characters.span(predicate)
            return .success((String(first), String(second)))
        }
    }
}


