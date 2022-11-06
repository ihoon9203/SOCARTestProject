//
//  CarEntity+CoreDataProperties.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//
//

import Foundation
import CoreData


extension CarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var image_name: String?
    @NSManaged public var designatedZone: ZoneEntity?

}

extension CarEntity : Identifiable {

}
