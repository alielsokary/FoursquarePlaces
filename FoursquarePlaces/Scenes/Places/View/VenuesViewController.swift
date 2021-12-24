//
//  VenuesViewController.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 21/12/2021.
//  
//

import UIKit

class VenuesViewController: UIViewController {

	@IBOutlet private weak var tableView: UITableView!

	private let cellIdentifier = "VenueTableViewCell"

	let viewModel = VenueListViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.delegate = self
		setupUI()
		setupTableView()
		viewModel.search(location: "")
	}

}

// MARK: - Setup UI

private extension VenuesViewController {

	func setupUI() {
		self.title = "Venues"
		navigationController?.navigationBar.prefersLargeTitles = true
		tableView.separatorStyle = .none
		tableView.backgroundColor = .clear
		tableView.tableFooterView = UIView()
	}

	func setupTableView() {
		tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
		tableView.dataSource = self
		tableView.delegate = self
	}
}

// MARK: - UITableViewDataSource

extension VenuesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfVenues
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
									 for: indexPath) as? VenueTableViewCell else { return UITableViewCell() }
		cell.viewModel = viewModel.venues[indexPath.row]
		return cell
	}
}

// MARK: - UITableViewDelegate

extension VenuesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}

	func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return false
	}
}

// MARK: - VenuesViewModelDelegate

extension VenuesViewController: VenuesViewModelDelegate {
	func viewModelDidLoadVenues() {
		tableView.reloadData()
	}

	func viewModel(_ viewModel: VenueListViewModel, failedToLoadImagesWithError error: NetworkError) {
		let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}

}
