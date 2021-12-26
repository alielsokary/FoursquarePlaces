//
//  VenuesViewModel.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import Foundation

protocol VenuesViewModelDelegate: AnyObject {
	func viewModelDidLoadVenues()
	func viewModel(_ viewModel: VenueListViewModel, failedToLoadWith error: NSError)
}

class VenueListViewModel {

	private let service: VenuesService
	private let storageService: StorageService
	weak var delegate: VenuesViewModelDelegate?

	var venues: [VenueViewModel] = []

	var numberOfVenues: Int {
		return venues.count
	}

	init(service: VenuesService = VenuesServiceImpl(), storageService: StorageService = StorageServiceImpl()) {
		self.service = service
		self.storageService = storageService
		self.fertchVenues()
	}

	func start() {
		LocationManager.shared.getLocation { [weak self] (location, error) in
			guard let self = self else { return }

			if let error = error {
				self.delegate?.viewModel(self, failedToLoadWith: error)
				return
			}

			guard let location = location else {
				return
			}
			let latitude = location.coordinate.latitude
			let longitude = location.coordinate.longitude

			self.search(location: "\(latitude),\(longitude)")
		}
	}

	func search(location: String) {
		service.search(location: location) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(venues):
				if let venues = venues.results?.compactMap({ self.mapVenue(venue: $0) }) {
					self.venues = venues
				}
				self.clearStorage()
				self.saveVenues(venues: self.venues)
				self.delegate?.viewModelDidLoadVenues()
			case let .failure(error):
				self.delegate?.viewModel(self, failedToLoadWith: error as NSError)
			}
		}
	}

	func saveVenues(venues: [VenueViewModel]) {
		self.storageService.save(venues: venues)
	}

	func fertchVenues() {
		let storedVeues = storageService.fetch()
		self.venues = storedVeues
	}

	func clearStorage() {
		self.storageService.clear()
	}
}

private extension VenueListViewModel {
	func mapVenue(venue: Venue) -> VenueViewModel {
		let id = venue.fsqID ?? ""
		let name = venue.name ?? ""
		let address = venue.location?.address ?? ""
		let distance = venue.distance ?? 0
		let category = venue.categories?.compactMap { $0.name }.first ?? ""
		return VenueViewModel(id: id,
							  name: name,
							  address: address,
							  distance: distance,
							  category: category)
	}
}
