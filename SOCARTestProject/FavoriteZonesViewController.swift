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
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
