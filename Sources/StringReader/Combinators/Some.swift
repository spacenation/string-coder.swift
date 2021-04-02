import Foundation

public extension StringReader {
    func some(error: CharacterDecodingFailure) -> StringReader<[Element]> {
        StringReader<[Element]> { input in
            var items: [Element] = []
            var input1 = input
            while case let .success((output, input2)) = self.decode(input1) {
                input1 = input2
                items.append(output)
            }
            if items.count > 0 {
                return .success((items, input1))
            } else {
                return .failure(error)
            }
        }
    }
}
