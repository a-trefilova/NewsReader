//
//  NewsListRouterMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import Foundation
@testable import NewsReader

final class NewsListRouterMock: NewsListRouterProtocol {

	var showDetailViewControllerCalled = false
	var showErrorMessageCalled = false

	func showDetailedViewController(for viewModelId: String) {
		showDetailViewControllerCalled = true
	}

	func showErrorMessage(_ message: String) {
		showErrorMessageCalled = true
	}
}
