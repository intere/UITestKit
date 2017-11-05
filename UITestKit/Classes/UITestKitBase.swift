//
//  UITestKitBase.swift
//  UITestKit
//
//  Created by Eric Internicola on 11/5/17.
//

import XCTest

open class UITestKitBase: TestKitBase {

    /// Tells you the type of the top ViewController
    public var topVCType: String {
        guard let topVC = topVC else {
            return "No Top VC"
        }
        return String(describing: topVC.classForCoder)
    }

    /// Gets you the VC that is the currently visible VC (top)
    public var topVC: UIViewController? {
        return type(of: self).topVC
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
    public static var topVC:  UIViewController? {
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
    public static func getVisibleViewController(_ rootViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

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

}
