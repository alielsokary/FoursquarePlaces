//
//  NetworkServiceMock.swift
//  FoursquarePlacesTests
//
//  Created by Ali Elsokary on 26/12/2021.
//  
//

import Foundation
@testable import FoursquarePlaces

class NetworkServiceMock: VenuesService {
	var returnValue: Bool = false
	var mockedVenues = Venues(results: [Venue(fsqID: "517da15ee4b0a366d29a839c",
											  name: "KFC",
											  location: Location(address: "77 st London",
																 country: "England",
																 crossStreet: "77 ats ST",
																 dma: "abd",
																 locality: "GB",
																 neighborhood: ["Liverpool"],
																 postcode: "11654",
																 region: "Liverpool"),
											  categories: [Category(id: 517, name: "Restaurant")],
											  distance: 28)])
	var mockedError = NetworkError.unknownError
	func search(location: String, completion: @escaping (Result<Venues, NetworkError>) -> Void) {
		returnValue ? completion(.success(mockedVenues)) : completion(.failure(mockedError))
	}

}
