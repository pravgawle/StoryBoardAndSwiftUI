//
//  Copyright © Pravin G. All rights reserved.
//

import UIKit

class PopularMoviesViewModel {

	public var movies: [MovieSummary]?
	private lazy var service = PopularMoviesService()

	func fetchData(completion: @escaping (Result<PopularMovies, RequestError>) -> Void) {
			Task {
					let result = await service.getPopularMovies()
				switch result {
				case .success(let response):
					self.movies = response.results
					completion(result)
				case .failure(_):
					completion(result)
				}
			}
	}
}
