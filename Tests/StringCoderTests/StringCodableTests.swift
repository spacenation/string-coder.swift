import XCTest
import StringCoder

final class StringCodableTests: XCTestCase {
    func testStringDecodable() {
        XCTAssertEqual(
            try? StringDecoder.decode(Message.self, from: "1214 13 0b00000000 0 0b00000001"),
            Message(source: "1214", destination: "13", payload: Payload(data: [0, 0, 1]))
        )
    }
    
    func testStringEncodable() {
        XCTAssertEqual(
            try? StringEncoder.encode(Message(source: "1214", destination: "13", payload: Payload(data: [0, 0, 1]))),
            "1214 13 0 0 1"
        )
    }

    static var allTests = [
        ("testStringDecodable", testStringDecodable),
    ]
}

private struct Message: Equatable, StringCodable {
    let source: String
    let destination: String
    let payload: Payload
    
    init(source: String, destination: String, payload: Payload) {
        self.source = source
        self.destination = destination
        self.payload = payload
    }
    
    /// Decodable
    init(from decoder: StringDecoder) throws {
        source = try decoder.decodeString(size: 4)
        try decoder.skip(size: 1)
        destination = try decoder.decodeString(untilFirst: " ")
        try decoder.skip(size: 1)
        payload = try decoder.decode()
    }
    
    /// Encodable
    func encode(to encoder: StringEncoder) throws {
        encoder.encodeString(source)
        encoder.encodeEmpty()
        encoder.encodeString(destination)
        encoder.encodeEmpty()
        try encoder.encode(payload)
    }
}

struct Payload: Equatable, StringCodable {
    let data: [UInt8]
    
    public init(data: [UInt8]) {
        self.data = data
    }
    
    init(from decoder: StringDecoder) throws {
        data = try decoder.decodeArray(of: UInt8.self, separator: " ")
    }
    
    func encode(to encoder: StringEncoder) throws {
        try encoder.encodeArray(data, separator: " ")
    }
}


extension UInt8: StringCodable {
    enum StringDecodableError: Error {
        case invalid
        case invalidBinaryLiteral
    }
    
    public init(from decoder: StringDecoder) throws {
        if decoder.preview(size: 2) == "0b" {
            try decoder.skip(size: 2)
            guard let value = try? UInt8(decoder.decodeString(untilFirst: " "), radix: 2) else { throw StringDecodableError.invalid }
            self = value
        } else {
            guard let value = try? UInt8(decoder.decodeString(untilFirst: " ")) else { throw StringDecodableError.invalidBinaryLiteral }
            self = value
        }
        

    }
    
    public func encode(to encoder: StringEncoder) throws {
        encoder.encodeString("\(self)")
    }
    
    
}
