//
//  User.swift
//  App
//
//  Created by job on 2018/11/9.
//

import FluentMySQL
import Vapor

final class User: MySQLModel {

    var id: Int?
    
    var phone: String?
    
    var password: String?
    
    /*USERINFO*/
    
    var age: Int?

    var name: String?

    var headImage: String?

    /// Creates a new `User`.
    init(id: Int? = nil, title: String) {
        self.id = id
        self.phone = title
    }
}

extension User: Migration { }

extension User: Content { }

extension User: Parameter { }
