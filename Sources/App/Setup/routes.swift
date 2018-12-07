import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return try req.view().render("hello", ["name": "Leaf"])
    }

    router.get("redis") { req -> Future<String> in
        return req.withNewConnection(to: .redis) { redis in
            // use redis connection
            // send INFO command to redis
            return redis.command("INFO")
                // map the resulting RedisData to a String
                .map { $0.string ?? "" }
        }
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", use: todoController.delete)

    try router.register(collection: OAuthController())
    try router.register(collection: ImageController())
    try router.register(collection: ArticleController())
    
    router.get("set") { req -> Future<HTTPStatus> in
        // create a new redis connection
        return req.withNewConnection(to: .redis) { redis in
            // save a new key/value pair to the cache
            return redis.set("hello", to: "world")
                // convert void future to HTTPStatus.ok
                .transform(to: .ok)
        }
    }
    router.get("get") { req -> Future<String> in
        // create a new redis connection
        return req.withNewConnection(to: .redis) { redis in
            // fetch the key/value pair from the cache, decoding a String
            return redis.get("hello", as: String.self)
                // handle nil case
                .map { $0 ?? "" }
        }
    }

}
