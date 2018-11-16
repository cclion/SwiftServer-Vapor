//
//  OAuthController.swift
//  App
//
//  Created by job on 2018/11/9.
//

import Vapor

class OAuthController: RouteCollection{
    func boot(router: Router) throws {
        router.group("oauth") { (group) in
            group.post("regist", use: self.regist)
            group.post("login", use: self.login)
            group.post("getUserInfo", use: self.getUserInfo)
            group.post("setUserInfo", use: self.setUserInfo)
            group.post("exit", use: self.exit)
        }
    }
    
    // MARK: 注册
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
//                    let result =  content.update(on: req, originalID: 2)

                    let result =  content.save(on: req)
                    return result.flatMap({ content in
                        let accessToken = try AccessTokenController.sharedInstance.addToken(content.id!, on: req)
                        return try ResponseJSON<AccessToken>(code: 0, message: "注册成功", data: accessToken).encode(for: req)
                    })
                }
                return try ResponseJSON<Empty>(code: 101, message: "用户已存在").encode(for: req)
            })
        })
    }
    
    // MARK: 登录
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
    
    // MARK: 获取个人信息
    func getUserInfo(_ req: Request) throws -> Future<Response> {
 
        /********   第二种👋token验证   Request->func(route)->func(getUID)->func(route)->func(getUID)->Response    *******/
        return try AccessTokenController.sharedInstance.getUserIDReview(req: req, UID: { (uid) -> (EventLoopFuture<Response>) in
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
    // MARK: 设置个人信息
    func setUserInfo(_ req:Request) throws -> Future<Response> {
        
        return try AccessTokenController.sharedInstance.getUserIDReview(req: req, UID: { (uid) -> (EventLoopFuture<Response>) in
            // 查找
            return User
                .query(on: req)
                .filter(\.id, .equal, uid)
                .first()
                .flatMap({ (user) in
                    
                    guard user != nil else{
                        return try ResponseJSON<Empty>(code: 103, message: "token错误 没有找到这个用户").encode(for: req)
                    }

                    //获取请求的数据
                    return try req.content.decode(User.self).flatMap({ content in
                        
                        if content.age != nil  {
                            user?.age = content.age
                        }
                        if content.name != nil  {
                            user?.name = content.name
                        }
                        if content.headImage != nil  {
                            user?.headImage = content.headImage
                        }
                        return  user!.update(on: req).flatMap({ content in
                            
                            return try ResponseJSON<User>(code: 0, message: "设置成功", data:content).encode(for: req)

                        })
                        
                    })
                })
        })
    }
    // MARK: 退出登录
    func exit(_ req:Request) throws -> Future<Response> {
        
        return try AccessTokenController.sharedInstance.exit(req)
        
    }
    
    
    
 
}

