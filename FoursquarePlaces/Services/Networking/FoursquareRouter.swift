//
//  FoursquareRouter.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import Foundation

enum FoursquareRouter {

	// MARK: - Endpoints
	case search(location: String)

	// MARK: - Properties
	var method: HTTPMethod {
		switch self {
		default:
			return .get
		}
	}

	var path: String {
		switch self {
		case .search:
			return Config.EndpointPath.search
		}
	}

	var parameters: [String: Any]? {
		switch self {
		case .search(let location):
			let parameters: [String: Any] = ["ll": "39.7524669,-105.0032014",
											 "limit": Config.venuesLimit]

			return parameters

		}
	}

	// MARK: - Methods
	func asURLRequest() throws -> URLRequest {
		let endpointPath: String = "\(Config.baseURL)\(path)"
		var components = URLComponents(string: endpointPath)
		var urlRequest = URLRequest(url: (components?.url)!)
		components?.queryItems = []
		urlRequest.httpMethod = method.rawValue
		urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
		urlRequest.setValue(Config.apiKey, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
		if parameters != nil {
			components?.queryItems?.append(contentsOf: parameters!.map { (key, value) in
				URLQueryItem(name: key, value: value as? String)
			})
		}
		urlRequest.url = components?.url

		return urlRequest
	}
}
