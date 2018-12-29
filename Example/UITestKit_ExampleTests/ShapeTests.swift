//
//  ShapeTests.swift
//  UITestKit_ExampleTests
//
//  Created by Eric Internicola on 12/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import UITestKit_Example
import XCTest

class ShapeTests: XCTestCase {

    func testShapeImages() {
        for shape in Shape.allCases {
            XCTAssertNotNil(shape.image, "\(shape) does not have an image")
        }
    }

}
