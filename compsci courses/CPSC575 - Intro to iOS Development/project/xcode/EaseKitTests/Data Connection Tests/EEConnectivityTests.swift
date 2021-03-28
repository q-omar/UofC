//
//  EEConnectivityTests.swift
//  EaseKitTests
//
//  Created by Douglas Yuen on 2017-10-24.
//  Copyright © 2017 exdee. All rights reserved.
//

import XCTest

@testable import EaseKit

class EEConnectivityTests: XCTestCase
{
    
    var connectionTest:EEConnectivityChecker?
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        connectionTest = EEConnectivityChecker.init()
    }
    
    override func tearDown()
    {
        connectionTest = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConnectionExists()
    {
        let hasConnectionResultant = connectionTest?.isConnectionAvailble()
        XCTAssert(hasConnectionResultant == true, "Test computer is not connected to the internet")
    }

    
}
