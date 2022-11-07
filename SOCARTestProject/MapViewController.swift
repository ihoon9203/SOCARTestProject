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
		map.setCameraZoomRange(MKMapView.CameraZoomRange(maxCenterCoordinateDistance: CLLocationDistance(20000)), animated: false)
		
		let status = CoreLocationManager.sharedLocationManager.authorizationStatus
		if status != .authorizedAlways && status != .authorizedWhenInUse {
			let defaultCenter = CLLocationCoordinate2D(latitude: 37.54330366639085, longitude: 127.04455548501139)
			map.setCenter(defaultCenter, animated: false)
		} else {
			map.userTrackingMode = .follow
		}
		
		createUserTrackingButton()
		createFavortieZoneButton()
		// setting up communication
		dataProvider.carDelegate = self
		dataProvider.zoneDelegate = self
		
		// populating data
		dataProvider.getZones() // once zones are populated it will request for cars
		
		// initializing annotations
		registeredZones = CoreDataManager.sharedManager.getAllZones()
		for zone in registeredZones {
			let location = CLLocationCoordinate2D(latitude: zone.location?.lat ?? Double.greatestFiniteMagnitude, longitude: zone.location?.lng ?? Double.greatestFiniteMagnitude)
			let socarAnnotation = ZoneAnnotation()
			socarAnnotation.coordinate = location
			socarAnnotation.title = "socar_zone"
			socarAnnotation.zoneID = zone.id
			map.addAnnotation(socarAnnotation)
			if (map.visibleMapRect.contains(MKMapPoint(socarAnnotation.coordinate))) {
				map.addAnnotation(socarAnnotation)
			}
			map.register(ZoneAnnotationView.self, forAnnotationViewWithReuseIdentifier: "socar")
		}
		// Do any additional setup after loading the view.
	}
	@objc func trackUserLocation() {
		var center = CLLocationCoordinate2D(latitude: 37.54330366639085, longitude: 127.04455548501139)
		let status = CoreLocationManager.sharedLocationManager.authorizationStatus
		if status != .authorizedAlways && status != .authorizedWhenInUse {
			map.setCenter(center, animated: true)
		} else {
			center = CoreLocationManager.sharedLocationManager.location!.coordinate
			map.setCenter(center, animated: true)
		}
	}
	@objc func pushFavoriteVC() {
		let favoriteZoneVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteZoneVC") as! FavoriteZonesViewController
		self.navigationController?.pushViewController(favoriteZoneVC, animated: true)
	}
	func createFavortieZoneButton() {
		let favoriteZoneButton = UIButton(type: .custom)
		favoriteZoneButton.layer.zPosition = 10
		favoriteZoneButton.frame = CGRect(x: 26, y: 104, width: 102, height: 35)
		favoriteZoneButton.layer.cornerRadius = 0.5 * favoriteZoneButton.bounds.size.height
		favoriteZoneButton.clipsToBounds = true
		
		favoriteZoneButton.backgroundColor = .white
		favoriteZoneButton.addTarget(self, action: #selector(pushFavoriteVC), for: .touchDown)
		
		favoriteZoneButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
		favoriteZoneButton.layer.shadowOpacity = 0.2
		favoriteZoneButton.layer.shadowRadius = 0.0
		favoriteZoneButton.layer.masksToBounds = false
		
		self.view.addSubview(favoriteZoneButton)
	}
	func createUserTrackingButton() {
		let trackUserButton = UIButton(type: .custom)
		trackUserButton.layer.zPosition = 10
		trackUserButton.frame = CGRect(x: 317, y: 729, width: 50, height: 50)
		trackUserButton.layer.cornerRadius = 0.5 * trackUserButton.bounds.size.width
		trackUserButton.clipsToBounds = true
		
		trackUserButton.backgroundColor = .white
		trackUserButton.setImage( UIImage(named: "ic24_my_location"), for: .normal)
		trackUserButton.addTarget(self, action: #selector(trackUserLocation), for: .touchDown)
		
		trackUserButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
		trackUserButton.layer.shadowOpacity = 0.2
		trackUserButton.layer.shadowRadius = 0.0
		trackUserButton.layer.masksToBounds = false
		
		self.view.addSubview(trackUserButton)
	}
}
extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if type(of: annotation) == ZoneAnnotation.self {
			let view = mapView.dequeueReusableAnnotationView(withIdentifier: "socar")
			view?.image = UIImage(named: "img_zone_shadow")
			view?.annotation = annotation
			return view
		} else if type(of: annotation) == MKUserLocation.self {
			let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
			view.image = UIImage(named: "img_current")
			return view
		} else {
			let view = mapView.dequeueReusableAnnotationView(withIdentifier: "")
			return view
		}
	}
	func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
		if type(of: annotation) != MKUserLocation.self {
			let annotation = annotation as! ZoneAnnotation
			let carListVC = storyboard?.instantiateViewController(withIdentifier: "CarListVC") as! CarListViewController
			carListVC.zoneID = annotation.zoneID!
			self.navigationController?.pushViewController(carListVC, animated: true)
		}
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
