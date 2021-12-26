//
//  VenueListViewModelTests.swift
//  FoursquarePlacesTests
//
//  Created by Ali Elsokary on 26/12/2021.
//  
//

import XCTest
@testable import FoursquarePlaces

class VenueListViewModelTests: XCTestCase {

	var sut: VenueListViewModel!
	var service: NetworkServiceMock!
	var storageService: StorageServiceMock!

    override func setUpWithError() throws {
		super.setUp()
		service = NetworkServiceMock()
		storageService = StorageServiceMock()
		sut = VenueListViewModel(service: service, storageService: storageService)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

	func test_SearchWithSuccess() {
		service?.returnValue = true
		sut?.search(location: "")
		XCTAssertTrue(sut?.venues.compactMap { $0.name }.first! == "KFC")
		XCTAssertTrue(sut?.numberOfVenues == 1)
	}

	func test_SaveVenuesCallsSaveVenues() {
		sut.saveVenues(venues: [storageService.venueViewModel])
		XCTAssert(storageService.saveVenuesCalled)
	}

	func test_fecthVenuesCallsFetchVenues() {
		sut.fertchVenues()
		XCTAssertEqual(sut.venues, [storageService.venueViewModel])
		XCTAssert(storageService.fetchVenuesCalled)
	}

	func test_clearStorageCallsClearStorage() {
		sut.clearStorage()
		XCTAssert(storageService.clearCalled)
	}

}
