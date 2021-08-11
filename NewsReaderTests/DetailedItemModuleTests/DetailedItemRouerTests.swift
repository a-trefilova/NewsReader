//
//  DetailedItemRouerTests.swift
//  NewsReaderTests
//
//  Created by 19399090 on 11.08.2021.
//

import XCTest
@testable import NewsReader

final class DetailedItemRouerTests: XCTestCase {

	var router: DetailedItemRouterProtocol!
	var rootView: DetailedItemViewMock!
	var mainRouter: MainRouterMock!

	override func setUp() {
		super.setUp()
		rootView = DetailedItemViewMock()
		mainRouter = MainRouterMock()
		router = DetailedItemRouter(rootView: rootView,
									mainRouter: mainRouter)

	}

	override func tearDown() {
		router = nil
		rootView = nil
		mainRouter = nil
		super.tearDown()
	}

	func testShowSafariLink() {
		// arrange
		let url = URL(string: "https://www.google.ru/")!

		// act
		router.showSafariLink(validUrl: url)

		// assert
		XCTAssertTrue(mainRouter.openResourceCalled)
	}

	func testShowErrorMessage() {
		// arrange
		let message = "message"
		var presentCalled = false
		rootView.presentViewControllerStub = { _, animated in
			presentCalled = animated
		}

		// act
		router.showErrorMessage(message)

		// assert
		XCTAssert(presentCalled)
	}
}
