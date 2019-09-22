//
//  PhotoTableCells.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/22/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit

enum CustomCellType: String {
    case photo
    case standart
    case profile
    case description
    case comment
    case image
}

class PhotoCell: UITableViewCell, CustomCell {
    var model: StandartCell!
    func configure(withModel elementModel: CustomCellModel) {
        guard let model = elementModel as? StandartCell else {
            print("Unable to cast model as ProfileElement: \(elementModel)")
            return
        }
        self.model = model
        
        configureUI()
    }
    
    func configureUI() {
        self.textLabel?.text = model.author
        self.imageView?.image = model.image
        //Configure UI elements...
    }
}
