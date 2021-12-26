//
//  HomeViewController.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 25/12/2021.
//  
//

import UIKit

final class HomeViewController: UIViewController {

	@IBOutlet private weak var segmentedControl: UISegmentedControl!
	@IBOutlet private weak var viewContent: UIView!

	private enum ViewControllerIndex: Int {
		case venuesViewController = 0
		case aboutViewController = 1
	}

	private var currentViewController: UIViewController?

	private lazy var venuesViewController: UIViewController? = {
		let venuesViewController = self.storyboard?.instantiateViewController(withIdentifier: "VenuesViewController")
		return venuesViewController
	}()

	private lazy var aboutViewController: UIViewController? = {
		let aboutViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController")
		return aboutViewController
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		if let currentViewController = currentViewController {
			currentViewController.viewWillDisappear(animated)
		}
	}

}

// MARK: - Actions

private extension HomeViewController {
	@IBAction func switchTabs(_ sender: UISegmentedControl) {
		self.currentViewController!.view.removeFromSuperview()
		self.currentViewController!.removeFromParent()

		displayCurrentTab(sender.selectedSegmentIndex)
	}
}

// MARK: - SetupUI

private extension HomeViewController {
	func setupUI() {
		segmentedControl.setTitle("Venues", forSegmentAt: 0)
		segmentedControl.setTitle("About", forSegmentAt: 1)
		segmentedControl.selectedSegmentIndex = ViewControllerIndex.venuesViewController.rawValue
		displayCurrentTab(ViewControllerIndex.venuesViewController.rawValue)
		setNavigationTitle()
	}

	func setNavigationTitle(_ index: Int = 0) {
		switch index {
		case ViewControllerIndex.venuesViewController.rawValue:
			self.title = "Venues"
		case ViewControllerIndex.aboutViewController.rawValue:
			self.title = "About"
		default:
			self.title = "Venues"
		}
	}
}

// MARK: - Configurations

private extension HomeViewController {
	func displayCurrentTab(_ index: Int) {
		if let viewController = viewControllerForSelectedSegmentIndex(index) {
			self.addChild(viewController)
			viewController.didMove(toParent: self)

			viewController.view.frame = self.viewContent.bounds
			self.viewContent.addSubview(viewController.view)
			self.currentViewController = viewController
		}
		setNavigationTitle(index)
	}

	func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
		var viewController: UIViewController?
		switch index {
		case ViewControllerIndex.venuesViewController.rawValue :
			viewController = venuesViewController
		case ViewControllerIndex.aboutViewController.rawValue :
			viewController = aboutViewController
		default:
			return nil
		}
		return viewController
	}
}
