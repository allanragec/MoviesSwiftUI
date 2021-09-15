import Foundation
import Combine

class MoviesRepository {
    func searchByQuery(_ query: String) -> AnyPublisher<SearchMoviesResult, Error> {
        guard let url = URL(string: searchWithQuery(query)) else {
            return Empty().eraseToAnyPublisher()
        }
        
        return DecodableLoader<SearchMoviesResult>(url: url).load()
    }
    
    func searchWithQuery(_ query: String) -> String {
        "\(Settings.ENDPOINT)/3/search/movie?api_key=\(Settings.API_KEY)&language=en-US&query=\(query)&include_adult=false".normalizedURL
    }
}
