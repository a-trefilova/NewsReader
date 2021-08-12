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
	var dataStore: DataStoreMock!
	var uploadImageService: UploadImageServiceMock!
	var urlValidationService: URLValidationServiceMock!

	override func setUp() {
		super.setUp()
		dataStore = DataStoreMock()
		uploadImageService = UploadImageServiceMock()
		urlValidationService = URLValidationServiceMock()
		interactor = DetailedItemInteractor(dataStore: dataStore,
											uploadImageService: uploadImageService,
											urlValidationService: urlValidationService)
	}

	override func tearDown() {
		interactor = nil
		dataStore = nil
		uploadImageService = nil
		urlValidationService = nil
		super.tearDown()
	}

	func testValidateUrl() {
		// arrange
		// assert
		interactor.validateUrl(completion: { _ in})

		// assert
		XCTAssertTrue(urlValidationService.getValidUrlCalled)
	}
}
