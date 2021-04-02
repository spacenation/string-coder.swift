import Foundation

public let number: StringDecoder<Int> =
    StringDecoder<Int> { input in
        let numberDecoder: StringDecoder<String> = takeWhile(isDigit)
        if case let .success((result, input2)) = numberDecoder.decode(input), let number = Int(result) {
            return .success((number, input2))
        } else {
            return .failure(.mismatchedCharacter)
        }
    }
