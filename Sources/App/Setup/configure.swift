import FluentMySQL
import Vapor
import Leaf
import Redis

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())


    
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register Leaf
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    /// Register ServerConfig
    let serverConfig = NIOServerConfig.default(hostname:"0.0.0.0", port: 80)
    services.register(serverConfig)
    
    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a MYSQL database
    let mysqlConfig :MySQLDatabaseConfig
    
    if env.isRelease { //正式服
        mysqlConfig = MySQLDatabaseConfig(
            hostname: "39.98.67.77",
            port: 3306,
            username: "root",
            password: "123456",
            database: "vapor"
        )
    }else{
        mysqlConfig = MySQLDatabaseConfig(
            hostname: "127.0.0.1",
            port: 3306,
            username: "root",
            password: "123456",
            database: "vapor"
        )
    }

    services.register(mysqlConfig)

//    // Create a SQLite database.
//    let mysqlDB = MySQLDatabase(config: mysqlConfig)
//    // Create a new, empty DatabasesConfig.
//    var dbsConfig = DatabasesConfig()
//    // Register the SQLite database using '.sqlite' as an identifier.
//    dbsConfig.add(database: mysqlDB, as: .mysql)
//    // Register the DatabaseConfig to services.
//    services.register(dbsConfig)
    
    
//    let redisProvider = RedisProvider()
//    redisProvider.register(&<#T##services: Services##Services#>)
    
    
    // register Redis provider
//    try services.register(RedisProvider())
//
//
    /// Register the configured SQLite database to the database config.
//    var databases = DatabasesConfig()
    var redisConfig: RedisClientConfig = RedisClientConfig()
    redisConfig.hostname = "127.0.0.1"
    redisConfig.port = 6379

//    let redisDatabse = try RedisDatabase(config: redisConfig)
//    databases.add(database: redisDatabse, as: .redis)
    services.register(redisConfig)

    /// Configure migrations
    var migrations = MigrationConfig()
    try migrate(migrations: &migrations)
    services.register(migrations)

}
