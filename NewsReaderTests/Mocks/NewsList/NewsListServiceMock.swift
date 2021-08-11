//
//  NewsListServiceMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import Foundation
@testable import NewsReader

final class NewsListServiceMock: NewsListServiceProtocol {

	var fetchItemsCalled = true

	func fetchItems(completion: @escaping (Result<[NewsItemDTO], ErrorType>) -> Void) {
		fetchItemsCalled = true
	}
}
