
import UIKit

class CacheManager {
    private init() {}
    static let shared = CacheManager()
    let cache = NSCache<NSString, UIImage>()
}
