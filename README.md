## StringDecoder
SPM package to decode types from strings.

### String Decoder
```swift
try? StringDecoder.decode(Message.self, from: "1214 13 0b00000000 0 0b00000001")
```

### String Encoder
```swift
try? StringEncoder.encode(Message(source: "1214", destination: "13", payload: Payload(data: [0, 0, 1]))),
```

### Example
```swift
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
        data = try decoder.decodeArray(of: UInt8.self, separatorCharacter: " ", appendWhile: { _ in true })
    }
    
    func encode(to encoder: StringEncoder) throws {
        try encoder.encodeArray(data, separator: " ")
    }
}
```

## Code Contributions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.

## Coffee Contributions
If you find this project useful please consider becoming my GitHub sponsor.
