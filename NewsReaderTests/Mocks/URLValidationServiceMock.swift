//
//  URLValidationServiceMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import Foundation
@testable import NewsReader

class URLValidationServiceMock: URLValidationServiceProtocol {

	var getValidUrlCalled = false

	func getValidUrl(completion: @escaping (Result<URL, ErrorType>) -> Void) {
		getValidUrlCalled = true
	}


}
