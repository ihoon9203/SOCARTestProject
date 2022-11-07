//
//  DataProvider.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation

class DataProvider {
	let zonesDataParser = ZonesDataParser()
	let carsDataParser = CarsDataParser()
	weak var zoneDelegate: ZoneCommunicationProtocol?
	weak var carDelegate: CarCommunicationProtocol?
	func getZones() {
		if let url = URL(string: Constants.zoneURL) {
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			
			zonesDataParser.parseRequestToZones(request: request) { zones in
				self.zoneDelegate?.notifyZoneDataProvided(zones)
			} onFailure: { error in
				print(error)
			}

		}
	}
	func getCars() {
		if let url = URL(string: Constants.carURL) {
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			
			carsDataParser.parseRequestToCars(request: request) { cars in
				self.carDelegate?.notifyCarDataProvided(cars)
			} onFailure: { error in
				print(error)
			}
		}
	}
}
