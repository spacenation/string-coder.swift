import Foundation
import Decoder

public extension Decoder where Input == String {
    static var whitespace: Decoder<String, [String], CharacterDecodingFailure> {
        Self.newLine
            .or(.tab)
            .or(.space)
            .many
    }
}