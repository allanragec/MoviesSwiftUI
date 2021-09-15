import Foundation

struct SearchMoviesResult: Decodable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
