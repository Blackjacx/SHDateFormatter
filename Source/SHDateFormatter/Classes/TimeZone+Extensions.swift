import Foundation

// swiftlint:disable force_unwrapping
public extension TimeZone {

    static let GMT = TimeZone(identifier: "GMT")!

    enum Europe: CaseIterable {
        public static let Berlin = TimeZone(identifier: "Europe/Berlin")!
        public static let London = TimeZone(identifier: "Europe/London")!
    }

    enum NorthAmerica: CaseIterable {
        public static let Pacific = TimeZone(identifier: "America/Los_Angeles")!
    }

    enum Australia: CaseIterable {
        public static let Sydney = TimeZone(identifier: "Australia/Sydney")!
    }
}
