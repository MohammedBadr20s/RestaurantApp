//
//  Models.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-12.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import Foundation

struct Root: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
    
}

struct restaurantListViewModel {
    let name: String
    let imageUrl: URL
    let distance: String
    let id: String
    
}

extension restaurantListViewModel {
    init(business: Business) {
        self.name = business.name
        self.id = business.id
        self.imageUrl = business.imageUrl
        self.distance = "\(business.distance / 1609.344)"
    }
}
