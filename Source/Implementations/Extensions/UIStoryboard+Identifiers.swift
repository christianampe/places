//
//  UIStoryboard+Identifiers.swift
//  Client
//
//  Created by Christian Ampe on 10/14/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import UIKit.UIStoryboard

// MARK: - Storyboard Conformance
extension UIStoryboard {
    enum Storyboard: String {
        case appLaunch = "AppLaunch"
        case app = "App"
        case home = "Home"
        case detail = "Detail"
        case profile = "Profile"
    }
}

// MARK: - Convenience Initializers
extension UIStoryboard {
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
}

// MARK: - Class Functions
extension UIStoryboard {
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
}
