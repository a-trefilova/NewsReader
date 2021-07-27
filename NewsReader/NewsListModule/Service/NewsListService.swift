//
//  NewsListService.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import Foundation

protocol NewsListServiceProtocol {
    func fetchItems(completion: @escaping ([NewsItem]) -> Void)
}

class NewsListService: NewsListServiceProtocol {
    
    private let entryPoint = "http://static.feed.rbc.ru/rbc/logical/footer/news.rss"
    
    func fetchItems(completion: @escaping ([NewsItem]) -> Void) {
        guard let url = URL(string: entryPoint) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return }
            if let data = data {
                let parser = XMLParserService(data: data)
                parser.completionHandler = { items in
                    completion(items)
                }
            }
        }
        task.resume()
    }
    
}
