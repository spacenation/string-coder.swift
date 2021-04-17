import Foundation

public extension StringDecoder {
    static var whitespace: StringDecoder<List<String>> {
        newLine
            .or(tab)
            .or(space)
            .many
    }
}
