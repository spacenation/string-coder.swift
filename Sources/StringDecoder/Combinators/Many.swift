import Foundation
import List

public extension Decoder where Primitive == Character {
    var many: StringDecoder<List<Element>> {
        StringDecoder<List<Element>> { input in
            var items: List<Element> = .empty
            var input1 = input
            while case let .success((output, input2)) = self.decode(input1) {
                input1 = input2
                items = items.append(List(head: output))
            }
            return .success((items, input1))
        }
    }
}
