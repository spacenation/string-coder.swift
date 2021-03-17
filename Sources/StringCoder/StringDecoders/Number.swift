import Foundation
import Decoder

public extension Decoder where Input == String {
    static var number: Decoder<String, Int, CharacterDecodingFailure> {
        Decoder<String, Int, CharacterDecodingFailure> { input in
            let numberDecoder: Decoder<String, String, CharacterDecodingFailure> = .takeWhile(isDigit)
            if case let .success((result, input2)) = numberDecoder.decode(input), let number = Int(result) {
                return .success((number, input2))
            } else {
                return .failure(.mismatchedCharacter)
            }
        }
    }
}
