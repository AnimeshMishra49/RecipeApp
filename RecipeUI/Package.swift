// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RecipeUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v11)
    ],
    products: [
        .library(name: "RecipeUI", targets: ["RecipeUI"]),
    ],
    dependencies: [
        // Assuming DesignSystem and RecipeKit are local packages
        .package(path: "../DesignSystem"),
        .package(path: "../RecipeKit")
    ],
    targets: [
        .target(
            name: "RecipeUI",
            dependencies: [
                "DesignSystem",
                "RecipeKit"
            ]
        ),
        .testTarget(
            name: "RecipeUITests",
            dependencies: ["RecipeUI"]
        ),
    ]
)
