//
//  OneWayFlightViewCell.swift
//  Blubyn
//
//  Created by JOGENDRA on 05/02/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

class OneWayFlightViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialCellUISetups()
    }
    
    fileprivate func initialCellUISetups() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
    }

}
