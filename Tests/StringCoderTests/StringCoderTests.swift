import XCTest
import Currying
import Coder
import StringCoder

final class StringCoderTests: XCTestCase {
    func testCharacterParser() {
        switch char("1").map({ Int(String($0))! }).decode("1ice") {
        case .success(let (element, next)):
            XCTAssertTrue(element == 1)
            XCTAssertTrue(next == "ice")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testCharacterParserFail() {
        switch char("C").decode("c") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .unexpectedCharacter)
        }
    }
    
    func testStringDecoder() {
        switch string("this").decode("this1") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next == "1")
        case .failure(_):
            XCTFail()
        }
    }
    
    func testStringDecoderFail() {
        switch string("this2").decode("this1") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .unexpectedCharacter)
        }
    }

    func testCombineParsers() {
        switch (string("this").discard(string(" "))).decode("this ") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next == "")
        case .failure(_):
            XCTFail()
        }
    }

    func testChoiceOperation() {
        switch (char("t").or(char("f"))).decode("t") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "t")
            XCTAssertTrue(next == "")
        case .failure(_):
            XCTFail()
        }
    }

    func testTakeWhile() {
        let decoder: Decoder<String, String, CharacterDecodingFailure> = takeWhile(isDigit)
        switch decoder.decode("1122one") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "1122")
            XCTAssertTrue(next == "one")
        case .failure(_):
            XCTFail()
        }
    }

    func testDecodingManyChars() {
        switch char("c").many().decode("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
        
        switch char("c").many().decode("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
    }

    func testtDecodingManyStrings() {
        switch string("c1").many().decode("c1c1c1123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c1", "c1", "c1"])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
        
        switch string("c1").many().decode("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
    }

    func testtDecodingSome() {
        switch char("c").some(error: .unexpectedCharacter).decode("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next == "123")
        case .failure(_):
            XCTFail()
        }
        
        switch char("c").some(error: .unexpectedCharacter).decode("") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .unexpectedCharacter)
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
            takeWhile({ $0 != " " && $0 != ")" })

        let systemCallDecoder =
            char("(")
                .discardThen(argumentDecoder.separate(by: string(" ")))
                .discard(char(")"))
                .apply(
                    takeWhile({ $0 != "(" })
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
