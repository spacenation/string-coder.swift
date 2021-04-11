import Foundation
import Functional

public let alphanumeric: StringDecoder<String> = takeWhile(isAlphanumeric).map { String($0) }
