import Foundation
import Combine

struct DecodableLoader<T: Decodable> {
    var urlSession = URLSession.shared
    var url: URL
    
    var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.defaultFormatter)
        return decoder
    }()

    func load() -> AnyPublisher<T, Error> {
        DataLoader(urlSession: urlSession, url: url)
            .load()
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

