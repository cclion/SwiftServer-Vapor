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
    
}

private extension OAuthController {
    
    // 添加token
    
    func addToken(_ uid: Int, on connection: DatabaseConnectable) throws -> AccessToken {

        let accessToken = try AccessToken(userID: uid)
        
        _ = accessToken.save(on: connection)

        return accessToken
        
    }

}
