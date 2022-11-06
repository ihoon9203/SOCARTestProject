//
//  Car.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
import UIKit

struct Car {
	var imageName: String?
	var name: String?
	var description: String?
	var type: CarType
	init(_ entity: CarEntity) {
		self.imageName = entity.image_name
		self.name = entity.name
		self.description = entity.description
		if entity.type == "electric" {
			type = .electric
		} else {
			type = .smallSUV
		}
	}
	init(imageName: String, name: String, description: String, type: CarType) {
		self.imageName = imageName
		self.name = name
		self.description = description
		self.type = type
	}
}
enum CarType {
	case electric, smallSUV
}
