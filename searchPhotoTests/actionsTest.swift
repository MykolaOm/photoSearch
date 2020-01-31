//
//  actionsTest.swift
//  searchPhotoTests
//
//  Created by Nikolas Omelianov on 31.01.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

import XCTest
@testable import searchPhoto

class testii: XCTestCase {
    func testPri(){
        let b = TestMe()
        let str = b.pri(str: "soup")
        XCTAssertEqual( str, "soup")
    }
    func testBool(){
        XCTAssert(TestMe.getTrue(str: "ok"))
    }
    
    func testX(){
        let x = TestMe()
        let z = x.bilbo()
        XCTAssertEqual(z, "bilbo")
        XCTAssertEqual(z, "bilbo1")
    }
}

class actionsTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
