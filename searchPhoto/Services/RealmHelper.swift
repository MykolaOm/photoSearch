//
//  RealmHelper.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 9/19/19.
//  Copyright © 2019 Nikolas Omelianov. All rights reserved.
//

import RealmSwift

class RealmHelper {
    private init(){}
    static let shared = RealmHelper()
    
    func addItemToRealm(str:String,url: URL,data: Data) {
        guard let realm = try? Realm() else { return }
        let obj = SearchHistory()
        obj.searchString = str
        obj.url = String(describing: url)
        obj.searchedImage = data
        do {
            try? realm.write {
                realm.add([obj])
            }
        }
    }
}
