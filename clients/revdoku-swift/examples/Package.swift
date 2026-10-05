// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "RevdokuExamples",
    platforms: [.macOS(.v12)],
    dependencies: [.package(name: "RevdokuAPI", path: "..")],
    targets: [
        .target(name: "Recipes", dependencies: [.product(name: "RevdokuAPI", package: "RevdokuAPI")]),
        .executableTarget(name: "RevdokuExamples", dependencies: ["Recipes"]),
    ]
)
