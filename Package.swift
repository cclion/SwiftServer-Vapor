// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporSever",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
//        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        
        // 🔑 Hashing (BCrypt, SHA2, HMAC), encryption (AES), public-key (RSA), and random data generation.
        .package(url: "https://github.com/vapor/crypto", from: "3.3.0"),
        
        // 🐬 Swift ORM (queries, models, relations, etc) built on MySQL.
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.1"),
        
        // 🍃 An expressive, performant, and extensible templating language built for Swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.2"),
        
        //🗄 Core services for creating database integrations.
//        .package(url: "https://github.com/vapor/database-kit.git", from: "1.0.0"),
        
        // ⚡️Non-blocking, event-driven Redis client.
        .package(url: "https://github.com/vapor/redis.git", from: "3.0.2"),
        
        /// 💻 APIs for creating interactive CLI tools.
        .package(url: "https://github.com/vapor/console.git", from: "3.1.0")
        
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Crypto", "FluentMySQL", "Leaf", "Redis", "Logging"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

