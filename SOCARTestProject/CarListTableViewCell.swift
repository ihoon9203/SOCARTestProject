//
//  CarListTableViewCell.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import UIKit

class CarListTableViewCell: UITableViewCell {
	var title: String?
	var carDescription: String?
	var imageName: String?
    override func awakeFromNib() {
		loadViewFromNib()
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func loadViewFromNib() {
		if let nib = Bundle.main.loadNibNamed("AvailableCarTVCell", owner: self),
			let nibView = nib.first as? CarListTableCellView {
			if let carImageName = imageName {
				if let carImage = UIImage(named: carImageName) {
					nibView.carImage.image = carImage
				}
			}
			nibView.carTitle.text = title
			nibView.carDescription.text = carDescription
			DispatchQueue.global().async {
				if let imageName = self.imageName {
					if let imageURL = URL(string: imageName) {
						if let data = try? Data(contentsOf: imageURL) {
							DispatchQueue.main.async {
								nibView.carImage.image = UIImage(data: data)
							}
						}
					}
				}
			}
			
			addSubview(nibView)
		}
	}
}
