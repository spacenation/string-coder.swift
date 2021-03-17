import Foundation
import Decoder

public enum CharacterDecodingFailure: Error, Equatable {
    case mismatchedCharacter
}

public func anyString<Failure>() -> Decoder<String, String, Failure> {
    Decoder<String, String, Failure> { input in
        .success((input, ""))
    }
}

public func anyCharacter() -> Decoder<String, Character, CharacterDecodingFailure> {
    .satisfy(constant(true))
}

public extension String {
    var characters: [Character] {
        self.map { $0 }
    }
}
