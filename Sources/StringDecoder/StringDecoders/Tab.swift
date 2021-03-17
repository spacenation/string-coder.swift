import Foundation
import Decoder

public extension Decoder where Input == String {
    static var tab: Decoder<String, String, CharacterDecodingFailure> {
        .match("\t")
    }
}
