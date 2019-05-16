//
//  AppBuilder.swift
//  Client
//
//  Created by Christian Ampe on 12/19/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import UIKit

final class AppBuilder {
    static func create(navigationController: UINavigationController?) {
        let presenter = AppPresenter()
        let interactor = AppInteractor()
        let router = AppRouter()
        
        interactor.presenter = presenter
        router.navigationController = navigationController
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.start()
    }
}
