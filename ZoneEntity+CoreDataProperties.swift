//
//  ZoneEntity+CoreDataProperties.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//
//

import Foundation
import CoreData


extension ZoneEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ZoneEntity> {
        return NSFetchRequest<ZoneEntity>(entityName: "ZoneEntity")
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var title: String?
    @NSManaged public var alias: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var availableCars: NSSet?

}

// MARK: Generated accessors for availableCars
extension ZoneEntity {

    @objc(addAvailableCarsObject:)
    @NSManaged public func addToAvailableCars(_ value: CarEntity)

    @objc(removeAvailableCarsObject:)
    @NSManaged public func removeFromAvailableCars(_ value: CarEntity)

    @objc(addAvailableCars:)
    @NSManaged public func addToAvailableCars(_ values: NSSet)

    @objc(removeAvailableCars:)
    @NSManaged public func removeFromAvailableCars(_ values: NSSet)

}

extension ZoneEntity : Identifiable {

}
