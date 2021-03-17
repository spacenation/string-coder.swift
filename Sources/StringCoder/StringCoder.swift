//import Decoder
//
//public enum CharacterDecodingFailure: Error, Equatable {
//    case unexpectedCharacter
//}
//
//public func anyString<Failure>() -> Decoder<String, String, Failure> {
//    Decoder<String, String, Failure> { input in
//        .success((input, ""))
//    }
//}
//
//public var alphanumeric: Decoder<String, String, CharacterDecodingFailure> {
//    takeWhile(isAlphanumeric)
//}
//
//public func takeWhile(_ predicate: @escaping (Character) -> Bool) -> Decoder<String, String, CharacterDecodingFailure> {
//    Decoder { input in
//        let (first, second) = input.characters.span(predicate)
//        return .success((String(first), String(second)))
//    }
//}
//
//public func anyCharacter<Failure>(error: Failure) -> Decoder<String, Character, Failure> {
//    satisfy(constant(true), error: error)
//}
//
//public var spaces: Decoder<String, String, CharacterDecodingFailure> {
//    takeWhile(isSpace)
//}
//
//public var newLine: Decoder<String, String, CharacterDecodingFailure> {
//    string("\n")
//}
//
//public var tab: Decoder<String, String, CharacterDecodingFailure> {
//    string("\t")
//}
//
//public var space: Decoder<String, String, CharacterDecodingFailure> {
//    string(" ")
//}
//
//public var whitespace: Decoder<String, [String], CharacterDecodingFailure> {
//    newLine
//        .or(tab)
//        .or(space)
//        .many()
//}
//
//public var newLines: Decoder<String, [String], CharacterDecodingFailure> {
//    newLine
//        .many()
//}
//
//public var digit: Decoder<String, Character, CharacterDecodingFailure> {
//    satisfy(isDigit, error: .unexpectedCharacter)
//}
//
//public func char(_ c: Character) -> Decoder<String, Character, CharacterDecodingFailure> {
//    satisfy({ $0 == c }, error: .unexpectedCharacter)
//}
//
//public func string(_ s: String) -> Decoder<String, String, CharacterDecodingFailure> {
//    if let (head, tail) = Array(s).deconstructed {
//        return char(head).discardThen(string(String(tail))).discardThen(.pure(s))
//    } else {
//        return .pure("")
//    }
//}
//
//public func satisfy<Failure>(_ predicate: @escaping (Character) -> Bool, error: Failure) -> Decoder<String ,Character, Failure> {
//    Decoder { input in
//        if let (head, tail) = input.characters.deconstructed, predicate(head) {
//            return .success((head, String(tail)))
//        } else {
//            return .failure(error)
//        }
//    }
//}
//
//public var number: Decoder<String, Int, CharacterDecodingFailure> {
//    Decoder<String, Int, CharacterDecodingFailure> { input in
//        let numberDecoder: Decoder<String, String, CharacterDecodingFailure> = takeWhile(isDigit)
//        if case let .success((result, input2)) = numberDecoder.decode(input), let number = Int(result) {
//            return .success((number, input2))
//        } else {
//            return .failure(.unexpectedCharacter)
//        }
//    }
//}
//
//public extension String {
//    var characters: [Character] {
//        self.map { $0 }
//    }
//}
