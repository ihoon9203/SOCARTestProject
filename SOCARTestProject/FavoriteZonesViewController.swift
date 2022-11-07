//
//  FavoriteZonesViewController.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/4/22.
//

import UIKit

class FavoriteZonesViewController: UIViewController {

	@IBAction func popToPrevious(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
	@IBOutlet weak var leftBarButton: UIBarButtonItem!
	var favoriteZones: [Zone] = []
	override func viewDidLoad() {
        super.viewDidLoad()
		favoriteZones = CoreDataManager.sharedManager.getFavoriteZones()
    }

}
extension FavoriteZonesViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favoriteZones.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteZone") as! FavoriteZoneTableViewCell
		cell.titleLabel.text = favoriteZones[indexPath.row].title
		cell.aliasLabel.text = favoriteZones[indexPath.row].alias
		cell.longitude = favoriteZones[indexPath.row].longitude
		cell.latitude = favoriteZones[indexPath.row].latitude
		return cell
	}
	
	
}
