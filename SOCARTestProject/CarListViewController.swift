//
//  CarListViewController.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/4/22.
//

import UIKit

class CarListViewController: UIViewController {
	var availableCars: [Car] = []
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return availableCars.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(129)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableCar") as! CarListTableViewCell
		cell.title = availableCars[indexPath.row].name
		cell.carDescription = availableCars[indexPath.row].carDescription
		cell.imageName = availableCars[indexPath.row].imageName
		cell.awakeFromNib()
		return cell
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return CGFloat(56)
	}
	
}
