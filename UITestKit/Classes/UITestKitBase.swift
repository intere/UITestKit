//
//  UITestKitBase.swift
//  UITestKit
//
//  Created by Eric Internicola on 11/5/17.
//

import Foundation
import UIKit
import XCTest

open class UITestKitBase: TestKitBase {

    /// Should the `pauseForUIDebug` function actually pause?
    /// This variable is useful for when you want to watch a UI Run
    open var shouldPauseUI = false

    /// If `shouldPauseUI` is enabled, this is how long a `pauseForUIDebug()` call lasts (in seconds).
    open var pauseTimer: TimeInterval = 0.5

    /// if `pauseForUIDebug` is enabled, then this will pause for `pauseTimer` seconds
    /// if not, then it is a no-op.
    open func pauseForUIDebug() {
        guard shouldPauseUI else {
            return
        }
        waitForDuration(pauseTimer)
    }

    /// Tells you the type of the top ViewController
    open var topVCType: String {
        guard let topVC = topVC else {
            return "No Top VC"
        }
        return String(describing: topVC.classForCoder)
    }

    /// Gets you the VC that is the currently visible VC (top)
    open var topVC: UIViewController? {
        return type(of: self).topVC
    }

    /// Takes a screenshot and returns the filename that it wrote to (which contains the topVCType)
    open var topVCScreenshot: String {
        guard let screenshot = UIApplication.shared.screenShot else {
            return topVCType
        }

        let time = Int(Date().timeIntervalSince1970 * 1000)
        let filename = "/tmp/\(topVCType)_\(time).png"

        do {
            guard let pngData = screenshot.pngData() else {
                return topVCType
            }
            try pngData.write(to: URL(fileURLWithPath: filename))
            return filename
        } catch {
            print("ERROR writing file \(filename): \(error.localizedDescription)")
        }

        return topVCType
    }

    /// Gets you a reference to the TabBarVC for the app (so you can set
    /// what tab is visible, get the currently presented VC, etc)
    open var tabBarVC: UITabBarController? {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }

        if let tabVC = rootVC as? UITabBarController {
            return tabVC
        }

        return nil
    }

    /// Gets you the VC that is the currently visible VC (top)
    open class var topVC:  UIViewController? {
        let visibleVC = getVisibleViewController()

        if let navVC = visibleVC as? UINavigationController {
            return navVC.topViewController
        }

        if let tabVC = visibleVC as? UITabBarController {
            if let navVC = tabVC.selectedViewController as? UINavigationController {
                return navVC.topViewController
            }
            return tabVC.selectedViewController
        }

        return visibleVC
    }

    /// Traverses the provided `rootViewController` to find the currently visible view controller.
    ///
    /// - Parameter rootViewController: The root Viewcontroller to search.
    /// - Returns: The currently visible ViewController if it could be determined.
    open class func getVisibleViewController(_ rootViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }

        if rootVC?.presentedViewController == nil {
            return rootVC
        }

        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return getVisibleViewController(navigationController.viewControllers.last!)
            }

            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }

            return getVisibleViewController(presented)
        }
        return nil
    }

    /// Disables UI Animations
    open func disableAnimations() {
        UIView.setAnimationsEnabled(false)
    }

    /// Enables UI Animations
    open func enableAnimations() {
        UIView.setAnimationsEnabled(true)
    }

    /// Modally presents the provided view controller (without animations).
    ///
    /// - Parameter viewController: The view controller you want to present.
    open func presentModally(viewController: UIViewController) {
        topVC?.present(viewController, animated: false)
    }

}

extension UIApplication {

    /// Takes a screenshot of the application.
    var screenShot: UIImage?  {
        return keyWindow?.layer.screenShot
    }
}

extension CALayer {

    /// Takes a screenshot of the layer.
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot
    }
}
