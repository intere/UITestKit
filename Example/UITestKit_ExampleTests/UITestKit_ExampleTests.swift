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

class UITestKit_ExampleTests: ExampleBaseUITest {
    
    override func setUp() {
        super.setUp()
        shouldPauseUI = true
        pauseTimer = 1

        XCTAssertNotNil(myTabBarVC, "We couldn't find the root tab view")
    }
    
    override func tearDown() {
        openCircleTab()
        super.tearDown()
    }
    
}

// MARK: - Circle Tab

extension UITestKit_ExampleTests {

    func testOpenCircleTab() {
        XCTAssertNotNil(openCircleTab(), topVCScreenshot)

        // Pause, long enough to see it
        pauseForUIDebug()
    }

    func testOpenSquareTab() {
        XCTAssertNotNil(openSquareTab(), topVCScreenshot)

        // Pause, long enough to see it
        pauseForUIDebug()
    }

}

// MARK: - Safari Tab (Modal VC)

extension UITestKit_ExampleTests {

    func testOpenSafariVC() {

        topVC?.present(SFSafariViewController(url: URL(string: "https://www.google.com")!), animated: true, completion: nil)

        XCTAssertTrue(waitForCondition({ self.topVC is SFSafariViewController }, timeout: 1), topVCScreenshot)
        pauseForUIDebug()

        (topVC as? SFSafariViewController)?.dismiss(animated: true, completion: nil)

        XCTAssertTrue(waitForCondition({ !(self.topVC is SFSafariViewController) }, timeout: 1), "The SFSafariVC didn't dismiss")

    }

}
