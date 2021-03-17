import Foundation
import Decoder

public extension Decoder where Input == String {
    static var alphanumeric: Decoder<String, String, CharacterDecodingFailure> {
        .takeWhile(isAlphanumeric)
    }
}
