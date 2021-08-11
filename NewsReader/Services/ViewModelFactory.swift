//
//  ViewModelFactory.swift
//  NewsReader
//
//  Created by 19399090 on 06.08.2021.
//

import UIKit

protocol ViewModelFactoryProtocol {
	func getCellViewModel(for dto: NewsItemDTO) -> NewsItemViewModel
}

class ViewModelFactory: ViewModelFactoryProtocol {

	public func getCellViewModel(for dto: NewsItemDTO) -> NewsItemViewModel {
		let title = dto.title
		let description = dto.description.cut(maxLength: 100)
		let date = dto.pubDate.formateDateToString()
		let image = Image(urlString: dto.imageUrl ?? "", uploadedImage: UIImage())
		let id = dto.id
		print(id)
		let cellViewModel = NewsItemViewModel(id: id, title: title, description: description, date: date, image: image, urlString: dto.link, authorName: dto.author)
		return cellViewModel
	}
}
