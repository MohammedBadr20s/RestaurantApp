//
//  BaseView.swift
//  RestaurantApp
//
//  Created by Mohammed Badr on 2019-03-11.
//  Copyright © 2019 Mohammed Badr. All rights reserved.
//

import UIKit

@IBDesignable class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    func configure() {
        
    }
}
