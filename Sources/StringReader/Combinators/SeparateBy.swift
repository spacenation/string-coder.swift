import Foundation

public extension StringReader {
    func separate<A>(by separator: StringReader<A>) -> StringReader<[Element]> {
        separator
            .discardThen(self)
            .many
            .apply(
                self.map(curry(Array.init))
            )
    }
}
