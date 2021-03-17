import Foundation
import Decoder

public extension Decoder where Input == String {
    static var space: Decoder<String, String, CharacterDecodingFailure> {
        .match(" ")
    }
}
