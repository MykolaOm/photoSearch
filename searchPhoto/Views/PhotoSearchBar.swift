//
//  PhotoSearchBar.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/19/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import UIKit

class PhotoSearchBar: UISearchBar {
    func configure(){
        self.searchBarStyle = UISearchBar.Style.prominent
        self.placeholder = "Type here to search image..."
        self.sizeToFit()
        self.isTranslucent = false
        self.backgroundImage = UIImage()
    }
}
