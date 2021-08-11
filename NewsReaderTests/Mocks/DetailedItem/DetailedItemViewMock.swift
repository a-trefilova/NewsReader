//
//  DetailedItemViewMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 11.08.2021.
//

import UIKit
@testable import NewsReader

final class DetailedItemViewMock: DetaildItemViewProtocol {

	var renderStub: ((DetailedItemViewModel) -> Void)?
	var presentViewControllerStub: ((UIViewController, Bool) -> Void)?

	func render(viewModel: DetailedItemViewModel) {
		renderStub?(viewModel)
	}

	func presentViewController(_ viewController: UIViewController, animated: Bool) {
		presentViewControllerStub?(viewController, animated)
	}

}
