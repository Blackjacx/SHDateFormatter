// swift-tools-version:5.4
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
        .library(name: "SHDateFormatter", targets: ["SHDateFormatter"])
    ],
    targets: [
        .target(name: "SHDateFormatter", path: "source", exclude: ["Info.plist"])
    ],
    swiftLanguageVersions: [.v5]
)
