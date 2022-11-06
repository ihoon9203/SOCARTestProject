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
    @NSManaged public var availableCars: CarEntity?

}

extension ZoneEntity : Identifiable {

}
