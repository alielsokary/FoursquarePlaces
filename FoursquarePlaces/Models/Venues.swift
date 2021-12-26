//
//  PlacesResult.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 21/12/2021.
//  
//

import Foundation

// MARK: - Venues
struct Venues: Codable {
	let results: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
	let fsqID: String?
	let name: String?
	let location: Location?
	let categories: [Category]?
	let distance: Int?

	enum CodingKeys: String, CodingKey {
		case fsqID = "fsq_id"
		case name, location, categories, distance
	}
}

// MARK: - Category
struct Category: Codable {
	let id: Int?
	let name: String?
}

// MARK: - Geocodes
struct Geocodes: Codable {
	let main, frontDoor: FrontDoor?

	enum CodingKeys: String, CodingKey {
		case main
		case frontDoor = "front_door"
	}
}

// MARK: - FrontDoor
struct FrontDoor: Codable {
	let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
	let address, country, crossStreet, dma: String?
	let locality: String?
	let neighborhood: [String]?
	let postcode, region: String?

	enum CodingKeys: String, CodingKey {
		case address, country
		case crossStreet = "cross_street"
		case dma, locality, neighborhood, postcode, region
	}
}
