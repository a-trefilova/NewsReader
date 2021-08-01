//
//  UploadImageService.swift
//  NewsReader
//
//  Created by 19399090 on 30.07.2021.
//

import UIKit

protocol UploadImageServiceProtocol {
    func fetchItems(forEntryPoint entryPoint: String, completion: @escaping (UIImage?) -> Void)
}

class UploadImageService: UploadImageServiceProtocol {

    private let cache: NSCache<NSString, UIImage>
    init(cache: NSCache<NSString, UIImage>) {
        self.cache = cache
    }

    func fetchItems(forEntryPoint entryPoint: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: entryPoint)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: entryPoint) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
