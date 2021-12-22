//
//  VenueViewModel.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 23/12/2021.
//  
//

import Foundation

class VenueViewModel {
	let name: String
	let address: String
	let distance: Int
	let category: String

	init(venue: Venue) {
		self.name = venue.name ?? ""
		self.address = venue.location?.address ?? ""
		self.distance = venue.distance ?? 0
		self.category = venue.categories?.compactMap { $0.name }.first ?? ""
	}
}
