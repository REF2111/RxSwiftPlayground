//
//  RxSwiftPlaygroundTests.swift
//  RxSwiftPlaygroundTests
//
//  Created by Raphael Berendes on 30.05.19.
//  Copyright © 2019 Raphael Berendes. All rights reserved.
//

import XCTest

import RxBlocking
import RxSwift
import RxTest

class RxSwiftPlaygroundTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private var testData: Observable<String> {
        return Observable.of("Hello", "Bye")
    }

    func testExample() {

        // Arrange
        let expectedResult = ["Hello", "Bye"]
        
        // Act
        let result = testData
            .toBlocking()
            .materialize()
        
        // Assert
        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements, expectedResult)
        case .failed(_, let error):
            XCTFail("Expected result to complete without error, but received \(error).")
        }
    }

}
