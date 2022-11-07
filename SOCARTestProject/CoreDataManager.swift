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
				zoneContextObject.latitude = zone.location?.lat ?? Double.greatestFiniteMagnitude
				zoneContextObject.longitude = zone.location?.lng ?? Double.greatestFiniteMagnitude
				zoneContextObject.alias = zone.alias
				zoneContextObject.id = zone.id
				zoneContextObject.favorite = false
			}
			DispatchQueue.main.async {
				self.appDelegate.saveContext()
			}
		}
	}
	func getDesignatedZone(id: String) -> ZoneEntity? {
		var zone: ZoneEntity?
		let fetchZoneRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
		fetchZoneRequest.predicate = NSPredicate(format: "id = %@", id)
		do {
			let zoneEntity = try managedContext.fetch(fetchZoneRequest)
			if !zoneEntity.isEmpty {
				zone = zoneEntity.first!
			} else {
				return nil
			}
			return zone!
		} catch {
			print(error)
			return nil
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
	func toggleFavoriteZones(zone: String) {
		let fetchZonesRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
		fetchZonesRequest.predicate = NSPredicate(format: "id = %@", zone)
		do {
			if let zoneEntity = try managedContext.fetch(fetchZonesRequest).first {
				if zoneEntity.favorite {
					zoneEntity.favorite = false
				} else {
					zoneEntity.favorite = true
				}
			}
		} catch {
			print(error)
		}
		DispatchQueue.main.async {
			self.appDelegate.saveContext()
		}
	}
	func enlistCarsForZone(carList: [Car], zone: String) {
		var designatedZone: ZoneEntity?
		
		
		// getting the zone to be linked with
		let fetchZoneRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
		
		fetchZoneRequest.predicate = NSPredicate(format: "id = %@", zone)
		do {
			let designatedZoneEntity = try managedContext.fetch(fetchZoneRequest)
			designatedZone = designatedZoneEntity.first!
		} catch {
			print(error)
		}
		guard let carEntity = NSEntityDescription.entity(forEntityName: "CarEntity", in: managedContext) else { return }
		for car in carList {
			let fetchCarRequest = NSFetchRequest<CarEntity>(entityName: "ZoneEntity")
			// for now, title is being used as primary key
			fetchCarRequest.predicate = NSPredicate(format: "id = %@", car.id!)
			let carContextObject = NSManagedObject(entity:carEntity, insertInto: managedContext) as! CarEntity
			carContextObject.designatedZone = designatedZone // linking car - zone
			carContextObject.name = car.name
			carContextObject.image_name = car.imageUrl
			carContextObject.desc = car.description
			carContextObject.type = car.category
			carContextObject.id = car.id
			carContextObject.designatedZone = designatedZone
		}
		DispatchQueue.main.async {
			self.appDelegate.saveContext()
		}
	}
	func getAllCarsForZone(id: String) -> [Car] {
		var cars: [Car] = []
		var designatedZone: ZoneEntity?
		
		// getting the zone to be linked with
		let fetchZoneRequest = NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")

		// for now, title is being used as primary key
		fetchZoneRequest.predicate = NSPredicate(format: "id = %@", id)
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
