//
//  CoreDataManager.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
	static let sharedManager = CoreDataManager()
	private var managedContext: NSManagedObjectContext
	let appDelegate = UIApplication.shared.delegate as! AppDelegate
	private init() {
		managedContext = appDelegate.persistentContainer.viewContext
	}
	func enlistZones(zoneList: [Zone]) {
		if getAllZones().count == 0 {
			guard let zoneEntity = NSEntityDescription.entity(forEntityName: "ZoneEntity", in: managedContext) else { return }// creating reference from data model
			for zone in zoneList {
				let zoneContextObject = NSManagedObject(entity:zoneEntity, insertInto: managedContext) as! ZoneEntity
				zoneContextObject.name = zone.name
				zoneContextObject.latitude = zone.latitude
				zoneContextObject.longitude = zone.longitude
				zoneContextObject.alias = zone.alias
				zoneContextObject.favorite = zone.favorite
			}
			DispatchQueue.main.async {
				self.appDelegate.saveContext()
			}
		}
	}
	func getDesignatedZone(title: String) -> Zone {
		var zone: Zone?
		let fetchZoneRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
		fetchZoneRequest.predicate = NSPredicate(format: "title = %@", title)
		do {
			let zoneEntity = try managedContext.fetch(fetchZoneRequest)
			if !zoneEntity.isEmpty {
				zone = Zone(zoneEntity.first!)
			} else {
				zone = Zone()
			}
			return zone!
		} catch {
			print(error)
			return Zone()
		}
	}
	func getAllZones() -> [Zone] {
		var zones: [Zone] = []
		let fetchZonesRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
		do {
			let zoneEntities = try managedContext.fetch(fetchZonesRequest)
			for zone in zoneEntities {
				zones.append(Zone(zone))
			}
		} catch {
			print(error)
		}
		return zones
	}
	func getFavoriteZones() -> [Zone] {
		var zones: [Zone] = []
		let fetchZonesRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
		fetchZonesRequest.predicate = NSPredicate(format: "favorite = true", [])
		do {
			let zoneEntities = try managedContext.fetch(fetchZonesRequest)
			for zone in zoneEntities {
				zones.append(Zone(zone))
			}
		} catch {
			print(error)
		}
		return zones
	}
	func enlistCarsForZone(carList: [Car], zone: String) {
		var designatedZone: ZoneEntity?
		guard let zoneEntity = NSEntityDescription.entity(forEntityName: "ZoneEntity", in: managedContext) else { return }
		
		
		// getting the zone to be linked with
		let fetchZoneRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
		
		// for now, title is being used as primary key
		fetchZoneRequest.predicate = NSPredicate(format: "title = %@", zone)
		do {
			let designatedZoneEntity = try managedContext.fetch(fetchZoneRequest)
			designatedZone = designatedZoneEntity.first!
		} catch {
			print(error)
		}
		guard let carEntity = NSEntityDescription.entity(forEntityName: "CarEntity", in: managedContext) else { return }
		for car in carList {
			let carContextObject = NSManagedObject(entity:carEntity, insertInto: managedContext) as! CarEntity
			carContextObject.designatedZone = designatedZone // linking car - zone
			carContextObject.name = car.name
			carContextObject.image_name = car.imageUrl
			carContextObject.desc = car.description
			switch car.category {
			case .electric:
				carContextObject.type = "electric"
			default:
				carContextObject.type = "small_suv"
			}
			carContextObject.id = Int64(car.id!)
		}
		DispatchQueue.main.async {
			self.appDelegate.saveContext()
		}
	}
	func getAllCarsForZone(zone: String) -> [Car] {
		var cars: [Car] = []
		var designatedZone: ZoneEntity?
		let fetchCarsRequest = NSFetchRequest<CarEntity>(entityName: "CarEntity")
		
		// getting the zone to be linked with
		let fetchZoneRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")

		// for now, title is being used as primary key
		fetchZoneRequest.predicate = NSPredicate(format: "title = %@", zone)
		do {
		   let designatedZoneEntity = try managedContext.fetch(fetchZoneRequest)
		   designatedZone = designatedZoneEntity.first!
		} catch {
		   print(error)
		}
		let availableCarEntities = designatedZone?.availableCars?.allObjects as! [CarEntity]
		for car in availableCarEntities {
			cars.append(Car(car))
		}
		return cars
	}
}
