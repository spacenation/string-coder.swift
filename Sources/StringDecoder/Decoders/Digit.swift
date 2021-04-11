import Foundation
import Functional

public let digit: StringDecoder<Character> = satisfy(isDigit)
