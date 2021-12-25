//
//  LocationManager.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 25/12/2021.
//  
//

import UIKit
import CoreLocation

final class LocationManager: NSObject {

	enum LocationErrors: String {
		case denied = "Locations are turned off. Please turn it on in Settings"
		case restricted = "Locations are restricted"
		case notDetermined = "Locations are not determined yet"
		case notFetched = "Unable to fetch location"
		case invalidLocation = "Invalid Location"
		case reverseGeocodingFailed = "Reverse Geocoding Failed"
		case unknown = "Some Unknown Error occurred"
	}

	typealias LocationClosure = ((_ location: CLLocation?, _ error: NSError?) -> Void)
	private var locationCompletionHandler: LocationClosure?

	private var locationManager: CLLocationManager?
	var locationAccuracy = kCLLocationAccuracyBest

	private var lastLocation: CLLocation?

	static let shared: LocationManager = {
		let instance = LocationManager()
		return instance
	}()

	private override init() {}

	deinit {
		destroyLocationManager()
	}

	private func setupLocationManager() {
		locationManager = nil
		locationManager = CLLocationManager()
		locationManager?.desiredAccuracy = locationAccuracy
		locationManager?.delegate = self
		locationManager?.requestWhenInUseAuthorization()
	}

	private func destroyLocationManager() {
		locationManager?.delegate = nil
		locationManager = nil
		lastLocation = nil
	}

	@objc private func sendLocation() {
		guard lastLocation != nil else {
			self.didComplete(location: nil, error: NSError(
				domain: self.classForCoder.description(),
				code: Int(CLAuthorizationStatus.denied.rawValue),
				userInfo:
					[NSLocalizedDescriptionKey: LocationErrors.notFetched.rawValue,
			  NSLocalizedFailureReasonErrorKey: LocationErrors.notFetched.rawValue,
		 NSLocalizedRecoverySuggestionErrorKey: LocationErrors.notFetched.rawValue]))
			lastLocation = nil
			return
		}
		self.didComplete(location: lastLocation, error: nil)
		lastLocation = nil
	}

	func isLocationEnabled() -> Bool {
		return CLLocationManager.locationServicesEnabled()
	}

	func getLocation(completionHandler: @escaping LocationClosure) {
		lastLocation = nil
		self.locationCompletionHandler = completionHandler
		setupLocationManager()
	}

	private func didComplete(location: CLLocation?, error: NSError?) {
		locationManager?.stopUpdatingLocation()
		locationCompletionHandler?(location, error)
		locationManager?.delegate = nil
		locationManager = nil
	}
}

// MARK: - CLLocationManager Delegates

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		lastLocation = locations.last
		if let location = locations.last {
			let locationAge = -(location.timestamp.timeIntervalSinceNow)
			if locationAge > 5.0 {
				print("old location \(location)")
				return
			}
			if location.horizontalAccuracy < 0 {
				self.locationManager?.stopUpdatingLocation()
				self.locationManager?.startUpdatingLocation()
				return
			}
			self.sendLocation()
		}
	}

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

		switch status {

		case .authorizedWhenInUse, .authorizedAlways:
			self.locationManager?.startUpdatingLocation()

		case .denied:
			let deniedError = NSError(
				domain: self.classForCoder.description(),
				code: Int(CLAuthorizationStatus.denied.rawValue),
				userInfo:
					[NSLocalizedDescriptionKey: LocationErrors.denied.rawValue,
			  NSLocalizedFailureReasonErrorKey: LocationErrors.denied.rawValue,
		 NSLocalizedRecoverySuggestionErrorKey: LocationErrors.denied.rawValue])

			didComplete(location: nil, error: deniedError)

		case .restricted:
			didComplete(location: nil, error: NSError(
				domain: self.classForCoder.description(),
				code: Int(CLAuthorizationStatus.restricted.rawValue),
				userInfo: nil))

		case .notDetermined:
			self.setupLocationManager()

		@unknown default:
			didComplete(location: nil, error: NSError(
				domain: self.classForCoder.description(),
				code: Int(CLAuthorizationStatus.denied.rawValue),
				userInfo:
					[NSLocalizedDescriptionKey: LocationErrors.unknown.rawValue,
			  NSLocalizedFailureReasonErrorKey: LocationErrors.unknown.rawValue,
		 NSLocalizedRecoverySuggestionErrorKey: LocationErrors.unknown.rawValue]))
		}
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error.localizedDescription)
		self.didComplete(location: nil, error: error as NSError?)
	}

}
