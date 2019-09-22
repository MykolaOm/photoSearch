//
//  StandartCell.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/22/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit

class StandartCell: CustomCellModel {
    
    var image: UIImage?
    var author: String
    
    var cellType: CustomCellType { return .standart }
    
    init(image: UIImage?, author: String) {
        self.image = image
        self.author = author
    }
}
