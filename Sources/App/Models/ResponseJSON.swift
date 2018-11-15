//
//  ResponseJSON.swift
//  App
//
//  Created by job on 2018/11/5.
//

import Vapor

struct Empty: Content {}

struct ResponseJSON<T: Content>: Content {
    private var code: Int
    private var message: String
    private var data: T?

    init(code: Int = 0,
         message: String,
         data:T?) throws {
        self.code = code
        self.message = message
        self.data = data
    }
    
    init(code: Int = 0,
         message: String) throws {
        self.code = code
        self.message = message
        self.data = nil
    }
 
}

