//
//  Zone.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
import MapKit

struct Zone {
	var longitude: Double
	var latitude: Double
	
	var favorite: Bool
	var title: String?
	var alias: String?
	init(_ entity: ZoneEntity) {
		self.title = entity.title
		self.alias = entity.alias
		self.favorite = entity.favorite
		self.latitude = entity.latitude
		self.longitude = entity.longitude
	}
	init(longitude: Double, latitude: Double, favorite: Bool, title: String, alias: String) {
		self.title = title
		self.alias = alias
		self.favorite = favorite
		self.latitude = latitude
		self.longitude = longitude
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
