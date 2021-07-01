import XCTest
import StringDecoder

final class StringDecoderTests: XCTestCase {
    func testCharacterParser() {
        let coder: StringDecoder<Character> = match("1")
        
        switch coder.map({ Int(String($0))! })("1ice") {
        case .success(let (element, next)):
            XCTAssertTrue(element == 1)
            XCTAssertTrue(next.list == List("ice"))
        case .failure(_):
            XCTFail()
        }
    }
    
    func testCharacterParserFail() {
        let coder: StringDecoder<Character> = match("C")
        
        switch coder("c") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .mismatchedPrimitive(0))
        }
    }
    
    func testStringDecoder() {
        let coder: StringDecoder<String> = match("this")
        switch coder("this1") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next.list == List("1"))
        case .failure(_):
            XCTFail()
        }
    }
    
    func testStringDecoderFail() {
        let coder: StringDecoder<String> = match("this2")
        switch coder("this1") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(error, .mismatchedPrimitive(4))
        }
    }

    func testCombineParsers() {
        let coder: StringDecoder<String> = match("this")
        let spaceCoder: StringDecoder<String> = match(" ")
        switch coder.discard(spaceCoder)("this ") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "this")
            XCTAssertTrue(next.list == .empty)
        case .failure(_):
            XCTFail()
        }
    }

    func testChoiceOperation() {
        let boolTrue: StringDecoder<Character> = match("t")
        let boolFalse: StringDecoder<Character> = match("f")
        
        switch boolTrue.or(boolFalse)("t") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "t")
            XCTAssertTrue(next.list == .empty)
        case .failure(_):
            XCTFail()
        }
    }

    func testTakeWhile() {
        let decoder: StringDecoder<String> = takeWhile(isDigit).map(String.init)
        switch decoder("1122one") {
        case .success(let (element, next)):
            XCTAssertTrue(element == "1122")
            XCTAssertTrue(next.list == List("one"))
        case .failure(_):
            XCTFail()
        }
    }

    func testDecodingManyChars() {
        let coder: StringDecoder<Character> = match("c")
        
        switch coder.many("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next.list == List("123"))
        case .failure(_):
            XCTFail()
        }
        
        switch coder.many("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next.list == List("123"))
        case .failure(_):
            XCTFail()
        }
    }

    func testtDecodingManyStrings() {
        let coder: StringDecoder<String> = match("c1")
        
        switch coder.many("c1c1c1123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c1", "c1", "c1"])
            XCTAssertTrue(next.list == List("123"))
        case .failure(_):
            XCTFail()
        }
        
        switch coder.many("123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == [])
            XCTAssertTrue(next.list == List("123"))
        case .failure(_):
            XCTFail()
        }
    }

    func testDecodingSome() {
        let coder: StringDecoder<Character> = match("c")
        
        switch coder.some("ccc123") {
        case .success(let (element, next)):
            XCTAssertTrue(element == ["c", "c", "c"])
            XCTAssertTrue(next.list == List("123"))
        case .failure(_):
            XCTFail()
        }
        
        switch coder.some("") {
        case .success(_):
            XCTFail()
        case .failure(let error):
            XCTAssertTrue(error == .mismatchedCount)
        }
    }
    
    func testCombinators() {
        struct SystemCall: Equatable {
            let name: String
            let argument: List<String>
        }

        let argumentDecoder: StringDecoder<String> =
            takeWhile({ $0 != " " && $0 != ")" }).map(String.init)

        let systemCallDecoder = match("(")
                .discardThen(argumentDecoder.separate(by: match(" ")))
                .discard(match(")"))
                .apply(
                    takeWhile({ $0 != "(" }).map(String.init)
                        .map(curry(SystemCall.init))
                )

        let output = systemCallDecoder("call(12 132 1)")
        
        switch output {
        case .success(let (element, next)):
            XCTAssertTrue(element == SystemCall(name: "call", argument: ["12", "132", "1"]))
            XCTAssertTrue(next.list == List(""))
        case .failure(_):
            XCTFail()
        }
    }

    static var allTests = [
        ("testCharacterParser", testCharacterParser),
    ]
}
