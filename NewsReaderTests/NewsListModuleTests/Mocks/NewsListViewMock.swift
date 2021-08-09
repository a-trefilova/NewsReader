//
//  NewsListViewMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import UIKit
@testable import NewsReader

final class NewsListViewMock: NewsListViewProtocol {

	var showListOfViewModelsCalled = false
	var updateCellCalled = false

	func showListOfViewModels(viewModels: [NewsItemCellViewModel]) {
		showListOfViewModelsCalled = true
	}

	func updateCell(at indexPath: IndexPath, with image: UIImage) {
		updateCellCalled = true
	}
}
