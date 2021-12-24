//
//  StorageService.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 24/12/2021.
//
//

import Foundation
import CoreData

protocol StorageService {
	func save(venues: [VenueViewModel])
	func fetch() -> [VenueViewModel]
	func clear()
}

class StorageServiceImpl: StorageService {

	private let manager = StorageManager()

	private let entityName = "ManagedVenue"

	func save(venues: [VenueViewModel]) {
		manager.save(venues, entityName: entityName) { context in
			for venue in venues {
				let managedObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
				setManagedObjectValue(managedObject: managedObject, venue: venue)
			}
		}
	}

	func fetch() -> [VenueViewModel] {
		var retrievedObjects: [VenueViewModel] = []
		var nsManagedObjects: [NSManagedObject] = []
		_ = manager.fetch(entityName: entityName) { results in
			if let results = results as? [NSManagedObject] {
				for result in results {
					let managedObject = getManagedObjectValue(result: result)
					nsManagedObjects.append(result)
					let venue = VenueViewModel(id: managedObject.id,
											   name: managedObject.name,
											   address: managedObject.address,
											   distance: managedObject.distance,
											   category: managedObject.category)
					retrievedObjects.append(venue)
				}
			}
			return nsManagedObjects
		}
		return retrievedObjects
	}

	func clear() {
		manager.clearStorage(forEntity: entityName)
	}

}

private extension StorageServiceImpl {
	func setManagedObjectValue(managedObject: NSManagedObject, venue: VenueViewModel) {
		managedObject.setValue(venue.id, forKey: "id")
		managedObject.setValue(venue.name, forKey: "name")
		managedObject.setValue(venue.address, forKey: "address")
		managedObject.setValue(venue.distance, forKey: "distance")
		managedObject.setValue(venue.category, forKey: "category")
	}

	func getManagedObjectValue(result: NSManagedObject) -> (id: String, name: String, address: String, distance: Int, category: String) {
		let id = result.value(forKey: "id") as? String ?? ""
		let name = result.value(forKey: "name") as? String ?? ""
		let address = result.value(forKey: "address") as? String ?? ""
		let distance = result.value(forKey: "distance") as? Int ?? 0
		let category = result.value(forKey: "category") as? String ?? ""
		return (id: id, name: name, address: address, distance: distance, category: category)
	}
}
