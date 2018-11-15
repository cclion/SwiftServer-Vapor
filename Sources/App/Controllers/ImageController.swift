//
//  ImageController.swift
//  App
//
//  Created by job on 2018/11/15.
//

import Foundation
import Vapor
import Crypto
import Random


final class ImageController{
    
    func updateImage(_ req: Request) throws -> Future<Response> {
        
        return try AccessTokenController.sharedInstance.getUserIDReview(req: req, UID: { (userD) -> (EventLoopFuture<Response>) in

          return try req.content.decode(Image.self).flatMap({ image in
            
            guard let imageFile = image.image else {
                return try ResponseJSON<Empty>(code: 101, message: "图片哪里去了").encode(for: req)
            }
            guard imageFile.data.count < 2048000 else {
                return try ResponseJSON<Empty>(code: 101, message: "图片太大了").encode(for: req)
            }
            
            let imageName = try self.getImageName()
            let basePath = self.getPath(req)
            let path = (basePath+imageName+".png")
            try Data(imageFile.data).write(to: URL(fileURLWithPath: path))
            
            return try ResponseJSON<Empty>(code: 0, message: "上传成功").encode(for: req)

          })
        })
    }
    
    func getImage(_ req:Request) throws -> Future<Response> {
        
         let imageName = try req.parameters.next(String.self)
         let basePath = self.getPath(req)
         let imagePath = basePath + imageName
        
        if !FileManager.default.fileExists(atPath: imagePath) {
            return try ResponseJSON<Empty>(code: 101, message: "获取不到").encode(for: req)
        }
        return try req.streamFile(at: imagePath)
        
    }
    
}


private extension ImageController {
    
    func getImageName() throws -> String {
        
        let n = try CryptoRandom().generate(Int.self).description
        
        let s = Date().timeIntervalSince1970.description
        
        let imageName =  try MD5.hash(n + s).base64URLEncodedString()
        
        return imageName
    }
    
    func getPath(_ req: Request) -> String {
        if req.environment.isRelease {
            return "/home/VaporSwift/image/"
        }else{
            return "/Users/job/Desktop/image/"
        }
    }
    
    
    
}
