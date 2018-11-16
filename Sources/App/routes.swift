import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", use: todoController.delete)
    router.post("regist", use: OAuthController().regist)
    router.post("login", use: OAuthController().login)
    router.post("getUserInfo", use: OAuthController().getUserInfo)
    router.post("setUserInfo", use: OAuthController().setUserInfo)
    router.post("exit", use: OAuthController().exit)
    router.post("addArticle", use: ArticleController().addArticle)
    router.post("getArticles", use: ArticleController().getArticles)
    router.post("updateImage", use: ImageController().updateImage)
    router.get("getImage", String.parameter, use: ImageController().getImage)

}
