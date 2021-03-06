//
//  NewsListPresenterMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import Foundation
@testable import NewsReader

final class NewsListPresenterMock: NewsListPresenterProtocol {

	var didLoadViewCalled = false
	var didSelectViewModelCalled = false
	var didLoadCellCalled = false

	func didLoadView() {
		didLoadViewCalled = true
	}

	func didSelectViewModel(_ viewModel: NewsItemViewModel) {
		didSelectViewModelCalled = true
	}

	func didLoadCell(at indexPath: IndexPath, viewModelId: String) {
		didLoadCellCalled = true
	}
}
