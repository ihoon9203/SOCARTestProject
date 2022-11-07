//
//  CarsDataParser.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
class CarsDataParser {
	func parseRequestToCars(request: URLRequest, onSuccess: @escaping ([Car])->(), onFailure: @escaping (Error) -> ()) {
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			do {
				if let data = data {
					let carList = try JSONDecoder().decode(Car.self, from: data )
					onSuccess(carList.response)
				}
			} catch {
				print("1")
				onFailure(error)
			}
		}
		task.resume()
	}
}
