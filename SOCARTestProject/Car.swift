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
	var carDescription: String?
	var type: CarType
	var number: Int?
	init(_ entity: CarEntity) {
		self.imageName = entity.image_name
		self.name = entity.name
		self.carDescription = entity.desc
		if entity.type == "electric" {
			type = .electric
		} else {
			type = .smallSUV
		}
		self.number = Int(entity.number)
	}
	init(imageName: String, name: String, description: String, type: CarType, number: Int) {
		self.imageName = imageName
		self.name = name
		self.carDescription = description
		self.type = type
		self.number = number
	}
}
enum CarType {
	case electric, smallSUV
}
