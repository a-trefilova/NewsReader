//
//  NewsListService.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import Foundation

protocol NewsListServiceProtocol {
    func fetchItems(completion: ([NewsItem]) -> Void)
}

class NewsListService: NewsListServiceProtocol {
    func fetchItems(completion: ([NewsItem]) -> Void) {
        completion([])
    }
    
}
