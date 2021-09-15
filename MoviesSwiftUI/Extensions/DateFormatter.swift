import Foundation

extension DateFormatter {
    static let defaultFormatter = DateFormatter.formatter("yyyy-MM-dd hh:mm:ss Z")
    static let dayFormatter = DateFormatter.formatter("yyyy-MM-dd")
    
    class func formatter(_ format:String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter
    }
}
