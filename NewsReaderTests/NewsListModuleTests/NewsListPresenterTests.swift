//
//  NewsListPresenterTests.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//
import UIKit
import XCTest
@testable import NewsReader

final class NewsListPresenterTests: XCTestCase {

	var presenter: NewsListPresenterProtocol!
	var interactor: NewsListInteractorMock!
	var view: NewsListViewMock!
	var router: NewsListRouterMock!

	override func setUp() {
		super.setUp()
		view = NewsListViewMock()
		router = NewsListRouterMock()
		interactor = NewsListInteractorMock()
		presenter = NewsListPresenter(view: view, router: router)
		presenter.interactor = interactor
	}

	override func tearDown() {
		view = nil
		router = nil
		presenter = nil
		super.tearDown()
	}

	func testDidLoadView() {
		// arrange
		// act
		presenter.didLoadView()

		// assert
		XCTAssertTrue(interactor.getListOfItemsCalled)
	}

	func testDidSelectViewModel() {
		// arrange
		let viewModelId = ""

		// act
		presenter.didSelectViewModel(viewModelId)

		// assert
		XCTAssertTrue(router.showDetailViewControllerCalled)
	}

	func testDidLoadCell() {
		// arrange
		let indexPath: IndexPath = IndexPath(row: 1, section: 0)
		let viewModelId = ""

		// act
		presenter.didLoadCell(at: indexPath, viewModelId: viewModelId)

		// assert
		XCTAssertTrue(interactor.getImageCalled)
	}

}
