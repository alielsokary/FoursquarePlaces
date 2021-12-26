//
//  StorageServiceMock.swift
//  FoursquarePlacesTests
//
//  Created by Ali Elsokary on 26/12/2021.
//  
//

import XCTest
@testable import FoursquarePlaces

class StorageServiceMock: StorageService {

	let venueViewModel = VenueViewModel(id: "517da15ee4b0a366d29a839c",
										name: "KFC",
										address: "77 st London",
										distance: 28,
										category: "Restaurant")
	var saveVenuesCalled = false
	var fetchVenuesCalled = false
	var clearCalled = false

	func save(venues: [VenueViewModel]) {
		saveVenuesCalled = true
	}

	func fetch() -> [VenueViewModel] {
		fetchVenuesCalled = true
		return [venueViewModel]
	}

	func clear() {
		clearCalled = true
	}

}
