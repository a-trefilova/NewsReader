
import UIKit

final class DataStore {
    let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    private(set) var dataTransferObjects: [NewsItemDTO] = []

    func saveData(data: [NewsItemDTO]) {
        self.dataTransferObjects = data
    }
}
