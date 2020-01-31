//
//  testMe.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 31.01.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import Foundation

class TestMe {
    static func getTrue(str: String)->Bool {
        return(str is String)
    }
    func bilbo() -> String{
        return "bilbo"
    }
    func pri(str: String )-> String {
        return str
    }
    func rand()-> Int {
        return Int.random(in: 0...5)
    }
}
