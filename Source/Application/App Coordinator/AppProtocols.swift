//
//  AppProtocols.swift
//  Client
//
//  Created by Christian Ampe on 10/22/18.
//  Copyright © 2018 Educrate. All rights reserved.
//

import Foundation

protocol AppPresenterProtocol: class {
    var router: AppRouterProtocol? { get set }
    var interactor: AppInteractorProtocol? { get set }
}

protocol AppInteractorProtocol: class {
    var presenter: AppPresenterProtocol?  { get set }
}

protocol AppRouterProtocol: class {
    func presentHome(_ delegate: HomeDelegateProtocol?,
                     input: HomeInputProtocol)
}
