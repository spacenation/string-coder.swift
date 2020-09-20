import Foundation

public final class StringEncoder {
    public internal(set) var characters: [Character]
    
    public init() {
        self.characters = []
    }
}

extension StringEncoder {
    public func encodeString(_ value: String) {
        characters.append(contentsOf: value)
    }
    
    public func encodeEmpty(size: Int = 1) {
        characters.append(contentsOf: Array(repeating: Character(" "), count: size))
    }
    
    public func encode<T: StringEncodable>(_ value: T) throws {
        try value.encode(to: self)
    }
    
    public func encodeArray<T: StringEncodable>(_ array: [T], separator: Character) throws {
        try array.forEach {
            try $0.encode(to: self)
            self.encodeString(String(separator))
        }
        characters.removeLast()
    }
}

extension StringEncoder {
    public static func encode<T: StringEncodable>(_ value: T) throws -> String {
        let encoder = StringEncoder()
        try value.encode(to: encoder)
        return String(encoder.characters)
    }
}
