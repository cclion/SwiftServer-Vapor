//
//  Image.swift
//  App
//
//  Created by job on 2018/11/15.
//

import FluentMySQL
import Vapor

final class Image: Content {
    
    var id: Int?
    
    var imageName: String?
    
    var image: File?
    
}

//extension Image: Migration { }
//
//extension Image: Content { }
//
//extension Image: Parameter { }


