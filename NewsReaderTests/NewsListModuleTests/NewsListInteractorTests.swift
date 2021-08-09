//
//  NewsListInteractorTests.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import XCTest
@testable import NewsReader

final class NewsListInteractorTests: XCTestCase {

	var interactor: NewsListInteractorProtocol!
	var presenter: NewsListPresenterMock!
	var newsListService: NewsListServiceMock!
	var uploadImageService: NewsListUploadImageServiceMock!
	var dataStore: NewsListDataStoreMock!
	var viewModelFactory: NewsListViewModelFactoryMock!

	override func setUp() {
		super.setUp()
		presenter = NewsListPresenterMock()
		newsListService = NewsListServiceMock()
		uploadImageService = NewsListUploadImageServiceMock()
		dataStore = NewsListDataStoreMock()
		viewModelFactory = NewsListViewModelFactoryMock()
		interactor = NewsListInteractor(presenter: presenter,
										newsListService: newsListService,
										uploadImageService: uploadImageService,
										dataStore: dataStore,
										viewModelFactory: viewModelFactory)
	}

	override func tearDown() {
		presenter = nil
		newsListService = nil
		uploadImageService = nil
		dataStore = nil
		viewModelFactory = nil
		interactor = nil
		super.tearDown()
	}

	func testGetListOfItems() {
		// arrange
		let completion: (Result<[NewsItemCellViewModel], ErrorType>) -> Void = { _ in }

		// act
		interactor.getListOfItems(completion: completion)

		//assert
		XCTAssertTrue(newsListService.fetchItemsCalled)
	}

	func testGetImage() {
		// arrange
		let viewModelId = "FE0C0B0C-D9C2-4F4D-9377-DBA5FEA051FA"
		let completion: (UIImage) -> Void = { _ in }

		// act
		interactor.getImage(viewModelId: viewModelId, completion: completion)

		// assert
		XCTAssertTrue(dataStore.dataTransferObjectsCalled)
	}

}

