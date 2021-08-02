
import UIKit

final class CellIdentifierFactory {
    func getId<T>(forCellType cellType: T) -> String {
        return String(describing: cellType.self)
    }
}
