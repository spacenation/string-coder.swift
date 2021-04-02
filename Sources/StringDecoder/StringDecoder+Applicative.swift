import Foundation
import Functional

extension StringDecoder {
    public static func pure(_ a: Element) -> Self {
        StringDecoder { .success((a, $0)) }
    }
    
    public func apply<T>(_ transform: StringDecoder<(Element) -> T>) -> StringDecoder<T> {
        transform.flatMap { self.map($0) }
    }
    
    public func discard<A>(_ a: StringDecoder<A>) -> Self {
        a.apply(self.map(constant))
    }
    
    public func discardThen<A>(_ a: StringDecoder<A>) -> StringDecoder<A> {
        a.apply(self.map(constant(identity)))
    }
}

public func <*><A, B>(left: StringDecoder<(A) -> B>, right: StringDecoder<A>) -> StringDecoder<B> {
    right.apply(left)
}

public func <*<A, B>(left: StringDecoder<A>, right: StringDecoder<B>) -> StringDecoder<A> {
    left.discard(right)
}

public func *><A, B>(left: StringDecoder<A>, right: StringDecoder<B>) -> StringDecoder<B> {
    left.discardThen(right)
}
