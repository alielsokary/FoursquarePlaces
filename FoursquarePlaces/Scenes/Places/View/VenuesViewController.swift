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

	let service = VenuesServiceImpl()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
		service.search(location: "") { result in
			switch result {
			case let .success(places):
				print(places)
			case let .failure(error):
				print(error)
			}
		}
	}

}

// MARK: - Setup UI

private extension VenuesViewController {
	func setupTableView() {
		tableView.tableFooterView = UIView()
		tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
	}
}

// MARK: - UITableViewDataSource

extension VenuesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VenueTableViewCell
		return cell
	}
}

// MARK: - UITableViewDelegate

extension VenuesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return view.frame.width
	}

	func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return false
	}
}
