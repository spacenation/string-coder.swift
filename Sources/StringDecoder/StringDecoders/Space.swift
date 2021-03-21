import Foundation
import Decoder

public let space: Decoder<String, String, CharacterDecodingFailure> = match(" ")
