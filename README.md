
<img src="https://github.com/intere/UITestKit/blob/master/Example/UITestKit/Media.xcassets/AppLogo.imageset/AppLogo.png?raw=true" width="150">

# UITestKit

### An iOS Library for UI Testing

## Features
- UI Testing from a vanilla `XCTest` target
    - Enable / Disable UI Animations
    - Take screenshots on test assertion failures
    - `waitForCondition` function to free up the UI thread and wait for your block condition to become true (or timeout and move on)
    - `pauseForUIDebug()` function to allow you to pause a (configurable) amount of time between steps in your tests
        - function becomes a no-op when `shouldPauseUI` is false (the default)
    - variables to get you the top view controller
- Example App to demonstrate capabilities

[![Build Status](https://travis-ci.org/intere/UITestKit.svg?branch=develop)](https://travis-ci.org/intere/UITestKit)
[![Documentation](https://intere.github.io/UITestKit/badge.svg)](https://intere.github.io/UITestKit/index.html)
[![Platform](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](http://cocoadocs.org/docsets/UITestKit)
[![CocoaPods](https://img.shields.io/cocoapods/v/UITestKit.svg)](https://cocoapods.org/pods/UITestKit)  
 [![CocoaPods](https://img.shields.io/cocoapods/dt/UITestKit.svg)](https://cocoapods.org/pods/UITestKit) [![CocoaPods](https://img.shields.io/cocoapods/dm/UITestKit.svg)](https://cocoapods.org/pods/UITestKit)

## Why not use XCUITests?
- UITestKit lets you interact with the application code directly from test code
    - Easier mocking of model objects
    - Easier invocation of ViewControllers
    - Lower level access to your application
- UITestKit provides convenience variables for taking screenshots from failures
- UITestKit can be far less rigid than XCUITests

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.
![Example Tests](https://user-images.githubusercontent.com/2284832/50541549-86a3e080-0b65-11e9-95d2-176b9ce3164b.gif)

## Requirements
- iOS 9.0 or higher

## Installation

UITestKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UITestKit'
```

### Code Examples

```swift
/// Pre-test initialization
override func setUp() {
    super.setUp()
    // Don't show view transitions - this will help prevent timing related failures
    disableAnimations()
    // pause when pauseForUIDebug() is called
    shouldPauseUI = true
    // how long to pause for when pauseForUIDebug() is called
    pauseTimer = 0.3

    // Now do other setup tasks
}
```

```swift
/// Tests logging in to the application
func testLoginSuccess() {

    // Verify that we're at the Main VC or fail and take a screenshot
    XCTAssertTrue(waitForCondition({ self.mainVC != nil }, timeout: 3), topVCScreenshot)
    pauseForUIDebug()
    mainVC?.loadEmailLoginScreen()

    // Verify that we're at the Sign in VC or fail and take a screenshot
    XCTAssertTrue(waitForCondition({ self.signInVC != nil}, timeout: 1), topVCScreenshot)
    pauseForUIDebug()

    // Simulate typing email
    if let emailText = signInVC?.emailText {
        emailText.text = "user@domain.com"
        pauseForUIDebug()
    }

    // simulate typing password
    if let passwordText = signInVC?.passwordText {
        passwordText.text = "UserPassword"
        pauseForUIDebug()
    }

    // log in
    signInVC?.login()

    // Verify that we've signed in successfully and are at the Welcome VC or fail and take a screenshot
    XCTAssertTrue(waitForCondition({ self.welcomeVC != nil}, timeout: 5), topVCScreenshot)
}
```

### Best Practices
- It is recommended to create a `BaseUITest` class that specializes `UITestKitBase` and provides convenience variables for your application's view controllers:

```swift
/// Gets you the `SquareTabVC` if it's the topVC
var squareTabVC: SquareTabVC? {
    return topVC as? SquareTabVC
}

/// Gets the `ShapesTableViewController`
var shapeTableVC: ShapesTableViewController? {
    return topVC as? ShapesTableViewController
}
```

- It is recommend that you use the screenshot capability when checking for specific UI's to be visible or in a specific UI state:

```swift
XCTAssertTrue(waitForCondition({ self.shapeTableVC != nil }, timeout: 1), topVCScreenshot)
```

`topVCScreenshot` will produce failures like this:

![Sample Test Failure with Screenshot](https://user-images.githubusercontent.com/2284832/50541750-3a5a9f80-0b69-11e9-9a49-1b14615e0d33.png)

`The Screenshot that is produce will look something like the following:`

<img src="https://user-images.githubusercontent.com/2284832/50541754-4f373300-0b69-11e9-9db8-f5f9e7a4b779.png" width="300">


## Author

[Eric Internicola](https://github.com/intere) | [Eric's Github Site](https://intere.github.io/)

## License

UITestKit is available under the MIT license. See the [LICENSE file](https://raw.githubusercontent.com/intere/UITestKit/master/LICENSE) for more info.
