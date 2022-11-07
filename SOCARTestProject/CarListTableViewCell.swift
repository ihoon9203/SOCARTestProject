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
			nibView.carImage.image = UIImage(named: imageName ?? "")
			nibView.carTitle.text = title
			nibView.carDescription.text = carDescription
			addSubview(nibView)
		}
	}
}
