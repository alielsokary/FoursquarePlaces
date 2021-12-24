//
//  FontManager.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 24/12/2021.
//  
//

import Foundation
import UIKit

enum Font: String {
	case regular = "Roboto-Regular"
	case medium = "Roboto-Medium"
	case bold = "Roboto-Bold"

	var name: String {
		return self.rawValue
	}
}

struct FontDescription {
	let font: Font
	let size: CGFloat
	let style: UIFont.TextStyle
}

enum TextStyle {
	case display1
	case display2
	case display3
	case display4
}

extension TextStyle {
	private var fontDescription: FontDescription {
		switch self {
		case .display1:
			return FontDescription(font: .bold, size: 25, style: .headline)
		case .display2:
			return FontDescription(font: .medium, size: 20, style: .subheadline)
		case .display3:
			return FontDescription(font: .regular, size: 15, style: .title1)
		case .display4:
			return FontDescription(font: .regular, size: 15, style: .title2)
		}
	}
}

extension TextStyle {
	var font: UIFont {
		guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
			return UIFont.preferredFont(forTextStyle: fontDescription.style)
		}

		let fontMetrics = UIFontMetrics(forTextStyle: fontDescription.style)
		return fontMetrics.scaledFont(for: font)
	}
}
