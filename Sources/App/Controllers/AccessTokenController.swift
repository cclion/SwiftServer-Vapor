//
//  AccessTokenController.swift
//  App
//
//  Created by job on 2018/11/13.
//

import Vapor

final class AccessTokenController {
    
     static let sharedInstance = AccessTokenController()
    
    // MARK: 添加token
    func addToken(_ uid: Int, on connection: DatabaseConnectable) throws -> AccessToken {
        
        let accessToken = try AccessToken(userID: uid)
        _ = accessToken.save(on: connection)
        return accessToken
    }
    
    // MARK: 返回userID
    func getUserID(_ token: String, on connection: DatabaseConnectable) throws -> Future<AccessToken?> {
        
        return  AccessToken
            .query(on: connection)
            .filter(\.token, .equal, token)
            .first()
    }
    // MARK: 验证token
    func getUserIDReview(req: Request, UID:@escaping (Int) throws ->(Future<Response>)) throws -> Future<Response> {
        
        //获取Token
        let Authorization = req.http.headers["Authorization"]
        if Authorization.count == 0 {
            return try ResponseJSON<Empty>(code: 102, message: "请携带Token").encode(for: req)
        }
        let token = Authorization[0]
        
        return  AccessToken
            .query(on: req)
            .filter(\.token, .equal, token)
            .first()
            .flatMap({ (exist) in
                
                guard exist != nil else{
                    return try ResponseJSON<Empty>(code: 103, message: "tokenw错误 没有找到这个用户").encode(for: req)
                }
                return try UID(exist!.userID)
            })
    }
    
    // MARK: 退出登录
    func exit(_ req: Request) throws -> Future<Response> {
        
        return try self.getUserIDReview(req: req, UID: { (userID) -> (EventLoopFuture<Response>) in
            
            _ = AccessToken
            .query(on: req)
            .filter(\.userID, .equal, userID)
            .delete()
            
            return try ResponseJSON<Empty>(code: 0, message: "注销成功").encode(for: req)

        })
 
    }
}

