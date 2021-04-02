import Foundation
import Functional

extension StringReader {
    public static func pure(_ a: Element) -> Self {
        StringReader { .success((a, $0)) }
    }
    
    public func apply<T>(_ transform: StringReader<(Element) -> T>) -> StringReader<T> {
        transform.flatMap { self.map($0) }
    }
    
    public func discard<A>(_ a: StringReader<A>) -> Self {
        a.apply(self.map(constant))
    }
    
    public func discardThen<A>(_ a: StringReader<A>) -> StringReader<A> {
        a.apply(self.map(constant(identity)))
    }
}

public func <*><A, B>(left: StringReader<(A) -> B>, right: StringReader<A>) -> StringReader<B> {
    right.apply(left)
}

public func <*<A, B>(left: StringReader<A>, right: StringReader<B>) -> StringReader<A> {
    left.discard(right)
}

public func *><A, B>(left: StringReader<A>, right: StringReader<B>) -> StringReader<B> {
    left.discardThen(right)
}
