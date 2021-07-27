

import Foundation

protocol NewsListServiceProtocol {
    func fetchItems(completion: @escaping ([NewsItem]) -> Void)
}

final class NewsListService: NewsListServiceProtocol {
    
    private var parser: XMLParserService!
    private let entryPoint = "http://static.feed.rbc.ru/rbc/logical/footer/news.rss"
    
    func fetchItems(completion: @escaping ([NewsItem]) -> Void) {
        guard let url = URL(string: entryPoint) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            if let data = data {
                self.parser = XMLParserService(data: data)
                self.parser.getResult { items in
                    completion(items)
                }
            }
        }
        task.resume()
    }
    
}


