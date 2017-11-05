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

class ExampleBaeUITest: UITestKitBase {

    /// Gets you the
    var myTabBarVC: MyTabBarVC? {
        return tabBarVC as? MyTabBarVC
    }

    var circleTabVC: CircleTabVC? {
        return topVC as? CircleTabVC
    }

    var squareTabVC: SquareTabVC? {
        return topVC as? SquareTabVC
    }

}

// MARK: - API

extension ExampleBaeUITest {

    @discardableResult
    /// Opens the Circle Tab.
    ///
    /// - Returns: The CircleTab if we were able to open it.
    func openCircleTab() -> CircleTabVC? {
        guard let myTabBarVC = myTabBarVC else {
            XCTFail("Failed to load the MyTabBarVC, we got \(topVCType) instead")
            return nil
        }

        myTabBarVC.selectedIndex = 0

        XCTAssertTrue(waitForCondition({
            self.circleTabVC != nil
        }, timeout: 10), "CircleTabVC failed to open, it was \(topVCType)")

        return circleTabVC
    }

    @discardableResult
    /// Opens the Square Tab.
    ///
    /// - Returns: The SquareTab if we were able to open it.
    func openSquareTab() -> SquareTabVC? {
        guard let myTabBarVC = myTabBarVC else {
            XCTFail("Failed to load the MyTabBarVC, we got \(topVCType) instead")
            return nil
        }

        myTabBarVC.selectedIndex = 1

        XCTAssertTrue(waitForCondition({
            self.squareTabVC != nil
        }, timeout: 10), "SquareTabVC failed to open, it was \(topVCType)")

        return squareTabVC
    }

}
