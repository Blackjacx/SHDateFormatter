// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SHDateFormatter",
    platforms: [
        // .macOS(.v10_12),
        .iOS(.v9),
        // .tvOS(.v10),
        // .watchOS(.v3)
    ],
    products: [
        .library(
            name: "SHDateFormatter",
            targets: ["SHDateFormatter"])
    ],
    targets: [
        .target(
            name: "SHDateFormatter",
            path: "source")
    ],
    swiftLanguageVersions: [.v5]
)