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
	private let viewModel = NewsItemViewModel(id: "",
											  title: "",
											  description: "",
											  date: "",
											  image: Image(urlString: "", uploadedImage: UIImage()),
											  urlString: "",
											  authorName: "")

	override func setUp() {
		super.setUp()
		view = DetailedItemViewMock()
		interactor = DetailedItemInteractorMock()
		router = DetailedItemRouterMock()
		presenter = DetailedItemPresenter(interactor: interactor,
										  view: view,
										  router: router,
										  viewModel: viewModel)

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
		var renderCalled = false
		view.renderStub = { [self] showViewModel in
			renderCalled = showViewModel == viewModel
		}

		// act
		presenter.didLoadView()

		// assert
		XCTAssert(renderCalled)
	}

	func testDidTapOnOpenResource() {
		// arrange
		// act
		presenter.didTapOnOpenResource()

		// assert
		XCTAssertTrue(interactor.validateUrlCalled)
	}
}
