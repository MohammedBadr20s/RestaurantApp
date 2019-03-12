//
//  restaurantTableViewCell.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-11.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import UIKit
import AlamofireImage

class restaurantTableViewCell: UITableViewCell {
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var makerImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure (with viewModel: restaurantListViewModel) {
        restaurantImageView.af_setImage(withURL: viewModel.imageUrl)
        restaurantNameLabel.text = viewModel.name
        locationLabel.text = viewModel.distance
    }

}
