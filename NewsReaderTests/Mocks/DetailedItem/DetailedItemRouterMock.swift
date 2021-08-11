//
//  DetailedItemRouterMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import Foundation
@testable import NewsReader

final class DetailedItemRouterMock: DetailedItemRouterProtocol {

	var showSafariLinkStub: ((URL) -> Void)?
	var showErrorMessageStub: ((String) -> Void)?

	func showSafariLink(validUrl: URL) {
		showSafariLinkStub?(validUrl)
	}

	func showErrorMessage(_ message: String) {
		showErrorMessageStub?(message)
	}

}
