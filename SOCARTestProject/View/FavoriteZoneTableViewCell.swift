//
//  FavoriteZoneTableViewCell.swift
//  SOCARTestProject
//
//  Created by Jeonghoon Oh on 11/6/22.
//

import UIKit

class FavoriteZoneTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var aliasLabel: UILabel!
	var latitude: Double?
	var longitude: Double?
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		
        // Configure the view for the selected state
    }
}
