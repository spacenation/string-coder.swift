import Foundation
import Functional

extension StringDecoder {
    public func map<T>(_ transform: @escaping (Element) -> T) -> StringDecoder<T> {
        StringDecoder<T> { input in
            self.decode(input).map { (transform($0.element), $0.next) }
        }
    }
}

public func <^><A, B>(transform: @escaping (A) -> B, a: StringDecoder<A>) -> StringDecoder<B> {
    a.map(transform)
}
