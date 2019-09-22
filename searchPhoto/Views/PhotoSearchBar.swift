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
        searchBarStyle = UISearchBar.Style.prominent
        placeholder = "Type here to search image..."
        sizeToFit()
        isTranslucent = false
        backgroundImage = UIImage()
    }
}
