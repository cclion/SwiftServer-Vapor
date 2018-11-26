import Vapor
import FluentMySQL //use your database driver here

public func migrate(migrations: inout MigrationConfig) throws {
    
    migrations.add(model: Todo.self, database: .mysql)
    migrations.add(model: User.self, database: .mysql)
    migrations.add(model: AccessToken.self, database: .mysql)
    migrations.add(model: Article.self, database: .mysql)
    
}

