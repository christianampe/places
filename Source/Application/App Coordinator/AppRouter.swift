//
//  AppRouter.swift
//  Client
//
//  Created by Christian Ampe on 10/22/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import UIKit

final class AppRouter: AppRouterProtocol {
    weak var navigationController: UINavigationController?
}

extension AppRouter {
    func presentHome(_ delegate: HomeDelegateProtocol?, input: HomeInputProtocol) {
        navigationController?.setViewControllers([HomeBuilder.create(delegate,
                                                                     input: input)],
                                                 animated: true)
    }
}
