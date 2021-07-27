//
//  DetailedItemInteractor.swift
//  NewsReader
//
//  Created by 19399090 on 27.07.2021.
//

import UIKit

protocol DetailedItemInteractorProtocol: AnyObject {
    func validateUrl(urlString: String, completion: @escaping (URL) -> Void)
}

class DetailedItemInteractor: DetailedItemInteractorProtocol {

    weak var presenter: DetailedItemPresenterProtocol?
    init(presenter: DetailedItemPresenterProtocol) {
        self.presenter = presenter
    }
    func validateUrl(urlString: String, completion: @escaping (URL) -> Void) {
        if let url = URL(string: urlString) {
            completion(url)
        }
    }
    
}
