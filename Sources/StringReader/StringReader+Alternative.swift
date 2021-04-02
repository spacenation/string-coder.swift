import Foundation
import Functional

extension StringReader {
    public static func empty(error: CharacterDecodingFailure) -> Self {
        StringReader { _ in .failure(error) }
    }
    
    public func or(_ other: Self) -> Self {
        StringReader<Element> { input in
            switch self.decode(input) {
            case .success(let (element, next)):
                return .success((element, next))
            case .failure(_):
                return other.decode(input)
            }
        }
    }
}

public func <|><A>(left: StringReader<A>, right: StringReader<A>) -> StringReader<A> {
    left.or(right)
}
