//
//  TestKitBase.swift
//  UITestKit
//
//  Created by Eric Internicola on 11/5/17.
//

import XCTest

/// A Base Class that provides some very basic functions for sleeping arbitrarily and waiting for a specific condition to occur (or timing out if that doesn't happen)
open class TestKitBase: XCTestCase {

    /// Waits for the desired amount of time (and frees up the UI thread while it waits)
    ///
    /// - Parameter timeout: The length of time to wait for
    public func waitForDuration(_ timeout: TimeInterval) {
        waitForCondition({ false }, timeout: timeout)
    }

    /// Waits for the provided condition block to evaluate to true, or the timeout amount of time to elapse.
    ///
    /// - Parameters:
    ///   - condition: The block to evaluate for truthy/falsy.
    ///   - timeout: The length of time to stop querying the block and just return false.
    /// - Returns: True if the block evaluated truthy in the allotted time, false otherwise.
    @discardableResult
    public func waitForCondition(_ condition: () -> Bool, timeout: TimeInterval) -> Bool {
        var done = false
        let startTime = NSDate()
        while !done {
            RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 0.1))

            done = condition()
            if done {
                break
            }

            if -startTime.timeIntervalSinceNow > timeout {
                return false
            }
        }
        return true
    }

}
