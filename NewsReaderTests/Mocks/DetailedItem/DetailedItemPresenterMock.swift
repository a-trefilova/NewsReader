//
//  DetailedItemPresenterMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import Foundation
@testable import NewsReader

class DetailedItemPresenterMock: DetailedItemPresenterProtocol {

	var interactor: DetailedItemInteractorProtocol? = DetailedItemInteractorMock()
	var didLoadViewCalled = false
	var didTapOnOpenResourceCalled = false
	
	func didLoadView() {
		didLoadViewCalled = true
	}

	func didTapOnOpenResource() {
		didTapOnOpenResourceCalled = true
	}


}
