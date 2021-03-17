import XCTest
import Currying
import Decoder
import StringCoder

final class StringDecoderTests: XCTestCase {
    func testCharacterParser() {
        let coder: Decoder<String, Character, CharacterDecodingFailure> = .match("1")
        
        switch coder.map({ Int(String($0))! }).decode("1ice") {
        case .success(let (element, next)):
            XCTAssertTrue(element == 1)
            XCTAssertTrue(next == "ice")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testCharacterParserFail() {
        let coder: Decoder<String, Character, CharacterDecodingFailure> = .match("C")
        
        switch coder.decode("c") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .mismatchedCharacter)
        }
    }
    
    func testStringDecoder() {
        let coder: Decoder<String, String, CharacterDecodingFailure> = .match("this")
        switch coder.decode("this1") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next == "1")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testStringDecoderFail() {
        let coder: Decoder<String, String, CharacterDecodingFailure> = .match("this2")
        switch coder.decode("this1") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .mismatchedCharacter)
        }
    }

    func testCombineParsers() {
        let coder: Decoder<String, String, CharacterDecodingFailure> = .match("this")
        let spaceCoder: Decoder<String, String, CharacterDecodingFailure> = .match(" ")
        switch coder.discard(spaceCoder).decode("this ") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next == "")
        case .failure(_):
            XCTFail()
        }
    }

    func testChoiceOperation() {
        let boolTrue: Decoder<String, Character, CharacterDecodingFailure> = .match("t")
        let boolFalse: Decoder<String, Character, CharacterDecodingFailure> = .match("f")
        
        switch boolTrue.or(boolFalse).decode("t") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "t")
            XCTAssertTrue(next == "")
        case .failure(_):
            XCTFail()
        }
    }

    func testTakeWhile() {
        let decoder: Decoder<String, String, CharacterDecodingFailure> = .takeWhile(isDigit)
        switch decoder.decode("1122one") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "1122")
            XCTAssertTrue(next == "one")
        case .failure(_):
            XCTFail()
        }
    }

    func testDecodingManyChars() {
        let coder: Decoder<String, Character, CharacterDecodingFailure> = .match("c")
        
        switch coder.many.decode("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
        
        switch coder.many.decode("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
    }

    func testtDecodingManyStrings() {
        let coder: Decoder<String, String, CharacterDecodingFailure> = .match("c1")
        
        switch coder.many.decode("c1c1c1123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c1", "c1", "c1"])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
        
        switch coder.many.decode("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
    }

    func testtDecodingSome() {
        let coder: Decoder<String, Character, CharacterDecodingFailure> = .match("c")
        
        switch coder.some(error: .mismatchedCharacter).decode("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
        
        switch coder.some(error: .mismatchedCharacter).decode("") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .mismatchedCharacter)
        }
    }
    
//    func testWhitespace() {
//        let string = """
//
//        some this
//
//        that
//
//        """
//
//        let parser: Parser<String, [String], CharacterParsingFailure> = separateBy(spaces())(alphanumeric())
//
//        switch parser(string) {
//        case .success(let (element, next)):
//            XCTAssertTrue(element == ["some", "this", "that"])
//            XCTAssertTrue(next == "")
//        case .failure(_):
//            XCTFail()
//        }
//    }
    
    func testCombinators() {
        struct SystemCall: Equatable {
            let name: String
            let argument: [String]
        }

        let argumentDecoder: Decoder<String, String, CharacterDecodingFailure> =
            .takeWhile({ $0 != " " && $0 != ")" })

        let systemCallDecoder =
            Decoder<String, Character, CharacterDecodingFailure>.match("(")
                .discardThen(argumentDecoder.separate(by: .match(" ")))
                .discard(Decoder<String, Character, CharacterDecodingFailure>.match(")"))
                .apply(
                    Decoder<String, String, CharacterDecodingFailure>.takeWhile({ $0 != "(" })
                        .map(curry(SystemCall.init))
                )

        let output = systemCallDecoder.decode("call(12 132 1)")
        
        switch output {
        case .success(let (element, next)):
            XCTAssertTrue(element == SystemCall(name: "call", argument: ["12", "132", "1"]))
            XCTAssertTrue(next == "")
        case .failure(_):
            XCTFail()
        }
    }

    static var allTests = [
        ("testCharacterParser", testCharacterParser),
    ]
}
