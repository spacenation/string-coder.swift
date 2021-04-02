import Foundation

public extension StringReader {
    static var whitespace: StringReader<[String]> {
        newLine
            .or(tab)
            .or(space)
            .many
    }
}
