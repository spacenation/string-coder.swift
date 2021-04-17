import Foundation
import Currying

public extension Decoder where Primitive == Character {
    func separate<A>(by separator: StringDecoder<A>) -> StringDecoder<List<Element>> {
        separator
            .discardThen(self)
            .many
            .apply(
                self.map(curry(<>))
            )
    }
}
