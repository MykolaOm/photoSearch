//
//  CustomCellProtocols.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/22/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit

protocol CustomCell:class {
    func configure(withModel: CustomCellModel)
}
protocol CustomCellModel: class {
    var cellType: CustomCellType { get }
}

extension CustomCellModel {
    func getCellType() -> String {
        return String(describing: self)
    }
}
