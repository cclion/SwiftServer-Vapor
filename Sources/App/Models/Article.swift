//
//  Article.swift
//  App
//
//  Created by job on 2018/11/13.
//

import FluentMySQL
import Vapor

final class Article: MySQLModel {
    
    var id: Int?
    
    var title: String?

    var content: String?
    
    var time: String?
    
    var image: String?
    
    var userID: Int?

}

extension Article: Migration { }

extension Article: Content { }

extension Article: Parameter { }
