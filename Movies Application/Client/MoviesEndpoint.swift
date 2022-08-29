//
//  Copyright © Pravin G. All rights reserved.
//

import UIKit

enum MoviesEndpoint {
		case popular
		case movieDetail(id: Int)
}

struct Constants {
	static let apiKey: String = "api_key"
	static let apiKeyValue: String = "bf718d4dd8b23985d9c3edbcfd440a27"
	static let languageKey: String = "language"
	static let baseURL: String = "https://api.themoviedb.org/3"
	static let pageKey: String = "page"
}

extension MoviesEndpoint: APIEndpoint {
	
	var queryParameters: [URLQueryItem]? {
		return [URLQueryItem(name: Constants.apiKey, value: Constants.apiKeyValue),
						 URLQueryItem(name: Constants.languageKey, value: "en—US"),
						 URLQueryItem(name: Constants.pageKey, value: "1")]
	}
	
	var path: String {
		switch self {
		case .popular:
			return "/3/movie/popular"
		case .movieDetail(let id):
			return "/3/movie/\(id)"
		}
	}
	
	var method: RequestMethod {
		switch self {
		case .popular, .movieDetail:
			return .get
		}
	}
	
	var header: [String: String]? {
		return nil
	}
	
	var body: [String: String]? {
		return nil
	}
}
