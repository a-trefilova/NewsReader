

import Foundation

struct NewsItemDTO {
    let id = UUID().uuidString
    var title: String
    var description: String
    var link: String
    var pubDate: Date
    var imageUrl: String?
    var author: String?
}
