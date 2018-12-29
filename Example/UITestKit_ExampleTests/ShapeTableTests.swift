//
//  ShapeTableTests.swift
//  UITestKit_ExampleTests
//
//  Created by Eric Internicola on 12/29/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import UITestKit_Example
import XCTest

class ShapeTableTests: ExampleBaseUITest {

    override func setUp() {
        super.setUp()
        disableAnimations()
        shouldPauseUI = true
        pauseTimer = 0.3

        openCircleTab()
    }

    override func tearDown() {
        shouldPauseUI = false
        openCircleTab()
        enableAnimations()
        super.tearDown()
    }

    func testShapesTable() {
        openShapeTab()
        XCTAssertTrue(waitForCondition({ self.shapeTableVC != nil }, timeout: 1), topVCScreenshot)
        guard let shapeTableVC = shapeTableVC else {
            return XCTFail("No ShapeTableVC")
        }
        pauseForUIDebug()

        XCTAssertEqual(0, shapeTableVC.tableView.numberOfRows(inSection: 0), "Wrong number of rows")

        guard let rightButton = shapeTableVC.navigationItem.rightBarButtonItem else {
            return XCTFail("No right button or action")
        }

        for index in 0..<Shape.allCases.count {
            shapeTableVC.addShape(rightButton)
            XCTAssertEqual(index+1, shapeTableVC.tableView.numberOfRows(inSection: 0), topVCScreenshot)
            pauseForUIDebug()
        }

        for _ in 0..<5 {
            shapeTableVC.addShape(rightButton)
            XCTAssertEqual(Shape.allCases.count, shapeTableVC.tableView.numberOfRows(inSection: 0), topVCScreenshot)
        }
        pauseForUIDebug()
    }

}
