import Foundation

public extension Decoder where Primitive == Character {
    func separate<A>(by separator: StringDecoder<A>) -> StringDecoder<[Element]> {
        separator
            .discardThen(self)
            .many
            .apply(
                self.map(curry(Array.init))
            )
    }
}
