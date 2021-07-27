//
//  XMLParserService.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import Foundation

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
    
    
    private let data: Data
    init(data: Data) {
        self.data = data
        super.init()
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentXMLTag = elementName
        if elementName == "enclosure",
           let url = attributeDict["url"],
           attributeDict["type"] == "image/jpeg" {
            currentNewsItem.imageUrl = url
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        print(currentXMLTag)
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            arrayOfNewsItems.append(currentNewsItem)
            resetCurrentItem()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(arrayOfNewsItems)
       completionHandler?(arrayOfNewsItems)
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
