
import UIKit

protocol DataStoreProtocol {
	var cache: NSCache<NSString, UIImage> { get }
	var dataTransferObjects: [NewsItemDTO] { get }
	func saveData(data: [NewsItemDTO])
}

final class DataStore: DataStoreProtocol {
    let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    private(set) var dataTransferObjects: [NewsItemDTO] = []

    func saveData(data: [NewsItemDTO]) {
        self.dataTransferObjects = data
    }
}
