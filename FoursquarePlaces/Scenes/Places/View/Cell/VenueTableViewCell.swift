//
//  VenueTableViewCell.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import UIKit

class VenueTableViewCell: UITableViewCell {

	@IBOutlet private weak var lblName: UILabel!
	@IBOutlet private weak var lblAddress: UILabel!
	@IBOutlet private weak var lblDistance: UILabel!
	@IBOutlet private weak var lblCategory: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
		self.selectionStyle = .none
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
		lblAddress.text = viewModel.address
		lblDistance.text = "\(viewModel.distance)"
		lblCategory.text = viewModel.category
	}
}
