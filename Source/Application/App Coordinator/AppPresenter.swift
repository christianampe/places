//
//  AppPresenter.swift
//  Client
//
//  Created by Christian Ampe on 10/22/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import UIKit

final class AppPresenter: AppPresenterProtocol {
    var router: AppRouterProtocol?
    var interactor: AppInteractorProtocol?
}

extension AppPresenter {
    func start() {
        router?.presentHome(self, input: HomeInput())
    }
}

extension AppPresenter: HomeDelegateProtocol {}
