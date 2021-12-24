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
	func viewModel(_ viewModel: VenueListViewModel, failedToLoadImagesWithError error: NetworkError)
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

		let storedVeues = storageService.fetch()
		self.venues = storedVeues
	}

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

	func search(location: String = "") {
		service.search(location: location) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(venues):
				if let venues = venues.results?.compactMap({ self.mapVenue(venue: $0) }) {
					self.venues = venues
				}
				self.storageService.clear()
				self.storageService.save(venues: self.venues)
				self.delegate?.viewModelDidLoadVenues()
			case let .failure(error):
				self.delegate?.viewModel(self, failedToLoadImagesWithError: error)
			}
		}
	}
}
