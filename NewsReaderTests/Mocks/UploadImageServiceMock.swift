//
//  NewsListUploadImageServiceMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import UIKit
@testable import NewsReader

final class UploadImageServiceMock: UploadImageServiceProtocol {

	var fetchItemsCalled = false

	func fetchItems(forEntryPoint entryPoint: String, completion: @escaping (UIImage) -> Void) {
		fetchItemsCalled = true 
	}

}
