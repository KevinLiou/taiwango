//
//  twshoppingTests.swift
//  twshoppingTests
//
//  Created by Kevin on 2016/3/7.
//  Copyright © 2016年 KevinLiou. All rights reserved.
//

import XCTest
import Alamofire

@testable import twshopping

class twshoppingTests: XCTestCase {
    
    var didFinishedExpection:XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testAPI(){
        
        self.didFinishedExpection = self.expectationWithDescription("testAPI")
        
//        SPService.sharedInstance.requestAllAPIMessageWith(["language":1, "app_name":"twshopping_ios"]) { (response) in
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//                
//            }
//            
//            XCTAssertNotNil(response.result.value)
//            self.didFinishedExpection?.fulfill()
//        }
        
        self.waitForExpectationsWithTimeout(3.0, handler: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
