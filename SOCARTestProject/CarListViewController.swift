//
//  CarListViewController.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/4/22.
//

import UIKit

class CarListViewController: UIViewController {
	var availableCars: 					[Car] = []
	var availableEVCars: 				[Car] = []
	var availableCOMPACTCars: 			[Car] = []
	var availableCOMPACT_SUVCars: 		[Car] = []
	var availableSEMI_MID_SUVCars: 		[Car] = []
	var availableSEMI_MID_SEDANCars: 	[Car] = []
	var availableMID_SUVCars: 			[Car] = []
	var availableMID_SEDANCars: 		[Car] = []
	var uncategorizedCars:				[Car] = []
	var zoneID: String!
	var isFavorite: Bool = false
	@IBOutlet weak var location: UILabel!
	@IBOutlet weak var locationAlias: UILabel!
	@IBOutlet weak var favoriteImage: UIImageView!

	@IBOutlet weak var backButtonItem: UIBarButtonItem!
	
	@IBAction func popToPreviousVC(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	@IBAction func didToggleFavorite(_ sender: Any) {
		CoreDataManager.sharedManager.toggleFavoriteZones(zone: zoneID)
		if isFavorite {
			isFavorite = false
			favoriteImage.image = UIImage(named: "_ic24_favorite_gray")
		} else {
			isFavorite = true
			favoriteImage.image = UIImage(named: "_ic24_favorite_blue")
		}
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		let currentZone = CoreDataManager.sharedManager.getDesignatedZone(id: zoneID)
		location.text = currentZone?.name
		locationAlias.text = currentZone?.alias
		if let favorite = currentZone?.favorite {
			if favorite {
				isFavorite = true
			}
		}
		favoriteImage.image = isFavorite ? UIImage(named: "_ic24_favorite_blue") : UIImage(named: "_ic24_favorite_gray")
		availableCars = CoreDataManager.sharedManager.getAllCarsForZone(id: zoneID)
		for car in availableCars {
			switch car.category {
			case "EV":
				availableEVCars.append(car)
			case "COMPACT":
				availableCOMPACTCars.append(car)
			case "COMPACT_SUV":
				availableCOMPACT_SUVCars.append(car)
			case "SEMI_MID_SUV":
				availableSEMI_MID_SUVCars.append(car)
			case "SEMI_MID_SEDAN":
				availableSEMI_MID_SEDANCars.append(car)
			case "MID_SUV":
				availableMID_SUVCars.append(car)
			case "MID_SEDAN":
				availableMID_SEDANCars.append(car)
			default:
				uncategorizedCars.append(car)
			}
		}
		favoriteImage.isUserInteractionEnabled = true
	}
	

}
extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0: // EV
			return availableEVCars.count
		case 1: // COMPACT
			return availableCOMPACTCars.count
		case 2: // COMPACT_SUV
			return availableCOMPACT_SUVCars.count
		case 3: // SEMI_MID_SUV
			return availableSEMI_MID_SUVCars.count
		case 4: // SEMI_MID_SEDAN
			return availableSEMI_MID_SEDANCars.count
		case 5: // MID_SUV
			return availableMID_SUVCars.count
		case 6: // MID_SEDAN
			return availableMID_SEDANCars.count
		default: // Uncategorized
			return uncategorizedCars.count
		}
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(129)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableCar") as! CarListTableViewCell
		switch indexPath.section {
		case 0: // EV
			cell.title = availableEVCars[indexPath.row].name
			cell.carDescription = availableEVCars[indexPath.row].description
			cell.imageName = availableEVCars[indexPath.row].imageUrl
		case 1: // COMPACT
			cell.title = availableCOMPACTCars[indexPath.row].name
			cell.carDescription = availableCOMPACTCars[indexPath.row].description
			cell.imageName = availableCOMPACTCars[indexPath.row].imageUrl
		case 2: // COMPACT_SUV
			cell.title = availableCOMPACT_SUVCars[indexPath.row].name
			cell.carDescription = availableCOMPACT_SUVCars[indexPath.row].description
			cell.imageName = availableCOMPACT_SUVCars[indexPath.row].imageUrl
		case 3: // SEMI_MID_SUV
			cell.title = availableSEMI_MID_SUVCars[indexPath.row].name
			cell.carDescription = availableSEMI_MID_SUVCars[indexPath.row].description
			cell.imageName = availableSEMI_MID_SUVCars[indexPath.row].imageUrl
		case 4: // SEMI_MID_SEDAN
			cell.title = availableSEMI_MID_SEDANCars[indexPath.row].name
			cell.carDescription = availableSEMI_MID_SEDANCars[indexPath.row].description
			cell.imageName = availableSEMI_MID_SEDANCars[indexPath.row].imageUrl
		case 5: // MID_SUV
			cell.title = availableMID_SUVCars[indexPath.row].name
			cell.carDescription = availableMID_SUVCars[indexPath.row].description
			cell.imageName = availableMID_SUVCars[indexPath.row].imageUrl
		case 6: // MID_SEDAN
			cell.title = availableMID_SEDANCars[indexPath.row].name
			cell.carDescription = availableMID_SEDANCars[indexPath.row].description
			cell.imageName = availableMID_SEDANCars[indexPath.row].imageUrl
		default:
			cell.title = uncategorizedCars[indexPath.row].name
			cell.carDescription = uncategorizedCars[indexPath.row].description
			cell.imageName = uncategorizedCars[indexPath.row].imageUrl
		}
		cell.awakeFromNib()
		return cell
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CGFloat(56)
	}
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		if let nib = Bundle.main.loadNibNamed("CarListHeaderView", owner: self),
			let nibView = nib.first as? CarListHeaderView {
			switch section {
			case 0: // EV
				nibView.carType.text = "전기"
			case 1: // COMPACT
				nibView.carType.text = "소형"
			case 2: // COMPACT_SUV
				nibView.carType.text = "소형 SUV"
			case 3: // SEMI_MID_SUV
				nibView.carType.text = "준중형 SUV"
			case 4: // SEMI_MID_SEDAN
				nibView.carType.text = "준중형 세단"
			case 5: // MID_SUV
				nibView.carType.text = "중형 SUV"
			case 6: // MID_SEDAN
				nibView.carType.text = "중형 세단"
			default: // Uncategorized
				nibView.carType.text = "기타"
			}
			return nibView
		}
		return view
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 8
	}
	
}
