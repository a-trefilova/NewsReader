//
//  NewsListInteractorMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import UIKit
@testable import NewsReader


final class NewsListInteractorMock: NewsListInteractorProtocol {

	var getListOfItemsCalled = false
	var getImageCalled = false

	func getListOfItems(completion: @escaping (Result<[NewsItemViewModel], ErrorType>) -> Void) {
		getListOfItemsCalled = true
		completion(.success([]))
	}

	func getImage(viewModelId: String, completion: @escaping (UIImage) -> Void) {
		getImageCalled = true
		completion(UIImage())
	}
}
