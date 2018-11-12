//
//  OAuthController.swift
//  App
//
//  Created by job on 2018/11/9.
//

import Vapor

class OAuthController {
    
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
            return User.query(on: req).filter(\.phone, .equal, phone).first().flatMap({ (user) in
                
                guard user != nil else{
                
                    _ =  content.save(on: req)
                    return try ResponseJSON<Empty>(code: 0, message: "注册成功").encode(for: req)
                    
                }
                return try ResponseJSON<Empty>(code: 101, message: "用户已存在").encode(for: req)
            })
            
        })


    }
    
    
    
    
    
    
}
