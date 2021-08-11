
import UIKit

protocol UploadImageServiceProtocol {
    func fetchItems(forEntryPoint entryPoint: String, completion: @escaping (UIImage) -> Void)
}

final class UploadImageService: UploadImageServiceProtocol {

    private let cache: NSCache<NSString, UIImage>
    init(cache: NSCache<NSString, UIImage>) {
        self.cache = cache
    }

    func fetchItems(forEntryPoint entryPoint: String, completion: @escaping (UIImage) -> Void) {
		let defaultImage = UIImage()
        let cacheKey = NSString(string: entryPoint)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: entryPoint) else {
            completion(defaultImage)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
				  error == nil,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(defaultImage)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
