//
//  UploadImageService.swift
//  NewsReader
//
//  Created by 19399090 on 30.07.2021.
//

import UIKit

class UploadImageService {

    private let cache: NSCache<NSString, UIImage>
    private let entryPoint: String
    init(entryPoint: String, cache: NSCache<NSString, UIImage>) {
        self.entryPoint = entryPoint
        self.cache = cache
    }

    func fetchItems(completion: @escaping (UIImage?) -> Void) {
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
