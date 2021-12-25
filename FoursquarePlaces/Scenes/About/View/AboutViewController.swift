//
//  AboutViewController.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 25/12/2021.
//  
//

import UIKit

class AboutViewController: UIViewController {

	@IBOutlet private weak var lblAboutInfo: FPRegularLabel!

	private let viewModel = AboutViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }

}

// MARK: - SetupUI

private extension AboutViewController {
	func setupUI() {
		lblAboutInfo.textColor = UIColor(named: "subtitles")
		lblAboutInfo.text = viewModel.aboutInfo
	}
}
