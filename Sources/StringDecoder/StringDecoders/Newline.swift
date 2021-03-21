import Foundation
import Decoder

public let newLine: Decoder<String, String, CharacterDecodingFailure> = match("\n")
