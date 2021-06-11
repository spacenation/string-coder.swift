import Foundation

public let naturalNumber: StringDecoder<UInt> =
    StringDecoder<UInt> { input in
        let numberDecoder: StringDecoder<String> = takeWhile(isDigit).map { String($0) }
        if case let .success((result, input2)) = numberDecoder.decode(input), let number = UInt(result), number > 0 {
            return .success((number, input2))
        } else {
            return .failure(.mismatchedPrimitive(input.offset))
        }
    }
