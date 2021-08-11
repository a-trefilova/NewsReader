//
//  DetailedItemPresenterTests.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import XCTest
@testable import NewsReader

final class DetailedItemPresenterTests: XCTestCase {

	var presenter: DetailedItemPresenterProtocol!
	var view: DetailedItemViewMock!
	var interactor: DetailedItemInteractorMock!
	var router: DetailedItemRouterMock!

	override func setUp() {
		super.setUp()
		view = DetailedItemViewMock()
		interactor = DetailedItemInteractorMock()
		router = DetailedItemRouterMock()
		presenter = DetailedItemPresenter(view: view,
										  router: router,
										  viewModelId: "id")
		presenter.interactor = interactor

	}

	override func tearDown() {
		presenter = nil
		view = nil
		interactor = nil
		router = nil
		super.tearDown()
	}

	func testDidLoadView() {
		// arrange
		// act
		presenter.didLoadView()

		// assert
		XCTAssertTrue(interactor.getViewModelCalled)
	}

	func testDidTapOnOpenResource() {
		// arrange
		// act
		presenter.didTapOnOpenResource()

		// assert
		XCTAssertTrue(interactor.validateUrlCalled)
	}
}
