//
//  PhotoActivityIndicator.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/19/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit

class PhotoActivityIndicator: UIActivityIndicatorView {
    func configure(center: CGPoint) {
        style = .gray
        hidesWhenStopped = true
        self.center = center
    }
}
