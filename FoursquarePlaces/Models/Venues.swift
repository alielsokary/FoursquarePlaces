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
	let categories: [Category]?
	let distance: Int?
	let geocodes: Geocodes?
	let location: Location?
	let name: String?
	let timezone: String?

	enum CodingKeys: String, CodingKey {
		case fsqID = "fsq_id"
		case categories, distance, geocodes, location, name
		case timezone
	}
}

// MARK: - Category
struct Category: Codable {
	let id: Int?
	let name: String?
	let icon: Icon?
}

// MARK: - Icon
struct Icon: Codable {
	let iconPrefix: String?
	let suffix: String?

	enum CodingKeys: String, CodingKey {
		case iconPrefix = "prefix"
		case suffix
	}
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
