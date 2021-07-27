//
//  DetailedItemAssembly.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import UIKit

class DetailedItemAssembly {
    func assembleDetailedItemModule(newsItem: NewsItem) -> UIViewController {
        let view = DetailedItemVC()
        let presenter = DetailedItemPresenter(view: view)
        let interactor = DetailedItemInteractor(presenter: presenter)
       
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.newsItem = newsItem
        
        return view
    }
}
