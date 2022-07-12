//
//  LandingViewController.swift
//  Lab5_UsingGPS
//
//  Created by Sanjay Sekar Samuel on 2022-07-06.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var mapButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapButton.layer.cornerRadius = 10
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
