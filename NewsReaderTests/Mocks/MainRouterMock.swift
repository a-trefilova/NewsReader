//
//  MainRouterMock.swift
//  NewsReaderTests
//
//  Created by 19399090 on 10.08.2021.
//

import UIKit
@testable import NewsReader

class MainRouterMock: MainRouterProtocol {

	private(set) var setInitialViewControllerCalled = false
	private(set) var showDetailedViewControllerCalled = false
	private(set) var openResourceCalled = false


	func setInitialViewController() {
		setInitialViewControllerCalled = true
	}

	func showDetailedViewController(for newsItemId: String) {
		 showDetailedViewControllerCalled = true
	}

	func openResource(resource: URL) {
		openResourceCalled = true
	}


}

