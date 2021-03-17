import Foundation

public protocol StringEncodable {
    func encode(to encoder: StringEncoder) throws
}
