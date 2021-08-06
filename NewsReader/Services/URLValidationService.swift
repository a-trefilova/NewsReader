//
//  URLValidationService.swift
//  NewsReader
//
//  Created by 19399090 on 06.08.2021.
//

import Foundation

protocol URLValidationServiceProtocol {
	func getValidUrl(completion: @escaping (Result<URL, ErrorType>) -> Void)
}

final class URLValidationService: URLValidationServiceProtocol {

	private let urlString: String

	init?(urlString: String?) {
		if let urlString = urlString {
			self.urlString = urlString
		} else {
			return nil
		}
	}

	public func getValidUrl(completion: @escaping (Result<URL, ErrorType>) -> Void) {
		if let url = URL(string: urlString) {
			completion(.success(url))
		} else {
			completion(.failure(.invalidEntryPoint("URL Link is unavailable")))
		}
	}
}
