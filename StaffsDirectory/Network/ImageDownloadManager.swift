//
//  ImageDownloadManager.swift
//  StaffsDirectory
//
//  Created by Admin on 08/07/2022.
//

import Foundation

protocol ImageDownLoaderType {
    func getImage(url:String, completion:@escaping (Data)->Void)
}

class ImageDownloader:ImageDownLoaderType {

    static let shared = ImageDownloader()
    private init() {}

    func getImage(url: String, completion:@escaping (Data) -> Void) {
        
        let imageCache = ImageCache.shared
        
        if let image = imageCache.getImage(url: url) {
            completion(image)
        }else {
            dowloadImage(url: url) { imageData in
                imageCache.saveImage(url: url, data:imageData )
                completion(imageData)
            }
        }
    }

    private func dowloadImage(url:String, completion:@escaping (Data)->Void) {

        guard let _url = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: _url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil
                else { return }

              completion(data)
        }.resume()

    }
}
