
import Foundation

protocol XMLParserServiceDelegate: AnyObject {
    func getItems(_ items: [NewsItem])
}

class XMLParserService: NSObject, XMLParserDelegate {
    
    var completionHandler: (([NewsItem]) -> Void)?
    private lazy var parser: XMLParser = {
        let parser = XMLParser(data: data)
        parser.delegate = self
        return parser
    }()
    private var arrayOfNewsItems: [NewsItem] = []
    private var currentXMLTag: String = ""
    private var currentNewsItem = NewsItem(title: "",
                                           description: "",
                                           link: "",
                                           pubDate: Date(),
                                           imageUrl: "",
                                           author: "")
    private var shouldReturnResult = false
    
    private let data: Data
    init(data: Data) {
        self.data = data
        super.init()
        parser.parse()
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        currentXMLTag = elementName
        if elementName == "enclosure",
           let url = attributeDict["url"],
           attributeDict["type"] == "image/jpeg" {
            currentNewsItem.imageUrl = url
        }
    }
    
    func parser(_ parser: XMLParser,
                foundCharacters string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        switch currentXMLTag {
        case "title" : currentNewsItem.title += string
        case "description": currentNewsItem.description += string
        case "link" : currentNewsItem.link += string
        case "pubDate": currentNewsItem.pubDate = formatter.date(from: string) ?? Date()
        case "author": currentNewsItem.author? += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        if elementName == "item" {
            arrayOfNewsItems.append(currentNewsItem)
            resetCurrentItem()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        shouldReturnResult = true
    }
    
    func getResult(completion: @escaping ([NewsItem]) -> Void) {
        if shouldReturnResult {
            completion(arrayOfNewsItems)
        } else {
            getResult(completion: { _ in })
        }
    }
    
    private func resetCurrentItem() {
        currentNewsItem = NewsItem(title: "",
                                   description: "",
                                   link: "",
                                   pubDate: Date(),
                                   imageUrl: "",
                                   author: "")
    }
}

