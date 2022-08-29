//
//  Copyright © Pravin G. All rights reserved.
//

import Foundation

struct MovieSummary: Codable {
	let id: Int
	let overview: String
	let posterPath: String
	let releaseDate: String
	let title: String
	let voteAverage: Double
	
	public var isPopular: Bool {
		voteAverage > 8
	}
	
	public var thumbnailURL: URL {
		guard let baseURL = URL(string: "https://image.tmdb.org/t/p/w300") else {
			preconditionFailure("Unable to build URL")
		}
		return baseURL.appendingPathComponent(posterPath)
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case overview
		case posterPath = "poster_path"
		case releaseDate = "release_date"
		case title
		case voteAverage = "vote_average"
	}
}

extension MovieSummary {
	static let example = MovieSummary(id: 0, overview: "Great Movie", posterPath: "", releaseDate: "", title: "Movie", voteAverage: 4.5)
}
