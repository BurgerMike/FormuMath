// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "FormuMath",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [
        .library(name: "FormuMathKinder", targets: ["FormuMathKinder"]),
        .library(name: "FormuMathPrimaria", targets: ["FormuMathPrimaria"]),
        .library(name: "FormuMathSecundaria", targets: ["FormuMathSecundaria"]),
        .library(name: "FormuMathPrepa", targets: ["FormuMathPrepa"]),
        .library(name: "FormuMathUniversidad", targets: ["FormuMathUniversidad"]),
        .library(name: "FormuMathMaestria", targets: ["FormuMathMaestria"]),
    ],
    targets: [
        .target(name: "FormuMathKinder"),
        .target(name: "FormuMathPrimaria"),
        .target(name: "FormuMathSecundaria"),
        .target(name: "FormuMathPrepa"),
        .target(name: "FormuMathUniversidad"),
        .target(name: "FormuMathMaestria"),
        .testTarget(name: "FormuMathTests",
                    dependencies: ["FormuMathKinder","FormuMathPrimaria","FormuMathSecundaria",
                                   "FormuMathPrepa","FormuMathUniversidad","FormuMathMaestria"]),
    ]
)
