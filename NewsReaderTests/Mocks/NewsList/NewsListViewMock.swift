//
//  NewsListViewMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import UIKit
@testable import NewsReader

final class NewsListViewMock: NewsListViewProtocol {

	private(set) var showListOfViewModelsCalled = false
	private(set) var updateCellCalled = false
	private(set) var presentViewControllerCalled = false

	func showListOfViewModels(viewModels: [NewsItemViewModel]) {
		showListOfViewModelsCalled = true
	}

	func updateCell(at indexPath: IndexPath, with image: UIImage) {
		updateCellCalled = true
	}

	func presentViewController(_ controller: UIViewController, animated: Bool) {
		presentViewControllerCalled = true
	}
}
