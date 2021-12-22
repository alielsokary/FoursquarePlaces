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
	weak var delegate: VenuesViewModelDelegate?

	var venues: [VenueViewModel] = []

	var numberOfVenues: Int {
		return venues.count
	}

	init(service: VenuesService = VenuesServiceImpl()) {
		self.service = service
	}

	func search(location: String = "") {
		service.search(location: location) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(venues):
				if let venues = venues.results?.compactMap({ VenueViewModel(venue: $0) }) {
					self.venues = venues
				}
				self.delegate?.viewModelDidLoadVenues()
			case let .failure(error):
				self.delegate?.viewModel(self, failedToLoadImagesWithError: error)
			}
		}
	}
}
