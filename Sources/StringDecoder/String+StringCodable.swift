import Foundation

extension String: StringCodable {
    public init(from decoder: StringDecoder) throws {
        self = decoder.decodeString()
    }
    
    public func encode(to encoder: StringEncoder) throws {
        encoder.encodeString(self)
    }
}
