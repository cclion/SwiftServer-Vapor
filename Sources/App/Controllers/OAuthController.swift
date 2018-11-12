//
//  OAuthController.swift
//  App
//
//  Created by job on 2018/11/9.
//

import Vapor

class OAuthController {
    
    func regist(_ req: Request) throws -> Future<Response> {
        //1.拿到phone数据库查重
        
        guard let phone = req.query[String.self, at:"phone"] else {
            return try ResponseJSON<Empty>(code: 101, message: "请输入手机号").encode(for: req)
        }
        guard req.query[String.self, at:"password"] != nil else {
            return try ResponseJSON<Empty>(code: 101, message: "请输入密码").encode(for: req)
        }
        
       return User.query(on: req).filter(\.phone, .equal, phone).first().flatMap({ (user) in
        
        guard user != nil else{
            return try ResponseJSON<Empty>(code: 0, message: "注册成功").encode(for: req)
        }
            return try ResponseJSON<Empty>(code: 101, message: "已经有了").encode(for: req)
        })

    }
    
    
    
    
    
    
}
