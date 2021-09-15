import SwiftUI
import Combine

struct MovieDetails: View {
    var movie: Movie
    var body: some View {
        ScrollView {
            VStack {
                if let posterPath = movie.posterPath {
                    ImageView(withURL: getImageURL(posterPath))
                }
                
                Text(movie.overview)
            }
            .padding(10)
        }
        .navigationTitle(movie.title)
    }
    
    private func getImageURL(_ path: String) -> String {
        "https://image.tmdb.org/t/p/w500\(path)"
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movie:
                        .init(
                            id: 0,
                            title: "title",
                            originalTitle: "original title",
                            voteCount: 0,
                            popularity: 0,
                            posterPath: nil,
                            backdropPath: nil,
                            releaseDate: nil,
                            genreIds: [],
                            overview: "",
                            originalLanguage: "",
                            voteAverage: 0
                        )
        )
    }
}
