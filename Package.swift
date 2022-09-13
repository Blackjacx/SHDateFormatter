// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "SHDateFormatter",
    platforms: [
        .macOS(.v11),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v5),
    ],
    products: [
        .library(name: "SHDateFormatter", targets: ["SHDateFormatter"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "5.0.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "10.0.0"),
    ],
    targets: [
        .target(name: "SHDateFormatter", exclude: ["Info.plist"]),
        .testTarget(name: "SHDateFormatterTests", dependencies: ["SHDateFormatter", "Quick", "Nimble"], exclude: ["Info.plist"]),
    ]
)
