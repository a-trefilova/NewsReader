//
//  NewsListViewModelFactoryMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 09.08.2021.
//

import UIKit
@testable import NewsReader

final class NewsListViewModelFactoryMock: ViewModelFactoryProtocol {

	var getCellViewModelCalled = false
	var getDetailViewModelCalled = false

	func getCellViewModel(for dto: NewsItemDTO) -> NewsItemViewModel {
		getCellViewModelCalled = true
		return NewsItemViewModel(id: "", title: "", description: "", date: "", image: Image(urlString: "", uploadedImage: UIImage()))
	}

	func getDetailViewModel(for dto: NewsItemDTO, uploadImageService: UploadImageServiceProtocol) -> DetailedItemViewModel {
		getDetailViewModelCalled = true
		return DetailedItemViewModel(newsItemId: "", image: Image(urlString: "", uploadedImage: UIImage()), title: "", description: "", authorName: "", date: "")
	}
}
