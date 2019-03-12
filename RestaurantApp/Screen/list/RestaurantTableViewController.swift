//
//  RestaurantTableViewController.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-11.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var viewModels = [restaurantListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! restaurantTableViewCell

        let vm = viewModels[indexPath.row]
        cell.configure(with: vm)
        
        return cell
    }
    
}
