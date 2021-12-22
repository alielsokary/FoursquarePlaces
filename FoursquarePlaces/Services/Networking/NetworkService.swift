//
//  NetworkService.swift
//  FoursquarePlaces
//
//  Created by Ali Elsokary on 22/12/2021.
//  
//

import Foundation

protocol NetworkServiceProtocol {
	func fetchRequest<T: Decodable>(forEndpoint endpoint: FoursquareRouter, completion: @escaping(Swift.Result<T, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

	private let session: URLSession

	init(session: URLSession = URLSession.shared) {
		self.session = session
	}

	func fetchRequest<T: Decodable>(forEndpoint endpoint: FoursquareRouter, completion: @escaping (Swift.Result<T, NetworkError>) -> Void) {

		guard let request = try? endpoint.asURLRequest() else { return }

		session.dataTask(with: request) { (data, response, _) in

			DispatchQueue.main.async { [weak self] in
				if let httpResponse = response as? HTTPURLResponse,
				   !(200 ... 299).contains(httpResponse.statusCode) {
					completion(.failure(self?.handleError(forCode: httpResponse.statusCode) ?? .unknownError))
				}

				guard let data = data else {
					completion(.failure(.unknownError))
					return
				}

				do {
					let response = try JSONDecoder().decode(T.self, from: data)
					completion(.success(response))
				} catch {
					completion(.failure(.unknownError))
				}
			}
		}.resume()
	}

	private func handleError(forCode errorCode: Int) -> NetworkError {
		switch errorCode {
		case 400:
			return .badRequest
		case 404:
			return .requestNotFound
		case 408:
			return .requestTimeout
		case 500:
			return .internalServerError
		case 504:
			return .gatewatTimeout
		default:
			return .unknownError
		}
	}
}
