import Foundation
@_exported import Functional

public struct StringReader<Element> {
    public typealias Output = Result<(element: Element, next: String), CharacterDecodingFailure>
    
    public let decode: (String) -> Output
    
    public init(decode: @escaping (String) -> Output) {
        self.decode = decode
    }
    
    func callAsFunction(_ input: String) -> Output {
        decode(input)
    }
}

public enum CharacterDecodingFailure: Error, Equatable {
    case mismatchedCharacter
}

