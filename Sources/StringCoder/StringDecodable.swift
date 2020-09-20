import Foundation

public protocol StringDecodable {
    init(from decoder: StringDecoder) throws
}
