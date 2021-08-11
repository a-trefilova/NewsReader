//
//  DetailedItemInteractorTests.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import XCTest
@testable import NewsReader

final class DetailedItemInteractorTests: XCTestCase {

	var interactor: DetailedItemInteractorProtocol!
	var presenter: DetailedItemPresenterMock!
	var dataStore: DataStoreMock!
	var uploadImageService: UploadImageServiceMock!
	var urlValidationService: URLValidationServiceMock!
	var viewModelFactory: NewsListViewModelFactoryMock!

	override func setUp() {
		super.setUp()
		presenter = DetailedItemPresenterMock()
		dataStore = DataStoreMock()
		uploadImageService = UploadImageServiceMock()
		urlValidationService = URLValidationServiceMock()
		viewModelFactory = NewsListViewModelFactoryMock()
		interactor = DetailedItemInteractor(presenter: presenter,
											dataStore: dataStore,
											uploadImageService: uploadImageService,
											urlValidationService: urlValidationService,
											viewModelFactory: viewModelFactory,
											dataObjectId: "")
	}

	override func tearDown() {
		interactor = nil
		presenter = nil
		dataStore = nil
		uploadImageService = nil
		urlValidationService = nil
		viewModelFactory = nil
		super.tearDown()
	}

	func testGetViewModel() {
		// arrange
		// act
		interactor.getViewModel(completion: {_ in})

		// assert
		XCTAssertTrue(dataStore.dataTransferObjectsCalled)
	}

	func testValidateUrl() {
		// arrange
		// assert
		interactor.validateUrl(completion: { _ in})

		// assert
		XCTAssertTrue(urlValidationService.getValidUrlCalled)
	}
}
