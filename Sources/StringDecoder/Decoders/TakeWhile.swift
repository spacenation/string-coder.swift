import Foundation
public func takeWhile(_ predicate: @escaping (Character) -> Bool) -> StringDecoder<String> {
    StringDecoder { input in
        let (first, second) = input.characters.span(predicate)
        return .success((String(first), String(second)))
    }
}


