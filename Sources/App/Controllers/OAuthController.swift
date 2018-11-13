//
//  OAuthController.swift
//  App
//
//  Created by job on 2018/11/9.
//

import Vapor

class OAuthController {
    
    // 注册
    func regist(_ req: Request) throws -> Future<Response> {
        //🌹 flatMap： Future->Obj<self>
        return try req.content.decode(User.self).flatMap({ content in

            guard let phone = content.phone else {
                return try ResponseJSON<Empty>(code: 101, message: "请输入手机号").encode(for: req)
            }
            guard content.password != nil else {
                return try ResponseJSON<Empty>(code: 101, message: "请输入密码").encode(for: req)
            }
            
            //查数据
            return User
                .query(on: req)
                .filter(\.phone, .equal, phone)
                .first()
                .flatMap({ (user) in
                
                guard user != nil else{
                    let result =  content.save(on: req)
                    
                  return result.flatMap({ content in
                    let accessToken = try self.addToken(content.id!, on: req)
                    return try ResponseJSON<AccessToken>(code: 0, message: "注册成功", data: accessToken).encode(for: req)

                })
                }
                return try ResponseJSON<Empty>(code: 101, message: "用户已存在").encode(for: req)
            })
        })
    }
    
    // 登录
    func login(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(User.self).flatMap({ content in
            
            guard let phone = content.phone else {
                return try ResponseJSON<Empty>(code: 101, message: "请输入手机号").encode(for: req)
            }
            guard let password = content.password else {
                return try ResponseJSON<Empty>(code: 101, message: "请输入密码").encode(for: req)
            }
            
            //查数据
            return User
                .query(on: req)
                .filter(\.phone, .equal, phone)
                .filter(\.password, .equal, password)
                .first()
                .flatMap({ (user) in
                
                guard user != nil else{
                    
                    return try ResponseJSON<Empty>(code: 101, message: "手机号或密码错误").encode(for: req)
                }
                return try ResponseJSON<Empty>(code: 0, message: "验证成功").encode(for: req)
            })
        })
    }
    
    // 个人信息
    func getUserInfo(_ req: Request) throws -> Future<Response> {
        
        /********   第一种👋token验证   Request->func(route)->func(getUID)->func(route)->Response    *******/
         // 获取token
        let Authorization = req.http.headers["Authorization"]
        
        if Authorization.count == 0 {
            return try ResponseJSON<Empty>(code: 102, message: "请携带Token").encode(for: req)
        }
        
        let token = Authorization[0]
        
       return try self.getUserID(token, on: req).flatMap({ (exist) in
        
        guard exist != nil else{
            return try ResponseJSON<Empty>(code: 103, message: "tokenw错误 没有找到这个用户").encode(for: req)
                    }
        // 查找
        return User
            .query(on: req)
            .filter(\.id, .equal, exist?.userID)
            .first()
            .flatMap({ (user) in
                
                guard user != nil else{
                    return try ResponseJSON<Empty>(code: 103, message: "tokenw错误 没有找到这个用户").encode(for: req)
                }
                return try ResponseJSON<User>(code: 102, message: "验证成功🌹", data: user).encode(for: req)
            })
            
        })
        
 
        /********   第二种👋token验证   Request->func(route)->func(getUID)->func(route)->func(getUID)->Response    *******/
        
        return try self.getUserIDReview(req: req, UID: { (uid) -> (EventLoopFuture<Response>) in
            
            // 查找
            return User
                .query(on: req)
                .filter(\.id, .equal, uid)
                .first()
                .flatMap({ (user) in
                    
                    guard user != nil else{
                        return try ResponseJSON<Empty>(code: 103, message: "token错误 没有找到这个用户").encode(for: req)
                    }
                    return try ResponseJSON<User>(code: 102, message: "验证成功🌹", data: user).encode(for: req)
                })
        })
    }
}

private extension OAuthController {

    // 添加token 注册时和登录时都会新增Token
    func addToken(_ uid: Int, on connection: DatabaseConnectable) throws -> AccessToken {

        let accessToken = try AccessToken(userID: uid)
        
        _ = accessToken.save(on: connection)

        return accessToken
    }

    // 根据Token返回UID
    func getUserID(_ token: String, on connection: DatabaseConnectable) throws -> Future<AccessToken?> {
        
        return  AccessToken
        .query(on: connection)
        .filter(\.token, .equal, token)
        .first()
    }
    // 根据Token返回UID
    func getUserIDReview(req: Request, UID:@escaping (Int)->(Future<Response>)) throws -> Future<Response> {
        
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
                return UID(exist!.userID)
            })
    }
    
    
}
