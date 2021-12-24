//
//  StorageManager.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 23/12/2021.
//  
//

import Foundation
import CoreData

class StorageManager {

	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "FoursquarePlaces")
		container.loadPersistentStores(completionHandler: { (_, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	func save<T>(_ objects: [T], entityName: String, completion: (NSManagedObjectContext) -> Void) {
		let context = persistentContainer.viewContext

		completion(context)
		do {
			try context.save()
		} catch {
			print("Error saving: \(error)")
		}
	}

	func fetch<T: NSManagedObject>(entityName: String, completion: ([NSFetchRequestResult]) -> [T]) -> [T]? {
		let context = persistentContainer.viewContext
		let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		request.returnsObjectsAsFaults = false
		var retrievedObjects: [T] = []
		do {
			let results = try context.fetch(request)
			if !results.isEmpty {
				retrievedObjects = completion(results)
			}
		} catch {
			print("Error retrieving: \(error)")
		}
		return retrievedObjects
	}

	func clearStorage(forEntity entity: String) {
		let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
			return $0 ? true : $1.type == NSInMemoryStoreType
		}

		let managedObjectContext = persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

		if isInMemoryStore {
			do {
				let entities = try managedObjectContext.fetch(fetchRequest)
				for entity in entities {
					if let entity = entity as? NSManagedObject {
						managedObjectContext.delete(entity)
					}
				}
			} catch let error as NSError {
				print(error)
			}
		} else {
			let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
			do {
				try managedObjectContext.execute(batchDeleteRequest)
			} catch let error as NSError {
				print(error)
			}
		}
	}

	func delete<T: NSManagedObject>(_ object: T) {
		let context = persistentContainer.viewContext
		context.delete(object)
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
	}
}
