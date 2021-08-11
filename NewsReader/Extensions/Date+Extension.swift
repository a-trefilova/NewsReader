//
//  Date+Extension.swift
//  NewsReader
//
//  Created by 19399090 on 11.08.2021.
//

import Foundation

extension Date {

	func formateDateToString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
		return dateFormatter.string(from: self)
	}
}
