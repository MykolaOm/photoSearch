//
//  searchHistory.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/15/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import Foundation
import RealmSwift


class SearchHistory: Object {
    @objc dynamic var searchString = ""
    @objc dynamic var url = ""
    @objc dynamic var searchedImage: Data? = nil
}

