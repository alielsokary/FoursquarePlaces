//
//  VenueViewModel.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 23/12/2021.
//  
//

import Foundation

class VenueViewModel {
	let id: String
	let name: String
	let address: String
	let distance: Int
	let category: String

	init(id: String, name: String, address: String, distance: Int, category: String) {
		self.id = id
		self.name = name
		self.address = address
		self.distance = distance
		self.category = category
	}
}
