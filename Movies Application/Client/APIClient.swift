//
//  Copyright © Pravin G. All rights reserved.
//

import UIKit


protocol APIEndpoint {
		var scheme: String { get }
		var host: String { get }
		var path: String { get }
		var method: RequestMethod { get }
		var queryParameters: [URLQueryItem]? { get }
		var header: [String: String]? { get }
		var body: [String: String]? { get }
}

extension APIEndpoint {
		var scheme: String {
				return "https"
		}

		var host: String {
				return "api.themoviedb.org"
		}
}


protocol APIClient {
		func sendRequest<T: Decodable>(endpoint: APIEndpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension APIClient {
		func sendRequest<T: Decodable>(
				endpoint: APIEndpoint,
				responseModel: T.Type
		) async -> Result<T, RequestError> {
			var urlComponents = URLComponents()
			urlComponents.scheme = endpoint.scheme
			urlComponents.host = endpoint.host
			urlComponents.path = endpoint.path
			
			
			urlComponents.queryItems = endpoint.queryParameters
			
			guard let url = urlComponents.url else {
				return .failure(.invalidURL)
			}
			
			
			var request = URLRequest(url: url)
			request.httpMethod = endpoint.method.rawValue
			request.allHTTPHeaderFields = endpoint.header
			
			if let body = endpoint.body {
				request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
			}
			
			do {
				let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
				guard let response = response as? HTTPURLResponse else {
					return .failure(.noResponse)
				}
				switch response.statusCode {
				case 200...299:
					guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
						return .failure(.decode)
					}
					return .success(decodedResponse)
				case 401:
					return .failure(.unauthorized)
				default:
					return .failure(.unexpectedStatusCode)
				}
			} catch {
				return .failure(.unknown)
			}
		}
}


enum RequestMethod: String {
		case delete = "DELETE"
		case get = "GET"
		case patch = "PATCH"
		case post = "POST"
		case put = "PUT"
}

enum RequestError: Error {
		case decode
		case invalidURL
		case noResponse
		case unauthorized
		case unexpectedStatusCode
		case unknown
		
		var customMessage: String {
				switch self {
				case .decode:
						return "Decode error"
				case .unauthorized:
						return "Session expired"
				default:
						return "Unknown error"
				}
		}
}
