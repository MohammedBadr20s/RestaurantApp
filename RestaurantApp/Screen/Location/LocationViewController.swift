//
//  LocationViewController.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-11.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    var locationService: LocationService!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.didTapAllow = { [weak self] in
            self?.locationService?.requestLocationAuthorization()
        }
        // Do any additional setup after loading the view.
    }

}
