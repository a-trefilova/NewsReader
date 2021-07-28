
import UIKit

final class CacheService {
    
    private init() {}
    
    static let shared = CacheService()
    
    let cache = NSCache<NSString, UIImage>()
}
