//
//  VenueViewModelTests.swift
//  FoursquarePlacesTests
//
//  Created by Ali Elsokary on 21/12/2021.
//  
//

import XCTest
@testable import FoursquarePlaces

class VenueViewModelTests: XCTestCase {

	var venue: Venue!
	var category = Category(id: 517, name: "Restaurant")
	var location = Location(address: "77 st London",
						 country: "England",
							crossStreet: "77 ats ST",
							dma: "abd",
							locality: "GB",
							neighborhood: ["Liverpool"],
							postcode: "11654",
							region: "Liverpool")
	var sut: VenueViewModel!

	override func setUpWithError() throws {
		super.setUp()
		venue = Venue(fsqID: "517da15ee4b0a366d29a839c",
					  name: "KFC",
					  location: location,
					  categories: [category],
					  distance: 28)

		sut = VenueViewModel(id: venue.fsqID!,
							 name: venue.name!,
							 address: (venue.location?.address!)!,
							 distance: venue.distance!,
							 category: (venue.categories?.compactMap { $0.name }.first!)!)
	}

    override func tearDownWithError() throws {
		super.tearDown()
		venue = nil
		sut = nil
    }

	func test_fsqId_equalsFsqid() throws {
		XCTAssertEqual(sut.id, venue.fsqID)
	}

	func test_name_equalsVenueName() throws {
		XCTAssertEqual(sut.name, venue.name)
	}

	func test_location_equalsVenueLocation() throws {
		XCTAssertEqual(sut.address, venue.location?.address)
	}

	func test_distance_equalsVenueDistance() throws {
		XCTAssertEqual(sut.distance, venue.distance)
	}

	func test_category_equalsVenueCategory() throws {
		XCTAssertEqual(sut.category, venue.categories?.compactMap { $0.name }.first)
	}

}
