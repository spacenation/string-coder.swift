import Foundation
@_exported import Functional

public typealias StringDecoder<Element> = Decoder<Character, Element>

public extension Decoder where Primitive == Character {
    func callAsFunction(_ string: String) -> Output {
        decode(DecoderState(list: List(string), offset: 0))
    }
}
