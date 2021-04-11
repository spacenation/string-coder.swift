import Foundation
import Functional

public func match(_ c: Character) -> StringDecoder<Character> {
    satisfy { $0 == c }
}
