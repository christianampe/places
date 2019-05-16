//
//  AppNavigationController.swift
//  Client
//
//  Created by Christian Ampe on 3/31/19.
//  Copyright © 2019 Educrate. All rights reserved.
//

import UIKit

final class AppNavigationController: UIClearNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        AppBuilder.create(navigationController: self)
    }
}
