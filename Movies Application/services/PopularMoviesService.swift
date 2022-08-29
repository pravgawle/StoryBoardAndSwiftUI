//
//  Copyright © Pravin G. All rights reserved.
//

import UIKit

protocol PopularMoviesServiceProtocol {
		func getPopularMovies() async -> Result<PopularMovies, RequestError>
		func getMovieDetail(id: Int) async -> Result<MovieDetails, RequestError>
}

struct PopularMoviesService: APIClient, PopularMoviesServiceProtocol {
		func getPopularMovies() async -> Result<PopularMovies, RequestError> {
				return await sendRequest(endpoint: MoviesEndpoint.popular, responseModel: PopularMovies.self)
		}
		
		func getMovieDetail(id: Int) async -> Result<MovieDetails, RequestError> {
				return await sendRequest(endpoint: MoviesEndpoint.movieDetail(id: id), responseModel: MovieDetails.self)
		}
}
