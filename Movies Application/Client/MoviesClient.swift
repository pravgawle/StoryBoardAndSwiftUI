//
//  Copyright © Pravin G. All rights reserved.
//

import Foundation

public class MoviesClient {
	let baseUrl: URL
	
	public init() {
		
		guard let url = URL(string: Constants.baseURL) else {
			preconditionFailure("Unable to build URL")
		}
		self.baseUrl = url
	}
	
	public func movieDetails(_ id: Int) async throws -> MovieDetails {
		fatalError("Missing Implementation")
	}
}
