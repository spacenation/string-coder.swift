import Foundation
import Decoder

public extension Decoder where Input == String {
    static var newLine: Decoder<String, String, CharacterDecodingFailure> {
        .match("\n")
    }
}
