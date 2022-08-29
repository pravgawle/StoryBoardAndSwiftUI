//
//  Copyright © Pravin G. All rights reserved.
//

import UIKit
struct PopularMovies: Codable {
		let page: Int
		let totalPages: Int
		let totalResults: Int
		let results: [MovieSummary]

		enum CodingKeys: String, CodingKey {
				case page
				case results
				case totalPages = "total_pages"
				case totalResults = "total_results"
		}
}

