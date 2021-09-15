import Foundation

extension String {
    var normalizedURL: String {
        addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? self
    }
}
