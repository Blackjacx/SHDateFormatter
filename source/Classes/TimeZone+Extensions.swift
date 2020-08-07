import Foundation

// swiftlint:disable force_unwrapping
public extension TimeZone {

    static let GMT = TimeZone(identifier: "GMT")!

    enum Europe {
        public static let Berlin = TimeZone(identifier: "Europe/Berlin")!
        public static let London = TimeZone(identifier: "Europe/London")!
    }
}
