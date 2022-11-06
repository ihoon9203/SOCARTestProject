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
	
	var socarZones: [Zone] = [
		Zone(longitude: -111.872654, latitude: 40.766170, favorite: true, name: "place 1", alias: "good place"),
		Zone(longitude: -111.864161, latitude: 40.757946, favorite: true, name: "place 1", alias: "good place")
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		map.delegate = self
		// map configuration
		CoreLocationManager.sharedLocationManager.requestAlwaysAuthorization()
		CoreLocationManager.sharedLocationManager.requestWhenInUseAuthorization()
		CoreLocationManager.sharedLocationManager.distanceFilter = 100
		map.userTrackingMode = .follow
		
		// initializing zones
		
		socarZones.map {
			let location = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
			let socarAnnotation = MKPointAnnotation()
			socarAnnotation.coordinate = location
			socarAnnotation.title = "socar_zone"
			map.addAnnotation(socarAnnotation)
			if (map.visibleMapRect.contains(MKMapPoint(socarAnnotation.coordinate))) {
				map.addAnnotation(socarAnnotation)
			}
			map.register(ZoneAnnotationView.self, forAnnotationViewWithReuseIdentifier: "socar")
		}
		// Do any additional setup after loading the view.
	}
	

}
extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		switch annotation.title {
		case "socar_zone":
			let view = mapView.dequeueReusableAnnotationView(withIdentifier: "socar")
			view?.image = UIImage(named: "img_zone_shadow")
			view?.annotation = annotation
			return view
		default:
			let view = mapView.dequeueReusableAnnotationView(withIdentifier: "")
			return view
		}
	}
	func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
		print(annotation.coordinate)
	}
}
