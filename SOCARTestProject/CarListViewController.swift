//
//  CarListViewController.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/4/22.
//

import UIKit

class CarListViewController: UIViewController {
	var availableCars: [Car] = []
	var availableElectricCars: [Car] = []
	var availableSmallSUVCars: [Car] = []
	var currentLocation: String?
	@IBOutlet weak var location: UILabel!
	@IBOutlet weak var locationAlias: UILabel!
	@IBOutlet weak var favoriteImage: UIImageView!
	override func viewDidLoad() {
        super.viewDidLoad()
		let currentZone = CoreDataManager.sharedManager.getDesignatedZone(title: currentLocation ?? "location not registered")
		location.text = currentZone.title
		locationAlias.text = currentZone.alias
		favoriteImage.image = currentZone.favorite ? UIImage(named: "_ic24_favorite_blue") : UIImage(named: "_ic24_favorite_gray")
		availableCars = CoreDataManager.sharedManager.getAllCarsForZone(zone: currentLocation ?? "location not registered")
		for car in availableCars {
			if car.type == .electric {
				availableElectricCars.append(car)
			} else {
				availableSmallSUVCars.append(car)
			}
		}
    }

}
extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return availableElectricCars.count
		default:
			return availableSmallSUVCars.count
		}
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(129)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableCar") as! CarListTableViewCell
		switch indexPath.section {
		case 0:
			cell.title = availableElectricCars[indexPath.row].name
			cell.carDescription = availableElectricCars[indexPath.row].carDescription
			cell.imageName = availableElectricCars[indexPath.row].imageName
			
		default:
			cell.title = availableSmallSUVCars[indexPath.row].name
			cell.carDescription = availableSmallSUVCars[indexPath.row].carDescription
			cell.imageName = availableSmallSUVCars[indexPath.row].imageName
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
			case 0:
				nibView.carType.text = "전기"
			default:
				nibView.carType.text = "소형 SUV"
			}
			return nibView
		}
		return view
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
}
