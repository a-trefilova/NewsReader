//
//  NewsListPresenter.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import Foundation

protocol NewsListPresenterProtocol: AnyObject {
    func configureView()
    func showListOfItems()
}

class NewsListPresenter: NewsListPresenterProtocol {
    
    weak var view: NewsListViewProtocol?
    var interactor: NewsListInteractorProtocol!
    var router: NewsReaderRouter!  // FIXME: заменить на протокол
    
    init(view: NewsListViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view?.prepareView()
    }
    
    func showListOfItems() {
        interactor.getListOfItems { newsItems in
            self.view?.showListOfItems(items: newsItems)
        }
    }
    
}
