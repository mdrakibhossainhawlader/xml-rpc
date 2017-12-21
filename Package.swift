// swift-tools-version:4.0
/*
 * Copyright 2017 Tris Foundation and the project authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License
 *
 * See LICENSE.txt in the project root for license information
 * See CONTRIBUTORS.txt for the list of the project authors
 */

import PackageDescription

let package = Package(
    name: "XMLRPC",
    products: [
        .library(name: "XMLRPC", targets: ["XMLRPC"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/tris-foundation/xml.git",
            .branch("master")),
        .package(
            url: "https://github.com/tris-foundation/test.git",
            .branch("master"))
    ],
    targets: [
        .target(
            name: "XMLRPC",
            dependencies: ["XML"]),
        .testTarget(
            name: "XMLRPCTests",
            dependencies: ["XMLRPC", "Test"])
    ]
)