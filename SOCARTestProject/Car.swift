//
//  Car.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation
import UIKit

struct Car: Codable {
	var imageUrl: String?
	var name: String?
	var description: String?
	var category: String?
	var id: Int?
	var zones: [Int]?
	init(_ entity: CarEntity) {
		self.imageUrl = entity.image_name
		self.name = entity.name
		self.description = entity.desc
		self.category = entity.type
		self.id = Int(entity.id)
	}
	init(imageName: String, name: String, description: String, type: String, number: Int) {
		self.imageUrl = imageName
		self.name = name
		self.description = description
		self.category = type
		self.id = number
	}
}
enum CarType {
	case electric, smallSUV
}
