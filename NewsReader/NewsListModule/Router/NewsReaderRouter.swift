//
//  NewsReaderRouter.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import UIKit

class NewsReaderRouter {
    
    let navigationController: UINavigationController
    weak var viewController: NewsListVC!
    
    init(viewController: NewsListVC) {
        self.viewController = viewController
        if let navController = viewController.navigationController {
            navigationController = navController
        } else {
            navigationController = UINavigationController(rootViewController: viewController)
        }
    }
    
    func showDetailedViewController(newsItem: NewsItem) {
        let detailedViewController = DetailedItemAssembly().assembleDetailedItemModule(newsItem: newsItem)
        viewController.present(detailedViewController, animated: true, completion: nil)
    }
}
