//
//  ExampleBaseUITest.swift
//  UITestKit_ExampleTests
//
//  Created by Eric Internicola on 11/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

@testable import UITestKit_Example
import UITestKit
import XCTest

class ExampleBaseUITest: UITestKitBase {

    /// Gets you the `MyTabBarVC` if it's visible
    var myTabBarVC: MyTabBarVC? {
        return tabBarVC as? MyTabBarVC
    }

    /// Gets you the `CircleTabVC` if it's the topVC
    var circleTabVC: CircleTabVC? {
        return topVC as? CircleTabVC
    }

    /// Gets you the `SquareTabVC` if it's the topVC
    var squareTabVC: SquareTabVC? {
        return topVC as? SquareTabVC
    }

    /// Gets the `ShapesTableViewController`
    var shapeTableVC: ShapesTableViewController? {
        return topVC as? ShapesTableViewController
    }

}

// MARK: - API

extension ExampleBaseUITest {

    @discardableResult
    /// Opens the Circle Tab.
    ///
    /// - Returns: The CircleTab if we were able to open it.
    func openCircleTab() -> CircleTabVC? {
        guard let myTabBarVC = myTabBarVC else {
            XCTFail(topVCScreenshot)
            return nil
        }

        myTabBarVC.selectedIndex = 0
        XCTAssertTrue(waitForCondition({ self.circleTabVC != nil }, timeout: 10), topVCScreenshot)

        return circleTabVC
    }

    @discardableResult
    /// Opens the Square Tab.
    ///
    /// - Returns: The SquareTab if we were able to open it.
    func openSquareTab() -> SquareTabVC? {
        guard let myTabBarVC = myTabBarVC else {
            XCTFail(topVCScreenshot)
            return nil
        }

        myTabBarVC.selectedIndex = 1
        XCTAssertTrue(waitForCondition({ self.squareTabVC != nil }, timeout: 10), topVCScreenshot)

        return squareTabVC
    }

    @discardableResult
    /// Opens the shape tab and hands you back the VC.
    ///
    /// - Returns: The `ShapesTableViewController`
    func openShapeTab() -> ShapesTableViewController? {
        guard let myTabBarVC = myTabBarVC else {
            XCTFail(topVCScreenshot)
            return nil
        }

        myTabBarVC.selectedIndex = 2
        XCTAssertTrue(waitForCondition({ self.shapeTableVC != nil}, timeout: 10), topVCScreenshot)

        return shapeTableVC
    }

}
