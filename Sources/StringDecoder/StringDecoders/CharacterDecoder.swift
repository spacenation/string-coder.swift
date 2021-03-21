import Foundation
import Decoder

public enum CharacterDecodingFailure: Error, Equatable {
    case mismatchedCharacter
}

public extension String {
    var characters: [Character] {
        self.map { $0 }
    }
}
