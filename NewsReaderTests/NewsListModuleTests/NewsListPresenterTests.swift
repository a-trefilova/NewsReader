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
		presenter = NewsListPresenter(interactor: interactor,
									  view: view,
									  router: router)
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
		var showDetailViewControllerCalled = false
		let viewModel = NewsItemViewModel(id: "", title: "", description: "", date: "", image: Image(urlString: "", uploadedImage: UIImage()), urlString: "", authorName: "")
		router.showDetailedViewControllerStub = { showViewModel in
			showDetailViewControllerCalled = showViewModel == viewModel
		}
		// act
		presenter.didSelectViewModel(viewModel)

		// assert
		XCTAssert(showDetailViewControllerCalled)
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
