//
//  VersionMiddleware.swift
//  App
//
//  Created by job on 2018/11/27.
//
import Foundation
import Vapor

final class VersionMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        
       return try next.respond(to: request).flatMap({ (resp) in

        resp.http.headers.add(name: HTTPHeaderName("Version"), value: "API:v1.0")

        return try resp.encode(for: request)
       })
    }
}
