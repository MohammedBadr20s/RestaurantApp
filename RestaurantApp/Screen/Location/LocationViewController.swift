//
//  LocationViewController.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-11.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import UIKit


protocol LocationActions: class {
    func didTapAllow()
}
class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    weak var delegate: LocationActions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView.didTapAllow = {
            self.delegate?.didTapAllow()
        }
    }

}
