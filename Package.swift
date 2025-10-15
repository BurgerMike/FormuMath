// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "FormuMath",
    platforms: [
        .macOS(.v14), .iOS(.v16), .tvOS(.v16), .watchOS(.v9), .visionOS(.v1)
    ],
    products: [
        .library(name: "FormuMath", targets: ["FormuMath"]),
    ],
    targets: [
        .target(name: "FormuMath"),
        .testTarget(name: "FormuMathTests", dependencies: ["FormuMath"]),
    ]
)

