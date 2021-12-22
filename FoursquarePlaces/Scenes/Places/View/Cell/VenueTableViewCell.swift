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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
