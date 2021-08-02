//
//  ErrorType.swift
//  NewsReader
//
//  Created by 19399090 on 28.07.2021.
//

import Foundation

enum ErrorType: Error {
    case parsingFailure(String)
    case connectionFailure(String)
    case invalidEntryPoint(String)
}
