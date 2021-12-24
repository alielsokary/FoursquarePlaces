//
//  NetworkError.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import Foundation

enum NetworkError: Error {
	case badRequest
	case requestNotFound
	case requestTimeout
	case internalServerError
	case gatewatTimeout
	case noInternetConnection
	case unknownError
}

extension NetworkError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .badRequest:
			return "Bad request, server cannot perform request"
		case .requestNotFound:
			return "Not found, please check it and try again"
		case .requestTimeout:
			return "Request timeout"
		case .internalServerError:
			return "Internal Server error"
		case .gatewatTimeout:
			return "Gateway timeout"
		case .noInternetConnection:
			return "The Internet connection appears to be offline. Please try again."
		case .unknownError:
			return "Something went wrong please try again later"
		}
	}
}
