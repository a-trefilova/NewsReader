//
//  CellIdentifier.swift
//  NewsReader
//
//  Created by 19399090 on 01.08.2021.
//

import UIKit

final class CellIdentifierFactory {
    func getId<T>(forCellType cellType: T) -> String {
        return String(describing: cellType.self)
    }
}
