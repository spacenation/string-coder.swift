import Foundation

public extension StringDecoder {
    func separate<A>(by separator: StringDecoder<A>) -> StringDecoder<[Element]> {
        separator
            .discardThen(self)
            .many
            .apply(
                self.map(curry(Array.init))
            )
    }
}
