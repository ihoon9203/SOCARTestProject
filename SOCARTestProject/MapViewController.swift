//
//  ViewController.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/4/22.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

	@IBOutlet weak var favoriteZoneButton: UIButton!
	@IBOutlet weak var map: MKMapView!
	override func viewDidLoad() {
		super.viewDidLoad()
		map.delegate = self
		CoreLocationManager.sharedLocationManager.requestAlwaysAuthorization()
		CoreLocationManager.sharedLocationManager.requestWhenInUseAuthorization()
		CoreLocationManager.sharedLocationManager.distanceFilter = 100
		map.userTrackingMode = .follow
		// Do any additional setup after loading the view.
	}
	

}
extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
//	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//		<#code#>
//	}
}
