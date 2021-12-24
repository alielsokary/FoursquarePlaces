//
//  VenueTableViewCell.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import UIKit

class VenueTableViewCell: UITableViewCell {

	@IBOutlet private weak var viewBackground: UIView!
	@IBOutlet private weak var lblName: FPBoldLabel!
	@IBOutlet private weak var lblAddress: FPMediumLabel!
	@IBOutlet private weak var lblDistance: FPMediumLabel!
	@IBOutlet private weak var lblCategory: FPRegularLabel!

	override func awakeFromNib() {
        super.awakeFromNib()
		self.selectionStyle = .none
		setupUI()
    }

	var viewModel: VenueViewModel! {
		didSet {
			self.setup()
		}
	}

}

private extension VenueTableViewCell {
	func setup() {
		lblName.text = viewModel.name
		lblAddress.text = "Address: " + viewModel.address
		lblDistance.text = "Distance: \(viewModel.distance)"
		lblCategory.text = "Category: " + viewModel.category
	}

	func setupUI() {
		viewBackground.layer.cornerRadius = 5
		viewBackground.layer.shadowColor = UIColor.gray.cgColor
		viewBackground.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
		viewBackground.layer.shadowRadius = 2.0
		viewBackground.layer.shadowOpacity = 0.3

		lblAddress.textColor = UIColor(named: "subtitles")
		lblDistance.textColor = UIColor(named: "subtitles")
		lblCategory.textColor = UIColor(named: "subtitles")
	}
}
