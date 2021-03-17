import Foundation
import Decoder

public extension Decoder where Input == String {
    static var digit: Decoder<String, Character, CharacterDecodingFailure> {
        .satisfy(isDigit)
    }
}
