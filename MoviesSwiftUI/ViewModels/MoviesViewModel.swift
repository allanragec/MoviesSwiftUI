import SwiftUI
import Combine

class SearchMoviesViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    private let repository = MoviesRepository()

    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { _ in self.resetSearchStatus() })
            .filter { !$0.isEmpty }
            .handleEvents(receiveOutput: { print("searching by: \($0)") })
            .map { self.fetchData($0) }
            .switchToLatest()
            .sink { result in
                self.updateResults(result)
            }
            .store(in: &subscriptions)
    }
    
    private func fetchData(_ query: String) -> AnyPublisher<SearchMoviesResult, Never> {
        repository.searchByQuery(query)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { _ in
                self.isLoading = true
            }, receiveCompletion: { result in
                if case let .failure(error) = result {
                    self.showError(error, forQuery: query)
                }
                
                self.isLoading = false
            })
            .retry(Settings.RETRY_REQUEST_ERROR_COUNT)
            .catch { _ in Just(.init(results: [], page: 0, totalPages: 0, totalResults: 0)) }
            .eraseToAnyPublisher()
    }
    
    private func updateResults(_ result: SearchMoviesResult) {
        self.movies = result.results
    }
    
    private func resetSearchStatus() {
        self.movies = []
    }
    
    private func showError(_ error: Error, forQuery: String) {
        print("Error during the fetch data: \(error) \nFor query: \(query)")
    }
}
