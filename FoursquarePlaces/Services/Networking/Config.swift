//
//  Config.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import Foundation

struct Config {
	static let baseURL: String = "https://api.foursquare.com/v3/"

	struct EndpointPath {
		static let search = "places/nearby"
	}

	static let apiKey = "fsq3mFYRYWX8iY00ZhbUzI3x1JIT2zO8uU2fuH286KTJ3tI="
}
enum HTTPHeaderField: String {
	case authentication = "Authorization"
	case contentType = "Content-Type"
}

enum ContentType: String {
	case json = "application/json"
	case form = "application/x-www-form-urlencoded"
}
