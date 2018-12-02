import Vapor
import FluentMySQL //use your database driver here

public func databases(config: inout DatabasesConfig) throws {
    guard let databaseUrl = Environment.get("DATABASE_URL") else {
        throw Abort(.internalServerError)
    }
}
