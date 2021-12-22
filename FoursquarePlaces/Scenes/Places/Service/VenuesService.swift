//
//  VenuesService.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import Foundation

protocol VenuesService {
	func search(location: String, completion: @escaping(Swift.Result<Venues, NetworkError>) -> Void)
}

class VenuesServiceImpl: VenuesService {
	private let service = NetworkService()

	func search(location: String, completion: @escaping (Swift.Result<Venues, NetworkError>) -> Void) {
		return service.fetchRequest(forEndpoint: .search(location: location), completion: completion)
	}
}
