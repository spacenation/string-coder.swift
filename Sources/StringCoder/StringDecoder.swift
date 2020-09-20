import Foundation

public final class StringDecoder {
    enum Error: Swift.Error {
        case indexOutOfBounds
    }
    
    private let characters: [Character]
    public internal(set) var cursor: Int
    
    public init(string: String) {
        self.characters = string.map { $0 }
        self.cursor = 0
    }
    
    public func decode<T: StringDecodable>(_ type: T.Type = T.self) throws -> T {
        try T(from: self)
    }

    public static func decode<T: StringDecodable>(_ type: T.Type, from string: String) throws -> T {
        try T(from: StringDecoder(string: string))
    }
}

extension StringDecoder {
    public func skip(size: Int) throws {
        guard cursor + size <= characters.count else { throw Error.indexOutOfBounds }
        cursor += size
    }
    
    public func preview(size: Int) -> String {
        return String(characters.dropFirst(cursor).prefix(size))
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
}

