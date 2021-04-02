import Foundation
import Functional

extension StringReader {
    public func map<T>(_ transform: @escaping (Element) -> T) -> StringReader<T> {
        StringReader<T> { input in
            self.decode(input).map { (transform($0.element), $0.next) }
        }
    }
}

public func <^><A, B>(transform: @escaping (A) -> B, a: StringReader<A>) -> StringReader<B> {
    a.map(transform)
}
