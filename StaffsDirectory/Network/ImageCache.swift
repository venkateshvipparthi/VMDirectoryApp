//
//  ImageCache.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import Foundation

protocol ImageCacheType {
    func getImage(url:String)-> Data?
    func saveImage(url:String, data:Data)
}

class ImageCache:ImageCacheType {
    static let shared = ImageCache()
    var cache = NSCache<NSString, NSData>()

    private init(){
       // cache.countLimit = 100
    }
    
    func getImage(url: String) -> Data? {
        return cache.object(forKey: url as NSString) as Data?
    }
    
    func saveImage(url: String, data: Data) {
        cache.setObject(data as NSData, forKey: url as NSString)
    }
}
