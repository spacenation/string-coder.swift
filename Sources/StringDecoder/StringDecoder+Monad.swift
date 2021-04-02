import Foundation
import Functional

extension StringDecoder {
    public func flatMap<NewOutput>(_ transform: @escaping (Element) -> StringDecoder<NewOutput>) -> StringDecoder<NewOutput> {
        StringDecoder<NewOutput> { input in
            self.decode(input)
                .flatMap { transform($0.element).decode($0.next) }
        }
    }
}

public func >>-<A, NewOutput>(a: StringDecoder<A>, transform: @escaping (A) -> StringDecoder<NewOutput>) -> StringDecoder<NewOutput> {
    a.flatMap(transform)
}
