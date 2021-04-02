import Foundation
import Functional

extension StringReader {
    public func flatMap<NewOutput>(_ transform: @escaping (Element) -> StringReader<NewOutput>) -> StringReader<NewOutput> {
        StringReader<NewOutput> { input in
            self.decode(input)
                .flatMap { transform($0.element).decode($0.next) }
        }
    }
}

public func >>-<A, NewOutput>(a: StringReader<A>, transform: @escaping (A) -> StringReader<NewOutput>) -> StringReader<NewOutput> {
    a.flatMap(transform)
}
