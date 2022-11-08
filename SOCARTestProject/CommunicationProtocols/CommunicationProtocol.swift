//
//  CommunicationProtocol.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import Foundation

protocol fetchDataCommunicationProtocol: NSObject {
	func notifyZoneDataProvided(_ zones: [ZoneAnnotation])
}
