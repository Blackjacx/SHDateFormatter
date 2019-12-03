import Foundation

// swiftlint:disable force_unwrapping
extension TimeZone {

    static let GMT = TimeZone(identifier: "GMT")!
    
    enum Europe {
        static let Berlin = TimeZone(identifier: "Europe/Berlin")!
        static let London = TimeZone(identifier: "Europe/London")!
    }
}
