import Foundation
import Decoder

public let alphanumeric: Decoder<String, String, CharacterDecodingFailure> = takeWhile(isAlphanumeric)
