import Foundation
import Combine

struct DataLoader {
    var urlSession = URLSession.shared
    var url: URL
    
    func load() -> AnyPublisher<Data, URLError> {
        urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
