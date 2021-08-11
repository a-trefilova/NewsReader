//
//  NewsListRouterTests.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import UIKit
import XCTest
@testable import NewsReader

final class NewsListRouterTests: XCTestCase {

	var rootView: NewsListViewMock!
	var mainRouter: MainRouterMock!
	var newsListRouter: NewsListRouterProtocol!

	override func setUp() {
		super.setUp()
		rootView = NewsListViewMock()
		mainRouter = MainRouterMock()
		newsListRouter = NewsListRouter(rootView: rootView, mainRouter: mainRouter)
	}

	override func tearDown() {
		rootView = nil
		mainRouter = nil
		newsListRouter = nil
		super.tearDown()
	}

	func testShowDetailViewController() {
		// arrange
		// act
		newsListRouter.showDetailedViewController(for: "")

		// assert
		XCTAssertTrue(mainRouter.showDetailedViewControllerCalled)
	}

	func testShowErrorMessage() {
		// arrange
		// act
		newsListRouter.showErrorMessage("")

		// assert
		XCTAssertTrue(rootView.presentViewControllerCalled)
	}
}
