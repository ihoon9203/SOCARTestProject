//
//  DataProvider.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
import CoreLocation

class DataProvider {
	let zonesDataParser = ZonesDataParser()
	let carsDataParser = CarsDataParser()
	weak var zoneDelegate: fetchDataCommunicationProtocol?
	
	var zonesDictionary = Dictionary<String, [Car]>() // zone id : car id's
	var annotations: [ZoneAnnotation] = []
	
	func getZones() {
		if let url = URL(string: Constants.zoneURL) {
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			
			zonesDataParser.parseRequestToZones(request: request) { zones in
				CoreDataManager.sharedManager.enlistZones(zoneList: zones)
				// once zone data are fetched, get cars data
				self.getCars()
				for zone in zones {
					// if any case zone id doesn't exist set -1 as its id
					self.zonesDictionary[zone.id ?? "-1"] = []
				}
				for zone in zones {
					let location = CLLocationCoordinate2D(latitude: zone.location?.lat ?? Double.greatestFiniteMagnitude, longitude: zone.location?.lng ?? Double.greatestFiniteMagnitude)
					let socarAnnotation = ZoneAnnotation()
					socarAnnotation.coordinate = location
					socarAnnotation.title = "socar_zone" // labeling zone
					socarAnnotation.zoneID = zone.id
					self.annotations.append(socarAnnotation)
				}
				// notify to annotate the map
				self.zoneDelegate?.notifyZoneDataProvided(self.annotations)
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
				for car in cars {
					if let zones = car.zones {
						for zone in zones {
							self.zonesDictionary[zone]?.append(car)
						}
					}
				}
				for zone in self.zonesDictionary.keys {
					let carsForZone = self.zonesDictionary[zone] ?? []
					CoreDataManager.sharedManager.enlistCarsForZone(carList: carsForZone, id: zone)
				}
			} onFailure: { error in
				print(error)
			}
		}
	}
}
