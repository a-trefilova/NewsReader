//
//  NewsListDataStoreMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import UIKit
@testable import NewsReader

final class NewsListDataStoreMock: DataStoreProtocol {

	var cacheCalled = false
	var dataTransferObjectsCalled = false
	var saveDataCalled = false

	var cache: NSCache<NSString, UIImage> {
		get {
			cacheCalled = true
			return NSCache<NSString, UIImage>()
		}
	}

	var dataTransferObjects: [NewsItemDTO] {
		get {
			dataTransferObjectsCalled = true
			return []
		}
	}

	func saveData(data: [NewsItemDTO]) {
		saveDataCalled = true
	}

}
