//
//  UITestKit_ExampleTests.swift
//  UITestKit_ExampleTests
//
//  Created by Eric Internicola on 11/5/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import SafariServices
import UITestKit
import XCTest

class UITestKit_ExampleTests: ExampleBaeUITest {
    
    override func setUp() {
        super.setUp()
        XCTAssertNotNil(myTabBarVC, "We couldn't find the root tab view")
    }
    
    override func tearDown() {
        super.tearDown()

        openCircleTab()
    }
    
}

// MARK: - Circle Tab

extension UITestKit_ExampleTests {

    func testOpenCircleTab() {
        XCTAssertNotNil(openCircleTab(), "Failed to open the Circle Tab.  We're at the \(topVCType)")

        // Pause, long enough to see it
        waitForDuration(1)
    }

    func testOpenSquareTab() {
        XCTAssertNotNil(openSquareTab(), "Failed to open the Square Tab.  We're at the \(topVCType)")

        // Pause, long enough to see it
        waitForDuration(1)
    }

}

// MARK: - Safari Tab (Modal VC)

extension UITestKit_ExampleTests {

    func testOpenSafariVC() {

        topVC?.present(SFSafariViewController(url: URL(string: "https://www.google.com")!), animated: true, completion: nil)

        XCTAssertTrue(waitForCondition({
            self.topVC is SFSafariViewController
        }, timeout: 5), "We didn't load an SFSafariViewController, instead it was a \(topVCType)")

        waitForDuration(2)

        (topVC as? SFSafariViewController)?.dismiss(animated: true, completion: nil)

        XCTAssertTrue(waitForCondition({
            !(self.topVC is SFSafariViewController)
        }, timeout: 5), "The SFSafariVC didn't dismiss")

    }

}
