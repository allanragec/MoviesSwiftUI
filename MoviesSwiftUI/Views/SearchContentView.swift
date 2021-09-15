import SwiftUI

struct SearchContentView: View {
    @ObservedObject var viewModel = SearchMoviesViewModel()
    
    var loading: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    var moviesList: some View {
        List {
            if viewModel.isLoading {
                loading
            }
            else {
                ForEach(viewModel.movies, id: \.id) { movie in
                    movieItem(movie)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBarView(searchText: $viewModel.query)
                moviesList
            }
            .navigationTitle("Movies SwiftUI")
        }
    }
    
    fileprivate func movieItem(_ movie: Movie) -> NavigationLink<Text, MovieDetails> {
        NavigationLink(
            destination: MovieDetails(movie: movie),
            label: {
                Text(movie.title)
            })
    }
}

struct SearchContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContentView()
    }
}
