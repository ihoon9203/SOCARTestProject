//
//  ZonesDataParser.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation

class ZonesDataParser {
	func parseRequestToZones(request: URLRequest, onSuccess: @escaping ([Zone])->(), onFailure: @escaping (Error) -> ()) {
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			do {
				if let data = data {
					let zoneList = try JSONDecoder().decode([Zone].self, from: data )
					onSuccess(zoneList)
				}
			} catch {
				onFailure(error)
			}
		}
		task.resume()
	}
}
