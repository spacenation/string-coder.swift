import Foundation

public final class StringDecoder {
    enum Error: Swift.Error {
        case indexOutOfBounds
        case matchingFailed
    }
    
    let characters: [Character]
    public internal(set) var cursor: Int
    
    public init(string: String) {
        self.characters = string.map { $0 }
        self.cursor = 0
    }
    
    public init(characters: [Character]) {
        self.characters = characters
        self.cursor = 0
    }

    public static func decode<T: StringDecodable>(_ type: T.Type, from string: String) throws -> T {
        try T(from: StringDecoder(string: string))
    }
}

extension StringDecoder {
    public func copy() -> StringDecoder {
        StringDecoder(characters: self.characters)
    }
}

extension StringDecoder {
    public func skip(size: Int) throws {
        guard cursor + size <= characters.count else { throw Error.indexOutOfBounds }
        cursor += size
    }
    
    public func match(_ string: String) throws {
        guard cursor + string.count <= characters.count else { throw Error.indexOutOfBounds }
        guard String(characters.dropFirst(cursor).prefix(string.count)) == string else { throw Error.matchingFailed }
        cursor += string.count
    }
    
    public func matchEmpty(size: Int = 1) throws {
        try match(String(repeating: " ", count: size))
    }
    
    public func preview(size: Int) -> String {
        return String(characters.dropFirst(cursor).prefix(size))
    }
    
    public func decode<T: StringDecodable>(_ type: T.Type = T.self) throws -> T {
        try T(from: self)
    }
    
    public func decodeString() -> String {
        let substring = String(characters.dropFirst(cursor))
        cursor += substring.count
        return substring
    }
    
    public func decodeString(size: Int) throws -> String {
        guard cursor + size < characters.count else { throw Error.indexOutOfBounds }
        defer { cursor += size }
        return String(characters.dropFirst(cursor).prefix(size))
    }
    
    public func decodeString(untilFirst character: Character) throws -> String {
        let substring = String(characters.dropFirst(cursor).prefix { $0 != character })
        cursor += substring.count
        return substring
    }
    
    public func decodeArray<T: StringDecodable>(of type: T.Type, separatorCharacter: Character, appendWhile: (Character) -> Bool) throws -> [T] {
        let substring = characters.dropFirst(cursor).prefix(while: appendWhile)
        cursor += substring.count
        return try substring.split(separator: separatorCharacter).map { try T(from: StringDecoder(string: String($0))) }
    }
    
    public func decodeArray<T: StringDecodable>(of type: T.Type, initialValue: [T] = [], separator: String) throws -> [T] {
        if let this = try? T(from: self) {
            try? match(separator)
            return try self.decodeArray(of: type, initialValue: initialValue + [this], separator: separator)
        } else {
            return initialValue
        }
    }
}

