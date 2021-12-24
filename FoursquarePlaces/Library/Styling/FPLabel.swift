//
//  FPLabel.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 24/12/2021.
//  
//

import UIKit

final class FPBoldLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.customizeLabel()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.customizeLabel()
	}

	private func customizeLabel() {
		self.font = TextStyle.display1.font
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.8
	}
}

final class FPMediumLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.customizeLabel()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.customizeLabel()
	}

	private func customizeLabel() {
		self.font = TextStyle.display2.font
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.8
	}
}

final class FPRegularLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.customizeLabel()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.customizeLabel()
	}

	private func customizeLabel() {
		self.font = TextStyle.display3.font
		self.adjustsFontSizeToFitWidth = true
		self.minimumScaleFactor = 0.5
	}
}
