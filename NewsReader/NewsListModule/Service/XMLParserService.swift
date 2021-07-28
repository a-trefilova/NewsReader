
import Foundation

final class XMLParserService: NSObject, XMLParserDelegate {

    private enum XMLTag: String {
        case item = "item"
        case enclosure = "enclosure"
        case url = "url"
        case type = "type"
        case title = "title"
        case description = "description"
        case link = "link"
        case pubDate = "pubDate"
        case author = "author"
    }
    private enum XMLEnclosureType: String {
        case image = "image/jpeg"
        case video = "video/mp4"
    }
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
    private var parsingDidFinishedWithError = false
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
        guard elementName == XMLTag.enclosure.rawValue,
              let url = attributeDict[XMLTag.url.rawValue],
              attributeDict[XMLTag.type.rawValue] == XMLEnclosureType.image.rawValue else { return }
        currentNewsItem.imageUrl = url
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let currentTag = XMLTag(rawValue: currentXMLTag)
        switch currentTag {
        case .title?: currentNewsItem.title += string
        case .description?: currentNewsItem.description += string
        case .link?: currentNewsItem.link += string
        case .pubDate?: currentNewsItem.pubDate = formatter.date(from: string) ?? Date()
        case .author?: currentNewsItem.author? += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        currentNewsItem.link = prepareLink(link: currentNewsItem.link)
        if elementName == XMLTag.item.rawValue {
            arrayOfNewsItems.append(currentNewsItem)
            resetCurrentItem()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        shouldReturnResult = true
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        parsingDidFinishedWithError = true
        shouldReturnResult = true
    }
    
    func getResult(completion: @escaping (Result<[NewsItem], ErrorType>) -> Void) {
        if shouldReturnResult {
            guard !parsingDidFinishedWithError else {
                completion(.failure(.parsingFailure))
                return 
            }
            completion(.success(arrayOfNewsItems))
        } else {
            getResult(completion: { _ in })
        }
    }
    
    private func prepareLink(link: String) -> String {
        var formattedLink = link.replacingOccurrences(of: "\n", with: "")
        formattedLink = formattedLink.replacingOccurrences(of: " ", with: "")
        return formattedLink
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

