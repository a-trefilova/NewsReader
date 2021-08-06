
import Foundation

extension String {
    func cut(maxLength: Int) -> String {
        guard self.count > maxLength else { return self }
        let cutString = String(self.prefix(maxLength))
        return cutString + "..."
    }
}
