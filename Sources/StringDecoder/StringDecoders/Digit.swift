import Foundation
import Decoder

public let digit: Decoder<String, Character, CharacterDecodingFailure> = satisfy(isDigit)
