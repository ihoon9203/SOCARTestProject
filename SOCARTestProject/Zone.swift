//
//  Zone.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
import MapKit

struct Zone: Codable {
	var location: Location?
	var id: String?
	var name: String?
	var alias: String?
	init(_ entity: ZoneEntity) {
		self.name = entity.name
		self.alias = entity.alias
		self.location = Location(lat: entity.latitude, lng: entity.longitude)
		self.id = entity.id
	}
	init(longitude: Double, latitude: Double, favorite: Bool, title: String, alias: String) {
		self.name = title
		self.alias = alias
		self.location = Location(lat: latitude, lng: longitude)
	}
	// empty zone
	init() {
		self.location = Location(lat: Double.greatestFiniteMagnitude, lng: Double.greatestFiniteMagnitude)
		self.name = "bad request"
		self.alias = "bad request"
	}
}
struct Location: Codable {
	var lat: Double?
	var lng: Double?
}
class ZoneAnnotationView: MKAnnotationView {
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
class ZoneAnnotation: NSObject, MKAnnotation {
	var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
	var title: String?
	var zoneID: String?
}
