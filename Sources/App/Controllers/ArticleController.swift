//
//  ArticleController.swift
//  App
//
//  Created by job on 2018/11/13.
//

import Vapor

final class ArticleController {
    
    // MARK: 添加文章
    func addArticle(_ req: Request) throws -> Future<Response> {
        
        return try req.content.decode(Article.self).flatMap({ content in
            guard content.title != nil else {
                return try ResponseJSON<Empty>(code: 101, message: "请输入标题").encode(for: req)
            }
            guard content.content != nil else {
                return try ResponseJSON<Empty>(code: 101, message: "请输入内容").encode(for: req)
            }
            return try AccessTokenController.sharedInstance.getUserIDReview(req: req, UID: { (useID) -> (EventLoopFuture<Response>) in
                content.userID = useID
                return content.save(on: req).flatMap({result in
                    return try ResponseJSON<Empty>(code: 0, message: "添加成功").encode(for: req)
                })
            })
        })
    }
    // MARK: 获取个人文章列表
    func getArticles(_ req: Request) throws -> Future<Response> {
        
        return try AccessTokenController.sharedInstance.getUserIDReview(req: req, UID: { (userID) -> (EventLoopFuture<Response>) in
            
            return Article
            .query(on: req)
            .filter(\.userID, .equal, userID)
            .all().flatMap({ content in
                
                return try ResponseJSON<[Article]>(code: 0, message: "获取g成功",data: content).encode(for: req)
            })
        })
  
    }
 
}
