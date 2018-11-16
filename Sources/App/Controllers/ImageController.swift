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
    
    // MARK: 保存图片
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
            let path = self.getPath(req,imageName: imageName)
            
            try Data(imageFile.data).write(to: URL(fileURLWithPath: path))
            
            return try ResponseJSON<Empty>(code: 0, message: "上传成功").encode(for: req)

          })
        })
    }
    // MARK: 获取图片
    func getImage(_ req:Request) throws -> Future<Response> {
        
        let imageName = try req.parameters.next(String.self)
        let path = self.getPath(req,imageName: imageName)

        if !FileManager.default.fileExists(atPath: path) {
            return try ResponseJSON<Empty>(code: 101, message: "获取不到").encode(for: req)
        }
        return try req.streamFile(at: path)
    }
    
}

private extension ImageController {
    // MARK: 获取图片名称 随机数+时间戳 MD5加密
    func getImageName() throws -> String {
        
        let n = try CryptoRandom().generate(Int.self).description
        let s = Date().timeIntervalSince1970.description
        let imageName =  try MD5.hash(n + s).base64URLEncodedString()+".png"
        
        return imageName
    }
    
    // MARK: 获取文件路径
    func getPath(_ req: Request, imageName: String) -> String {
        if req.environment.isRelease {
            return ("/home/VaporSwift/image/"+imageName)
        }else{
            return ("/Users/job/Desktop/image/"+imageName)
        }
    }
    
}
