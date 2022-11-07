//
//  FavoriteZonesViewController.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/4/22.
//

import UIKit

class FavoriteZonesViewController: UIViewController {

	@IBOutlet weak var favoritesTable: UITableView!
	@IBOutlet weak var exitBarButton: UIBarButtonItem!
	@IBAction func popToPrevious(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	var favoriteZones: [Zone] = []
	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.hidesBackButton = true
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		favoriteZones = CoreDataManager.sharedManager.getFavoriteZones()
		favoritesTable.reloadData()
	}

}
extension FavoriteZonesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favoriteZones.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteZone") as! FavoriteZoneTableViewCell
		cell.titleLabel.text = favoriteZones[indexPath.row].name
		cell.aliasLabel.text = favoriteZones[indexPath.row].alias
		cell.longitude = favoriteZones[indexPath.row].location?.lat
		cell.latitude = favoriteZones[indexPath.row].location?.lng
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let carListVC = storyboard?.instantiateViewController(withIdentifier: "CarListVC") as! CarListViewController
		carListVC.zoneID = favoriteZones[indexPath.row].id
		self.navigationController?.pushViewController(carListVC, animated: true)
	}
	
	
}
