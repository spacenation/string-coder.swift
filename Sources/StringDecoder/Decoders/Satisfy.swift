import Foundation

//public func satisfy(_ predicate: @escaping (Character) -> Bool) -> StringDecoder<Character> {
//    StringDecoder { input in
//        if let (head, tail) = input.characters.deconstructed, predicate(head) {
//            return .success((head, String(tail)))
//        } else {
//            return .failure(.mismatchedPrimitive(0))
//        }
//    }
//}
