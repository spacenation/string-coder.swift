import Foundation

public extension String {
    var characters: [Character] {
        self.map { $0 }
    }
}
