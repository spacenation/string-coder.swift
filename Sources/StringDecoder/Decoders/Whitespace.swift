import Foundation

public extension StringDecoder {
    static var whitespace: StringDecoder<[String]> {
        newLine
            .or(tab)
            .or(space)
            .many
    }
}
