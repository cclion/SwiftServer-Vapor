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

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", use: todoController.delete)

    try router.register(collection: OAuthController())
    try router.register(collection: ImageController())
    try router.register(collection: ArticleController())

}
