import Foundation

public let alphanumeric: StringDecoder<String> = takeWhile(isAlphanumeric).map { String($0) }
