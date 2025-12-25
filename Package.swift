// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "user-manager",
    platforms: [
            .macOS(.v12), .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "user-manager",
            targets: ["user-manager"]),
        .library(name: "filestore", targets: ["filestore"]),
    ],
    dependencies: [
        // ✅ Your GitHub Swift Package Dependency
        .package(url: "https://github.com/yuvraj-2503/util-swift-sdk", exact: "1.0.3"),
        .package(url: "https://github.com/yuvraj-2503/rest-client-api", exact: "1.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "filestore",
                dependencies: [
                    .product(name: "util", package: "util-swift-sdk")
                ]),
        .target(
            name: "user-manager",
            dependencies: [
                // ✅ Declare dependency on the package product/module
                "filestore",
                .product(name: "util", package: "util-swift-sdk"),
                .product(name: "rest-client-api", package: "rest-client-api")
            ]),
        .testTarget(
            name: "user-managerTests",
            dependencies: ["user-manager",
                           "filestore",
                           .product(name: "util", package: "util-swift-sdk"),
                           .product(name: "rest-client-api", package: "rest-client-api")]
        ),
    ]
)
