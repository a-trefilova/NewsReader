//
//  NewsListInteractor.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import Foundation

protocol NewsListInteractorProtocol {
    func getListOfItems(completion: ([NewsItem]) -> Void)
}

class NewsListInteractor: NewsListInteractorProtocol {
    weak var presenter: NewsListPresenterProtocol!
    let service: NewsListServiceProtocol = NewsListService()
    
    init(presenter: NewsListPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getListOfItems(completion: ([NewsItem]) -> Void) {
        service.fetchItems { items in
            completion(items)
        }
    }
}
