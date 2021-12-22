//
//  ViewController.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 21/12/2021.
//  
//

import UIKit

class ViewController: UIViewController {

	let service = VenuesServiceImpl()

	override func viewDidLoad() {
		super.viewDidLoad()
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
