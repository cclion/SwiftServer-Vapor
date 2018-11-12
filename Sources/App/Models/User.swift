//
//  User.swift
//  App
//
//  Created by job on 2018/11/9.
//

import FluentSQLite
import Vapor

final class User: SQLiteModel {
    /// The unique identifier for this `Todo`.
    var id: Int?
    
    /// A title describing what this `Todo` entails.
    var phone: String
    
    /// Creates a new `Todo`.
    init(id: Int? = nil, title: String) {
        self.id = id
        self.phone = title
    }
}

extension User: Migration { }

extension User: Content { }

extension User: Parameter { }
