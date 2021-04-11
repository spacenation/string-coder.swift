import Foundation

public protocol StringDecodable {
    static var stringDecoder: StringDecoder<Self> { get }
}

public extension StringDecodable {
    static func decode(from string: String) throws -> Self {
        switch Self.stringDecoder(string) {
        case .success((let element, _)):
            return element
        case .failure(let error):
            throw error
        }
    }
}
