//
//  DetailedItemInteractorTests.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import Foundation
@testable import NewsReader

final class DetailedItemInteractorMock: DetailedItemInteractorProtocol {

	var getViewModelCalled = false
	var validateUrlCalled = false

	func getViewModel(completion: @escaping (DetailedItemViewModel) -> Void) {
		getViewModelCalled = true
	}

	func validateUrl(completion: @escaping (Result<URL, ErrorType>) -> Void) {
		validateUrlCalled = true
	}

}
