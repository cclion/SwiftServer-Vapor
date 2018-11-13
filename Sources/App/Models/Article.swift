//
//  Article.swift
//  App
//
//  Created by job on 2018/11/13.
//

import FluentSQLite
import Vapor

final class Article: SQLiteModel {
    
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
