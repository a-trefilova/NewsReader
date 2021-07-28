

import Foundation

protocol NewsListServiceProtocol {
    func fetchItems(completion: @escaping (Result<[NewsItem], ErrorType>) -> Void)
}

final class NewsListService: NewsListServiceProtocol {
    
    private var parser: XMLParserService?
    private let entryPoint = "http://static.feed.rbc.ru/rbc/logical/footer/news.rss"
    
    func fetchItems(completion: @escaping (Result<[NewsItem], ErrorType>) -> Void) {
        guard let url = URL(string: entryPoint) else {
            completion(.failure(.invalidEntryPoint))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  error == nil,
                  let data = data else {
                completion(.failure(.connectionFailure))
                return
            }
            self.parser = XMLParserService(data: data)
            self.parser?.getResult { result in completion(result) }
        }
        task.resume()
    }
}


