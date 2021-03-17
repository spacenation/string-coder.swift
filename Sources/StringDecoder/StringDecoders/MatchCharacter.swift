import Foundation
import Decoder

public extension Decoder where Input == String, Element == Character, Failure == CharacterDecodingFailure {
    static func match(_ c: Character) -> Self {
        .satisfy { $0 == c }
    }
}
