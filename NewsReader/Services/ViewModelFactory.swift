//
//  ViewModelFactory.swift
//  NewsReader
//
//  Created by 19399090 on 06.08.2021.
//

import UIKit

protocol ViewModelFactoryProtocol {
	func getCellViewModel(for dto: NewsItemDTO) -> NewsItemCellViewModel
	func getDetailViewModel(for dto: NewsItemDTO, uploadImageService: UploadImageServiceProtocol) -> DetailedItemViewModel
}

class ViewModelFactory: ViewModelFactoryProtocol {

	public func getCellViewModel(for dto: NewsItemDTO) -> NewsItemCellViewModel {
		let title = dto.title
		let description = dto.description.cut(maxLength: 100)
		let date = self.turnDateIntoString(date: dto.pubDate)
		let image = Image(urlString: dto.imageUrl ?? "", uploadedImage: UIImage())
		let id = dto.id
		let cellViewModel = NewsItemCellViewModel(id: id, title: title, description: description, date: date, image: image)
		return cellViewModel
	}

	public func getDetailViewModel(for dto: NewsItemDTO, uploadImageService: UploadImageServiceProtocol) -> DetailedItemViewModel {
		let entryPoint = dto.imageUrl ?? ""
		var uploadedImage: UIImage = UIImage()
		let group = DispatchGroup()
		group.enter()
		uploadImageService.fetchItems(forEntryPoint: entryPoint) { (image) in
			uploadedImage = image
			group.leave()
		}
		group.wait()
		let viewModel = DetailedItemViewModel(newsItemId: dto.id,
											  image: Image(urlString: dto.imageUrl ?? "", uploadedImage: uploadedImage),
											  title: dto.title,
											  description: dto.description,
											  authorName: dto.author ?? "",
											  date: turnDateIntoString(date: dto.pubDate))
		return viewModel
	}

	
	private func turnDateIntoString(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM dd,yyyy"
		return formatter.string(from: date)
	}

}
