import Foundation
import Decoder

public let tab: Decoder<String, String, CharacterDecodingFailure> = match("\t")
