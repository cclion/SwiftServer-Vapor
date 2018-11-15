import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// RegisterServerConfig
    let serverConfig = NIOServerConfig.default(hostname:"0.0.0.0", port: 8887)
    services.register(serverConfig)
    
    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a MYSQL database
    let mysqlConfig :MySQLDatabaseConfig
    
//    if env.isRelease { //正式服
        mysqlConfig = MySQLDatabaseConfig(
            hostname: "39.98.67.77",
            port: 3306,
            username: "root",
            password: "123456",
            database: "vapor"
        )
//    }else{
//        mysqlConfig = MySQLDatabaseConfig(
//            hostname: "127.0.0.1",
//            port: 3306,
//            username: "root",
//            password: "123456",
//            database: "vapor"
//        )
//    }

    services.register(mysqlConfig)

    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Todo.self, database: .mysql)
    migrations.add(model: User.self, database: .mysql)
    migrations.add(model: AccessToken.self, database: .mysql)
    migrations.add(model: Article.self, database: .mysql)
//    migrations.add(model: Image.self, database: .mysql)

    services.register(migrations)

}
