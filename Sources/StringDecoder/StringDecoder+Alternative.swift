import Foundation
import Functional

extension StringDecoder {
    public static func empty(error: CharacterDecodingFailure) -> Self {
        StringDecoder { _ in .failure(error) }
    }
    
    public func or(_ other: Self) -> Self {
        StringDecoder<Element> { input in
            switch self.decode(input) {
            case .success(let (element, next)):
                return .success((element, next))
            case .failure(_):
                return other.decode(input)
            }
        }
    }
}

public func <|><A>(left: StringDecoder<A>, right: StringDecoder<A>) -> StringDecoder<A> {
    left.or(right)
}
