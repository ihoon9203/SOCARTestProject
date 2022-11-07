//
//  CommunicationProtocol.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation

protocol ZoneCommunicationProtocol: NSObject {
	func notifyZoneDataProvided(_ zone: [Zone])
}
protocol CarCommunicationProtocol: NSObject {
	func notifyCarDataProvided(_ cars: [Car])
}
