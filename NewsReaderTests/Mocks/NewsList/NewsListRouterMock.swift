//
//  NewsListRouterMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import Foundation
@testable import NewsReader

final class NewsListRouterMock: NewsListRouterProtocol {

	var showDetailedViewControllerStub: ((NewsItemViewModel) -> Void)?
	var showErrorMessageCalled = false

	func showDetailedViewController(_ newsItemViewModel: NewsItemViewModel) {
		showDetailedViewControllerStub?(newsItemViewModel)
	}

	func showErrorMessage(_ message: String) {
		showErrorMessageCalled = true
	}
}
