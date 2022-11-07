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
	
	var registeredZones: [Zone] = []
	var registeredCars: [Car] = []
	var zonesDictionary = Dictionary<String, [Car]>() // zone id : car id's
	let dataProvider = DataProvider()
	override func viewDidLoad() {
		super.viewDidLoad()
		map.delegate = self
		// map configuration
		CoreLocationManager.sharedLocationManager.requestAlwaysAuthorization()
		CoreLocationManager.sharedLocationManager.requestWhenInUseAuthorization()
		CoreLocationManager.sharedLocationManager.distanceFilter = 100
		map.userTrackingMode = .follow

		// initializing dummy data (comment if not needed)
		let socarZones: [Zone] = [
			Zone(longitude: -111.872654, latitude: 40.766170, favorite: true, title: "place 1", alias: "good place"),
			Zone(longitude: -111.864161, latitude: 40.757946, favorite: false, title: "place 2", alias: "better place")
		]
		// setting up communication
		dataProvider.carDelegate = self
		dataProvider.zoneDelegate = self
		
		// populating data
		dataProvider.getZones() // once zones are populated it will request for cars
		
		// initializing annotations
		registeredZones = CoreDataManager.sharedManager.getAllZones()
//		CoreDataManager.sharedManager.enlistCarsForZone(carList: socarCarsPlace1, zone: registeredZones[0].name!)
//		CoreDataManager.sharedManager.enlistCarsForZone(carList: socarCarsPlace2, zone: registeredZones[1].name!)
		for zone in registeredZones {
			let location = CLLocationCoordinate2D(latitude: zone.location?.lat ?? Double.greatestFiniteMagnitude, longitude: zone.location?.lng ?? Double.greatestFiniteMagnitude)
			let socarAnnotation = ZoneAnnotation()
			socarAnnotation.coordinate = location
			socarAnnotation.title = "socar_zone"
			socarAnnotation.annotationLabel = zone.name
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
		let annotation = annotation as! ZoneAnnotation
		let carListVC = storyboard?.instantiateViewController(withIdentifier: "CarListVC") as! CarListViewController
		carListVC.currentLocation = annotation.annotationLabel!
		self.navigationController?.pushViewController(carListVC, animated: true)
	}
}
extension MapViewController: ZoneCommunicationProtocol, CarCommunicationProtocol {
	func notifyZoneDataProvided(_ zones: [Zone]) {
		registeredZones = zones
		CoreDataManager.sharedManager.enlistZones(zoneList: registeredZones)
		for zone in zones {
			zonesDictionary[zone.id ?? "-1"] = []
		}
		dataProvider.getCars()
	}
	
	func notifyCarDataProvided(_ cars: [Car]) {
		registeredCars = cars
		for car in cars {
			if let zones = car.zones {
				for zone in zones {
					zonesDictionary[zone]?.append(car)
				}
			}
		}
		for zone in zonesDictionary.keys {
			let carsForZone = zonesDictionary[zone] ?? []
			CoreDataManager.sharedManager.enlistCarsForZone(carList: carsForZone, zone: zone)
		}
	}
}
