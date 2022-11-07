//
//  Zone.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
import MapKit

struct Zone: Codable {
	var longitude: Double
	var latitude: Double
	var id: Int
	var favorite: Bool
	var name: String?
	var alias: String?
	init(_ entity: ZoneEntity) {
		self.name = entity.name
		self.alias = entity.alias
		self.favorite = entity.favorite
		self.latitude = entity.latitude
		self.longitude = entity.longitude
	}
	init(longitude: Double, latitude: Double, favorite: Bool, title: String, alias: String) {
		self.name = title
		self.alias = alias
		self.favorite = favorite
		self.latitude = latitude
		self.longitude = longitude
	}
	// empty zone
	init() {
		self.longitude = Double.greatestFiniteMagnitude
		self.latitude = Double.greatestFiniteMagnitude
		self.favorite = false
		self.name = "bad request"
		self.alias = "bad request"
	}
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
	var annotationLabel: String?
	
	
}
